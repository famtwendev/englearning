import React, { useState, useRef, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';
import useSWR from 'swr';
import { vocabApi } from '../services/vocab';
import confetti from 'canvas-confetti';
import { useAuthStore } from '../store/authStore';
import { Volume2, ArrowRight } from 'lucide-react';

const Practice: React.FC = () => {
    const { id } = useParams<{ id: string }>();
    const [currentIndex, setCurrentIndex] = useState(0);
    const [inputVal, setInputVal] = useState('');
    const [isHardMode, setIsHardMode] = useState(false);
    const [score, setScore] = useState(0);
    const [showResult, setShowResult] = useState(false);
    const [maskedIndices, setMaskedIndices] = useState<number[]>([]);

    const { data: vocabularies, isLoading: loading } = useSWR(
        id ? `/topics/${id}/practice` : null,
        () => vocabApi.getTopicPractice(Number(id))
    );

    const startTimeRef = useRef<number>(0);

    useEffect(() => {
        if (vocabularies && vocabularies.length > 0 && startTimeRef.current === 0) {
            startTimeRef.current = Date.now();
        }
    }, [vocabularies]);

    useEffect(() => {
        if (vocabularies && vocabularies[currentIndex]) {
            const word = vocabularies[currentIndex].word;
            if (isHardMode) {
                setMaskedIndices(Array.from({ length: word.length }, (_, i) => i));
            } else {
                // Hide 30% - 50% of the letters
                const hidePercentage = Math.random() * 0.2 + 0.3;
                const hideCount = Math.max(1, Math.floor(word.length * hidePercentage));
                const indices = new Set<number>();
                while (indices.size < hideCount && indices.size < word.length) {
                    indices.add(Math.floor(Math.random() * word.length));
                }
                setMaskedIndices(Array.from(indices));
            }
        }
    }, [currentIndex, isHardMode, vocabularies]);

    if (loading) return <div className="text-center mt-20">Loading...</div>;
    if (!vocabularies || vocabularies.length === 0) return <div className="text-center mt-20">No words found.</div>;

    const isFinished = currentIndex >= vocabularies.length;

    if (isFinished) {
        return (
            <div className="min-h-screen bg-gradient-to-br from-indigo-50 to-blue-100 flex items-center justify-center p-6">
                <div className="max-w-xl w-full bg-white rounded-3xl shadow-xl p-8 relative overflow-hidden text-center">
                    <h2 className="text-4xl font-black text-indigo-600 mb-4">Quiz Completed! 🎉</h2>
                    <div className="text-6xl font-black text-blue-500 mb-6 drop-shadow-md">
                        {score} / {vocabularies.length}
                    </div>
                    <p className="text-gray-600 text-lg mb-8 font-medium">
                        {score === vocabularies.length ? "Perfect Score! You're amazing!" : "Great effort! Keep practicing."}
                    </p>
                    <Link to="/topics" className="bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-8 rounded-full shadow-lg transition inline-flex items-center gap-2">
                        Back to Topics <ArrowRight size={20} />
                    </Link>
                </div>
            </div>
        );
    }

    const currentVocab = vocabularies[currentIndex];

    const submitAnswer = () => {
        if (showResult) return;
        const isCorrect = inputVal.toLowerCase() === currentVocab.word.toLowerCase();

        setShowResult(true);

        const responseTime = Date.now() - startTimeRef.current;

        if (isCorrect) {
            setScore(s => s + 1);
            confetti({ particleCount: 150, spread: 70, origin: { y: 0.6 } });
            vocabApi.updateProgress(currentVocab.id, true, responseTime).catch(console.error);

            useAuthStore.setState(state => {
                if (state.user) {
                    let newXp = state.user.totalXp + 10;
                    return { user: { ...state.user, totalXp: newXp, level: Math.floor(Math.sqrt(newXp / 100)) || 1 } };
                }
                return state;
            });
        } else {
            vocabApi.updateProgress(currentVocab.id, false, responseTime).catch(console.error);
        }

        const utterance = new SpeechSynthesisUtterance(currentVocab.word);
        utterance.lang = 'en-US';
        window.speechSynthesis.speak(utterance);

        setTimeout(() => {
            setCurrentIndex(c => c + 1);
            setInputVal('');
            setShowResult(false);
            startTimeRef.current = Date.now();
        }, 1500); // 1.5 seconds delay so user can see correct/incorrect state
    };

    const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        if (showResult) return;
        const val = e.target.value.toLowerCase().replace(/[^a-z0-9 -]/g, '');

        if (val.length <= currentVocab.word.length) {
            setInputVal(val);
        }

        // Auto submit if the user typed the exact length of the original word
        if (val.length === currentVocab.word.length) {
            // Wait slightly for state to update
            setTimeout(() => setInputVal(val), 0);
        }
    };

    // Auto-trigger submit hook because state needs to be fresh
    useEffect(() => {
        if (currentVocab && inputVal.length === currentVocab.word.length && !showResult) {
            submitAnswer();
        }
    }, [inputVal, currentVocab, showResult]);

    const handleKeyDown = (e: React.KeyboardEvent<HTMLInputElement>) => {
        if (e.key === 'Enter' && inputVal.length > 0 && !showResult) {
            submitAnswer();
        }
    };

    const playAudio = () => {
        const utterance = new SpeechSynthesisUtterance(currentVocab.word);
        utterance.lang = 'en-US';
        window.speechSynthesis.speak(utterance);
    };

    // Construct the segmented display
    const renderWordBlocks = () => {
        const chars = currentVocab.word.split('');
        return (
            <div className="flex flex-wrap gap-2 justify-center items-center mb-8 relative px-4">
                {chars.map((char, index) => {
                    const typedChar = inputVal[index];
                    const isMasked = maskedIndices.includes(index);

                    let displayChar = !isMasked ? char : '_';
                    let colorClass = 'text-gray-300';
                    let borderColor = 'border-transparent';

                    if (showResult) {
                        const isUltimatelyCorrect = inputVal.toLowerCase() === currentVocab.word.toLowerCase();
                        if (isUltimatelyCorrect) {
                            displayChar = char;
                            colorClass = 'text-green-500 font-black';
                        } else {
                            if (typedChar) {
                                displayChar = typedChar;
                                const isMatch = typedChar.toLowerCase() === char.toLowerCase();
                                colorClass = isMatch ? 'text-green-500 font-bold' : 'text-red-500 font-bold opacity-90';
                                if (!isMatch) borderColor = 'border-red-200';
                            } else {
                                displayChar = char;
                                colorClass = 'text-red-400 font-bold opacity-60';
                            }
                        }
                    } else {
                        // While typing
                        if (typedChar) {
                            displayChar = typedChar;
                            const isMatch = typedChar.toLowerCase() === char.toLowerCase();
                            colorClass = isMatch ? 'text-green-500 font-bold' : 'text-red-500 font-bold';
                            if (!isMatch) borderColor = 'border-red-200';
                        } else if (!isMasked) {
                            colorClass = 'text-gray-800 font-bold';
                        }
                    }

                    return (
                        <div key={index} className={`flex flex-col items-center bg-white rounded-lg p-2 min-w-[3rem] min-h-[4rem] justify-center border-b-4 ${borderColor} ${showResult && typedChar && typedChar.toLowerCase() !== char.toLowerCase() ? 'bg-red-50' : 'bg-gray-50'} transition-all shadow-sm`}>
                            <span className={`text-3xl md:text-4xl uppercase tracking-widest ${colorClass}`}>
                                {displayChar}
                            </span>
                            {/* Show tiny correction below if wrong */}
                            {showResult && typedChar && typedChar.toLowerCase() !== char.toLowerCase() && (
                                <span className="text-green-600 font-bold text-xs uppercase absolute -bottom-5">
                                    {char}
                                </span>
                            )}
                        </div>
                    );
                })}

                <button
                    onClick={playAudio}
                    className="ml-4 p-3 bg-blue-100 text-blue-600 rounded-full hover:bg-blue-200 transition-colors shadow-sm"
                    title="Listen to pronunciation"
                >
                    <Volume2 size={24} />
                </button>
            </div>
        );
    };

    return (
        <div className="min-h-screen bg-gradient-to-br from-indigo-50 to-blue-100 flex items-center justify-center p-6">
            <div className="max-w-2xl w-full bg-white rounded-3xl shadow-xl p-8 relative overflow-hidden">
                <div className="flex justify-between items-center mb-8">
                    <div className="flex items-center gap-4">
                        <div className="text-blue-600 font-black bg-blue-50 border border-blue-100 px-4 py-2 rounded-xl shadow-sm">
                            Score: {score} / {vocabularies.length}
                        </div>
                        <div className="text-gray-500 text-sm font-bold uppercase tracking-wider">
                            Word {currentIndex + 1}
                        </div>
                    </div>
                    <button
                        onClick={() => { setIsHardMode(!isHardMode); setInputVal(''); }}
                        className={`text-sm font-bold px-4 py-2 rounded-xl transition-all shadow-sm ${isHardMode ? 'bg-red-100 text-red-600 border border-red-200' : 'bg-gray-50 text-gray-600 hover:bg-gray-100 border border-gray-200'}`}
                        disabled={showResult}
                    >
                        {isHardMode ? '🔥 Hard Mode ON' : 'Easy Mode'}
                    </button>
                </div>

                <div className="text-center">
                    <div className={`text-sm font-bold mb-4 uppercase tracking-widest inline-block px-3 py-1 rounded-full ${showResult ? (inputVal.toLowerCase() === currentVocab.word.toLowerCase() ? 'bg-green-100 text-green-600' : 'bg-red-100 text-red-600') : 'text-gray-400'}`}>
                        {showResult ? (inputVal.toLowerCase() === currentVocab.word.toLowerCase() ? '✓ Correct!' : '✗ Incorrect!') : 'Type the missing letters'}
                    </div>

                    {renderWordBlocks()}

                    <p className="text-xl text-indigo-900 font-medium mb-8 bg-indigo-50 py-4 px-6 rounded-2xl border border-indigo-100">
                        {currentVocab.meaning}
                    </p>

                    <input
                        type="text"
                        autoFocus
                        value={inputVal}
                        onChange={handleInputChange}
                        onKeyDown={handleKeyDown}
                        disabled={showResult}
                        className={`w-full text-center text-2xl font-bold p-4 border-2 rounded-2xl outline-none transition-all
                            ${showResult
                                ? (inputVal.toLowerCase() === currentVocab.word.toLowerCase() ? 'border-green-500 bg-green-50 text-green-600' : 'border-red-500 bg-red-50 text-red-600')
                                : 'border-gray-200 focus:border-blue-500 focus:ring-4 focus:ring-blue-100 text-gray-700'}`}
                        placeholder="Type the full word here..."
                        maxLength={currentVocab.word.length}
                    />
                </div>
            </div>
        </div>
    );
};

export default Practice;
