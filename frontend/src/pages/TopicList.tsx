import React from 'react';
import { Link } from 'react-router-dom';
import useSWR from 'swr';
import { vocabApi } from '../services/vocab';

const TopicList: React.FC = () => {
    const { data: topics, isLoading: loading } = useSWR('/topics', vocabApi.getTopics);

    if (loading) {
        return <div className="min-h-screen flex justify-center items-center bg-gray-50 text-xl font-medium text-gray-500">Loading topics...</div>;
    }

    if (!topics) {
        return <div className="min-h-screen flex justify-center items-center bg-gray-50 text-xl font-medium text-red-500">Failed to load topics.</div>;
    }

    return (
        <div className="min-h-screen bg-gray-50 px-6 pb-6">
            <div className="max-w-4xl mx-auto">
                <div className="sticky top-[65px] z-40 flex justify-between items-center bg-gradient-to-r from-sky-500 to-indigo-600 pt-6 pb-5 px-6 sm:px-8 mb-8 shadow-md shadow-indigo-500/20 border-b border-indigo-700/50 sm:rounded-b-2xl transform-gpu -mx-6 sm:mx-0 relative">
                    <Link
                        to="/"
                        className="py-2 px-6 text-sm font-bold rounded-lg text-white bg-rose-500 border-2 border-rose-500 shadow-sm hover:bg-orange-500 hover:text-white hover:shadow-md transition z-10"
                    >
                        ← Back
                    </Link>

                    {/* Title perfectly centered */}
                    <div className="absolute inset-x-0 flex justify-center pointer-events-none mt-1">
                        <h1 className="px-8 py-2 text-3xl font-extrabold text-white tracking-wide drop-shadow-md pointer-events-auto">
                            Topics
                        </h1>
                    </div>

                    {/* Empty placeholder to balance flex-between */}
                    <div className="w-24"></div>
                </div>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                    {topics.map(topic => (
                        <div key={topic.id} className="flex flex-col bg-white p-6 border-2 border-[#e8e8e8]  rounded-2xl shadow-sm hover:shadow-md transition-shadow ">
                            <div className="flex justify-between items-start mb-4">
                                <h2 className="text-xl font-bold text-red-500 capitalize">{topic.name}</h2>
                                <span className={`text-xs px-2 py-1 rounded-full font-bold uppercase tracking-wide
                    ${topic.difficulty === 'hard' ? 'bg-red-100 text-red-700' :
                                        topic.difficulty === 'medium' ? 'bg-yellow-100 text-yellow-700' : 'bg-green-100 text-green-700'}`}>
                                    {topic.difficulty}
                                </span>
                            </div>
                            <p className="text-gray-700 mb-6 flex-grow">{topic.description}</p>
                            <div className="flex gap-4">
                                <Link to={`/topics/${topic.id}/theory`} className="flex-1 bg-blue-50 text-blue-600 hover:bg-blue-100 font-semibold py-2 rounded-lg text-center transition-colors">
                                    Learn
                                </Link>
                                <Link to={`/topics/${topic.id}/practice`} className="flex-1 bg-indigo-50 text-indigo-600 hover:bg-indigo-100 font-semibold py-2 rounded-lg text-center transition-colors">
                                    Quiz
                                </Link>
                            </div>
                        </div>
                    ))}
                </div>
            </div>
        </div>
    );
};

export default TopicList;
