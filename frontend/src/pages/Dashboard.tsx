import React from 'react';
import { useAuthStore } from '../store/authStore';
import { Link } from 'react-router-dom';

const Dashboard: React.FC = () => {
    const user = useAuthStore((state) => state.user);

    if (!user) {
        return <div>Loading user profile...</div>;
    }

    // Fallback defaults if gamification isn't set
    const level = user.level ?? 1;
    const totalXp = user.totalXp ?? 0;
    const streak = user.streak ?? 0;

    // Calculate next level threshold
    const xpForNextLevel = Math.pow(level + 1, 2) * 100;
    const progressPercent = Math.min(100, (totalXp / xpForNextLevel) * 100);

    return (
        <div className="min-h-screen bg-gray-50 flex flex-col items-center p-6">
            <div className="max-w-4xl w-full bg-white shadow-xl rounded-2xl p-8 transform transition duration-500">
                <div className="flex justify-between items-center border-b pb-6 mb-6">
                    <h1 className="text-3xl font-extrabold text-blue-900 tracking-tight">
                        Welcome back, {user.firstName || 'Learner'}! 👋
                    </h1>
                </div>

                {/* Highlight Stats Row */}
                <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-10">
                    <div className="bg-gradient-to-br from-blue-500 to-indigo-600 rounded-xl p-6 text-white shadow-lg transform hover:-translate-y-1 transition-transform">
                        <h3 className="text-blue-100 font-semibold mb-1 text-sm uppercase tracking-wider">Current Level</h3>
                        <div className="text-5xl font-black">Lvl {level}</div>
                        <div className="mt-4 bg-white/30 rounded-full h-2 overflow-hidden">
                            <div className="bg-white h-2 rounded-full" style={{ width: `${progressPercent}%` }}></div>
                        </div>
                        <p className="text-xs text-blue-100 mt-2">{totalXp} / {xpForNextLevel} XP to next level</p>
                    </div>

                    <div className="bg-gradient-to-br from-orange-400 to-red-500 rounded-xl p-6 text-white shadow-lg transform hover:-translate-y-1 transition-transform">
                        <h3 className="text-orange-100 font-semibold mb-1 text-sm uppercase tracking-wider">Day Streak</h3>
                        <div className="text-5xl font-black flex items-center gap-2">
                            🔥 {streak}
                        </div>
                        <p className="text-xs text-orange-100 mt-4">Keep it up! Practice today to hold your streak.</p>
                    </div>

                    <div className="bg-gradient-to-br from-purple-500 to-fuchsia-600 rounded-xl p-6 text-white shadow-lg transform hover:-translate-y-1 transition-transform">
                        <h3 className="text-purple-100 font-semibold mb-1 text-sm uppercase tracking-wider">Total XP</h3>
                        <div className="text-5xl font-black flex items-center gap-2">
                            ✨ {totalXp}
                        </div>
                        <p className="text-xs text-purple-100 mt-4">Every correct answer adds 10 XP.</p>
                    </div>
                </div>

                <div className="mt-8">
                    <h2 className="text-2xl font-bold text-gray-800 mb-4">Let's start learning</h2>
                    <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                        <Link to="/topics" className="block text-center bg-blue-50 hover:bg-blue-100 border border-blue-200 text-blue-700 rounded-xl p-6 font-semibold transition-colors duration-200">
                            📚 Browse Vocabulary Topics
                        </Link>
                        <div className="block text-center bg-gray-50 hover:bg-gray-100 border border-gray-200 text-gray-500 cursor-not-allowed rounded-xl p-6 font-semibold transition-colors duration-200 relative group">
                            🎙️ Speaking Practice
                            <span className="absolute top-2 right-2 text-[10px] bg-gray-200 text-gray-600 px-2 py-1 rounded">Locked</span>
                        </div>
                        <div className="block text-center bg-gray-50 hover:bg-gray-100 border border-gray-200 text-gray-500 cursor-not-allowed rounded-xl p-6 font-semibold transition-colors duration-200 relative group">
                            ✍ Writing Practice
                            <span className="absolute top-2 right-2 text-[10px] bg-gray-200 text-gray-600 px-2 py-1 rounded">Locked</span>
                        </div>
                        <div className="block text-center bg-gray-50 hover:bg-gray-100 border border-gray-200 text-gray-500 cursor-not-allowed rounded-xl p-6 font-semibold transition-colors duration-200 relative group">
                            🎧 Listening Practice
                            <span className="absolute top-2 right-2 text-[10px] bg-gray-200 text-gray-600 px-2 py-1 rounded">Locked</span>
                        </div>
                        <div className="block text-center bg-gray-50 hover:bg-gray-100 border border-gray-200 text-gray-500 cursor-not-allowed rounded-xl p-6 font-semibold transition-colors duration-200 relative group">
                            📖 Reading Practice
                            <span className="absolute top-2 right-2 text-[10px] bg-gray-200 text-gray-600 px-2 py-1 rounded">Locked</span>
                        </div>
                        <Link to="/exam/landing" className="block text-center bg-blue-50 hover:bg-blue-100 border border-blue-200 text-blue-700 rounded-xl p-6 font-semibold transition-colors duration-200 relative group">
                            📝 The tests
                        </Link>
                        <div className="block text-center bg-gray-50 hover:bg-gray-100 border border-gray-200 text-gray-500 cursor-not-allowed rounded-xl p-6 font-semibold transition-colors duration-200 relative group">
                            📝 Grammar summary
                            <span className="absolute top-2 right-2 text-[10px] bg-gray-200 text-gray-600 px-2 py-1 rounded">Locked</span>
                        </div>
                        <Link to="/ipa" className="block text-center bg-blue-50 hover:bg-blue-100 border border-blue-200 text-blue-700 rounded-xl p-6 font-semibold transition-colors duration-200 relative group">
                            🔊 IPA Learning
                        </Link>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default Dashboard;
