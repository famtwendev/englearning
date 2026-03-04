import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import { useAuthStore } from '../store/authStore';
import { LogOut, BookOpenCheck, Flame, Star, LayoutDashboard } from 'lucide-react';

const Navbar: React.FC = () => {
    const user = useAuthStore((state) => state.user);
    const logout = useAuthStore((state) => state.logout);
    const location = useLocation();

    if (!user) return null;

    return (
        <nav className="bg-white shadow-sm border-b border-gray-100 sticky top-0 z-50">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="flex justify-between h-16 items-center">
                    {/* Brand */}
                    <div className="flex items-center flex-shrink-0">
                        <Link to="/" className="flex items-center gap-2 group">
                            <div className="bg-indigo-100 p-2 rounded-xl group-hover:bg-indigo-200 transition-colors">
                                <BookOpenCheck className="text-indigo-600" size={24} />
                            </div>
                            <span className="font-bold text-xl text-gray-800 tracking-tight hidden sm:block">
                                EngLearning
                            </span>
                        </Link>
                    </div>

                    {/* Stats & Navigation */}
                    <div className="flex items-center gap-4 md:gap-6">
                        <Link
                            to="/"
                            className={`hidden sm:flex items-center gap-2 px-3 py-2 rounded-lg text-sm font-semibold transition-colors ${location.pathname === '/' ? 'bg-gray-100 text-gray-900' : 'text-gray-500 hover:bg-gray-50'
                                }`}
                        >
                            <LayoutDashboard size={18} />
                            Dashboard
                        </Link>

                        <div className="hidden sm:flex items-center gap-4 ml-4 pl-4 border-l border-gray-200">
                            <div className="flex items-center text-orange-500 font-bold bg-orange-50 px-3 py-1 rounded-full" title="Current Streak">
                                <Flame size={18} className="mr-1" />
                                {user.streak ?? 0}
                            </div>
                            <div className="flex items-center text-purple-600 font-bold bg-purple-50 px-3 py-1 rounded-full" title="Total XP">
                                <Star size={18} className="mr-1" />
                                {user.totalXp ?? 0} XP
                            </div>
                            <div className="flex items-center text-blue-600 font-bold bg-blue-50 px-3 py-1 rounded-full" title="Current Level">
                                Lvl {user.level ?? 1}
                            </div>
                        </div>

                        {/* Mobile Stats (Compact) */}
                        <div className="flex sm:hidden items-center gap-2 ml-2">
                            <div className="flex items-center text-orange-500 font-bold text-sm">
                                <Flame size={16} /> {user.streak ?? 0}
                            </div>
                            <div className="flex items-center text-purple-600 font-bold text-sm">
                                <Star size={16} /> {user.totalXp ?? 0}
                            </div>
                        </div>

                        <div className="ml-2 sm:ml-4 pl-2 sm:pl-4 border-l border-gray-200">
                            <button
                                onClick={logout}
                                className="flex items-center gap-2 text-gray-500 hover:text-red-600 hover:bg-red-50 px-3 py-2 rounded-lg transition-colors font-medium text-sm"
                                title="Logout"
                            >
                                <LogOut size={18} />
                                <span className="hidden sm:inline">Logout</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </nav>
    );
};

export default Navbar;
