import React, { useState, useRef, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';
import useSWR from 'swr';
import { vocabApi } from '../services/vocab';
import confetti from 'canvas-confetti';
import { useAuthStore } from '../store/authStore';
import { Volume2 } from 'lucide-react';

const Practice: React.FC = () => {
    const { id } = useParams<{ id: string }>();
    const [currentIndex, setCurrentIndex] = useState(0);
    const [inputVal, setInputVal] = useState('');
    const [errorShake, setErrorShake] = useState(false);
    const [isHardMode, setIsHardMode] = useState(false);

    const { data: vocabularies, isLoading: loading } = useSWR(
        id ? `/topics/${id}/practice` : null,
        () => vocabApi.getTopicPractice(Number(id))
    );

    const startTimeRef = useRef<number>(0);

    // Initialize start time when vocabularies are loaded
    useEffect(() => {
        if (vocabularies && vocabularies.length > 0 && startTimeRef.current === 0) {
            startTimeRef.current = Date.now();
        }
    }, [vocabularies]);

    if (loading) return <div className="text-center mt-20">Loading...</div>;
    if (!vocabularies || vocabularies.length === 0) return <div className="text-center mt-20">No words found.</div>;

    const currentVocab = vocabularies[currentIndex];

    // Safety guard during re-renders or out-of-bounds index
    if (!currentVocab) return <div className="text-center mt-20">Loading next word...</div>;

    const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        const val = e.target.value.toLowerCase();
        setInputVal(val);

        if (val === currentVocab.word.toLowerCase()) {
            handleCorrect();
        } else if (val.length === currentVocab.word.length) {
            handleWrong();
        }
    };

    const playAudio = () => {
        const utterance = new SpeechSynthesisUtterance(currentVocab.word);
        utterance.lang = 'en-US';
        window.speechSynthesis.speak(utterance);
    };

    const handleCorrect = () => {
        confetti({ particleCount: 150, spread: 70, origin: { y: 0.6 } });
        const responseTime = Date.now() - startTimeRef.current;

        // Play audio
        const utterance = new SpeechSynthesisUtterance(currentVocab.word);
        utterance.lang = 'en-US';
        window.speechSynthesis.speak(utterance);

        // Save progress
        vocabApi.updateProgress(currentVocab.id, true, responseTime).catch(console.error);

        // Auto-update user XP local state safely
        useAuthStore.setState(state => {
            if (state.user) {
                let newXp = state.user.totalXp + 10;
                return { user: { ...state.user, totalXp: newXp, level: Math.floor(Math.sqrt(newXp / 100)) || 1 } };
            }
            return state;
        });

        setTimeout(() => {
            if (currentIndex < vocabularies.length - 1) {
                setCurrentIndex(c => c + 1);
                setInputVal('');
                startTimeRef.current = Date.now();
            }
        }, 1500);
    };

    const handleWrong = () => {
        setErrorShake(true);
        setTimeout(() => setErrorShake(false), 500);
        const responseTime = Date.now() - startTimeRef.current;
        vocabApi.updateProgress(currentVocab.id, false, responseTime).catch(console.error);
    };

    const getMaskedWord = (word: string) => {
        if (isHardMode) return '_ '.repeat(word.length).trim();
        // Fill missing letters: Show first and last, hide middle
        if (word.length <= 2) return word;
        return word[0] + ' _ '.repeat(word.length - 2) + word[word.length - 1];
    };

    const isFinished = currentIndex >= vocabularies.length - 1 && inputVal === currentVocab.word.toLowerCase();

    return (
        <div className="min-h-screen bg-gradient-to-br from-indigo-50 to-blue-100 flex items-center justify-center p-6">
            <div className="max-w-xl w-full bg-white rounded-3xl shadow-xl p-8 relative overflow-hidden">

                {isFinished ? (
                    <div className="text-center py-10">
                        <h2 className="text-4xl font-black text-green-500 mb-4">Awesome! 🎉</h2>
                        <p className="text-gray-600 text-lg mb-8">You've completed this practice session.</p>
                        <Link to="/topics" className="bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-8 rounded-full shadow-lg transition">Back to Topics</Link>
                    </div>
                ) : (
                    <>
                        <div className="flex justify-between items-center mb-8">
                            <div className="text-blue-500 font-bold bg-blue-50 px-3 py-1 rounded-lg">
                                Word {currentIndex + 1} of {vocabularies.length}
                            </div>
                            <button
                                onClick={() => setIsHardMode(!isHardMode)}
                                className={`text-sm font-bold px-3 py-1 rounded-lg transition-colors ${isHardMode ? 'bg-red-100 text-red-600' : 'bg-gray-100 text-gray-500 hover:bg-gray-200'}`}
                            >
                                {isHardMode ? '🔥 Hard Mode ON' : 'Easy Mode'}
                            </button>
                        </div>

                        <div className={`text-center transition-transform ${errorShake ? 'animate-bounce' : ''}`}>
                            <div className="text-gray-500 text-lg font-medium mb-2 opacity-80 uppercase tracking-widest">Type the word</div>
                            <div className="flex items-center justify-center gap-4 mb-8">
                                <div className="text-4xl md:text-5xl font-black text-gray-800 tracking-wider">
                                    {inputVal ? inputVal : getMaskedWord(currentVocab.word)}
                                </div>
                                <button
                                    onClick={playAudio}
                                    className="p-3 bg-blue-100 text-blue-600 rounded-full hover:bg-blue-200 transition-colors"
                                    title="Listen to pronunciation"
                                >
                                    <Volume2 size={28} />
                                </button>
                            </div>

                            <p className="text-xl text-indigo-900 font-medium mb-6 bg-indigo-50 py-3 rounded-xl border border-indigo-100">
                                {currentVocab.meaning}
                            </p>

                            <input
                                type="text"
                                autoFocus
                                value={inputVal}
                                onChange={handleInputChange}
                                className={`w-full text-center text-3xl font-bold p-4 border-2 rounded-2xl outline-none transition-all
                  ${errorShake ? 'border-red-500 bg-red-50 text-red-600' : 'border-gray-200 focus:border-blue-500 focus:ring-4 focus:ring-blue-100'}`}
                                placeholder="Type here..."
                                maxLength={currentVocab.word.length}
                            />
                        </div>
                    </>
                )}
            </div>
        </div>
    );
};

export default Practice;
