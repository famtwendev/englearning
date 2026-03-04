import React from 'react';
import { useParams, Link } from 'react-router-dom';
import useSWR from 'swr';
import { vocabApi } from '../services/vocab';
import { Volume2, Star } from 'lucide-react';

const Theory: React.FC = () => {
    const { id } = useParams<{ id: string }>();

    const { data: topic, isLoading: topicLoading } = useSWR(
        id ? `/topics/${id}` : null,
        () => vocabApi.getTopicDetails(Number(id))
    );

    const { data: vocabularies, isLoading: vocabLoading } = useSWR(
        id ? `/topics/${id}/practice` : null,
        () => vocabApi.getTopicPractice(Number(id))
    );

    const playAudio = (text: string) => {
        const utterance = new SpeechSynthesisUtterance(text);
        utterance.lang = 'en-US';
        window.speechSynthesis.speak(utterance);
    };

    if (topicLoading || vocabLoading) return <div className="text-center mt-20">Loading...</div>;
    if (!topic || !vocabularies) return <div className="text-center mt-20">Topic not found</div>;

    return (
        <div className="min-h-screen bg-gray-50 p-6">
            <div className="max-w-4xl mx-auto">
                <div className="mb-6 flex justify-between items-center">
                    <div>
                        <Link to="/topics" className="text-blue-500 font-semibold hover:underline mr-4">← Back</Link>
                        <h1 className="text-3xl font-bold inline">{topic.name} - Theory</h1>
                    </div>
                    <Link to={`/topics/${topic.id}/practice`} className="bg-indigo-500 hover:bg-indigo-600 text-white font-bold py-2 px-6 rounded-full shadow-lg transition">
                        Start Practice 🚀
                    </Link>
                </div>

                <div className="space-y-6">
                    {vocabularies.map((vocab) => (
                        <div key={vocab.id} className="bg-white rounded-2xl shadow p-6 flex items-start gap-6 border border-gray-100 hover:border-blue-200 transition">
                            <button
                                onClick={() => playAudio(vocab.word)}
                                className="w-14 h-14 bg-blue-50 text-blue-500 rounded-full flex items-center justify-center hover:bg-blue-100 hover:scale-105 transition flex-shrink-0"
                            >
                                <Volume2 size={24} strokeWidth={2.5} />
                            </button>
                            <div className="flex-1">
                                <div className="flex items-center gap-3 mb-1">
                                    <h2 className="text-2xl font-bold text-gray-800">{vocab.word}</h2>
                                    <span className="text-sm text-pink-500 bg-gray-100 rounded-full lowercase shadow-md px-2 py-0.5 font-bold">( {vocab.partOfSpeech} )</span>
                                    <span className="text-blue-600 ">{vocab.ipa}</span>
                                </div>
                                <p className="text-lg text-gray-700 font-medium mb-3">{vocab.meaning}</p>
                                <div className="bg-gray-50 p-3 rounded-lg border border-gray-100 text-fuchsia-700 italic">
                                    "{vocab.example}"
                                </div>
                            </div>
                            <button className="text-gray-300 hover:text-yellow-400 hover:scale-110 transition bg-transparent border-none outline-none" title="Add to favorites">
                                <Star size={28} fill="currentColor" strokeWidth={1} />
                            </button>
                        </div>
                    ))}
                </div>
            </div>
        </div>
    );
};

export default Theory;
