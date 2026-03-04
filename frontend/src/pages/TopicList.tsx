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
        <div className="min-h-screen bg-gray-50 p-6">
            <div className="max-w-4xl mx-auto">
                <div className="relative mb-8 flex items-center justify-center">
                    <Link to="/" className="absolute left-0 px-4 py-2 text-sm font-semibold rounded-lg shadow text-orange-400 border border-orange-400  shadow-lg hover:bg-orange-400 hover:text-white transition">← Back</Link>

                    {/* Title */}
                    <h1 className="inline-block px-8 py-3 text-3xl font-bold text-white bg-gradient-to-r from-blue-500 to-indigo-600 rounded-2xl shadow-lg">
                        Topics
                    </h1>

                </div>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                    {topics.map(topic => (
                        <div key={topic.id} className="bg-white rounded-2xl shadow-sm hover:shadow-md transition-shadow p-6 border border-gray-100 flex flex-col">
                            <div className="flex justify-between items-start mb-4">
                                <h2 className="text-xl font-bold text-red-500">{topic.name}</h2>
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
