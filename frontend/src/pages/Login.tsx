import React, { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { useAuthStore } from '../store/authStore';
import api from '../services/api';
import { Eye, EyeOff, BookOpenCheck } from 'lucide-react';
import axios from 'axios';

const Login = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [showPassword, setShowPassword] = useState(false);

    const [generalError, setGeneralError] = useState('');
    const [errors, setErrors] = useState<Record<string, string>>({});

    const setToken = useAuthStore((state) => state.setToken);
    const navigate = useNavigate();

    const validateClientSide = () => {
        const newErrors: Record<string, string> = {};
        if (!email) {
            newErrors.email = "Email is required";
        } else if (!/\S+@\S+\.\S+/.test(email)) {
            newErrors.email = "Email format is invalid";
        }
        if (!password) newErrors.password = "Password is required";

        setErrors(newErrors);
        return Object.keys(newErrors).length === 0;
    };

    const handleLogin = async (e: React.FormEvent) => {
        e.preventDefault();
        setGeneralError('');
        setErrors({});

        if (!validateClientSide()) {
            return;
        }

        try {
            const response = await api.post('/auth/authenticate', { email, password });
            setToken(response.data.token);
            navigate('/');
        } catch (err) {
            if (axios.isAxiosError(err) && err.response && (err.response.status === 400 || err.response.status === 403)) {
                if (err.response?.status === 403) {
                    setGeneralError('Invalid email or password');
                } else if (typeof err.response?.data === 'object' && err.response?.data !== null) {
                    setErrors(err.response.data);
                } else {
                    setGeneralError('Login failed. Please check your input.');
                }
            } else {
                setGeneralError('An unexpected error occurred. Please try again later.');
            }
        }
    };

    return (
        <div className="min-h-screen bg-gray-50 flex">
            {/* Left Side: Branding / Image */}
            <div className="hidden lg:flex lg:w-1/2 bg-gradient-to-br from-indigo-500 via-purple-500 to-pink-500 text-white flex-col justify-center items-center p-12">
                <div className="max-w-md text-center">
                    <BookOpenCheck size={80} className="mx-auto mb-8 text-white opacity-90" />
                    <h1 className="text-4xl font-extrabold mb-6">Welcome Back!</h1>
                    <p className="text-lg opacity-90 leading-relaxed">
                        Continue your journey to mastering English. Dive into new vocabulary, speaking exercises, and interactive lessons.
                    </p>
                </div>
            </div>

            {/* Right Side: Form */}
            <div className="w-full lg:w-1/2 flex items-center justify-center p-8">
                <div className="w-full max-w-md bg-white rounded-2xl shadow-xl p-8 border border-gray-100">
                    <div className="text-center mb-8">
                        <div className="inline-flex items-center justify-center w-16 h-16 rounded-full bg-indigo-100 text-indigo-600 mb-4 lg:hidden">
                            <BookOpenCheck size={32} />
                        </div>
                        <h2 className="text-3xl font-bold text-gray-800 tracking-tight">Login</h2>
                        <p className="text-gray-500 mt-2">Enter your details to access your account.</p>
                    </div>

                    {generalError && (
                        <div className="bg-red-50 border-l-4 border-red-500 p-4 mb-6 rounded-md">
                            <p className="text-red-700 text-sm font-medium">{generalError}</p>
                        </div>
                    )}

                    <form onSubmit={handleLogin} className="space-y-5">
                        <div>
                            <label className="block text-gray-700 text-sm font-semibold mb-2" htmlFor="email">Email Address</label>
                            <input
                                id="email"
                                type="email"
                                placeholder="name@example.com"
                                className={`w-full px-4 py-3 rounded-xl border ${errors.email ? 'border-red-500 bg-red-50 focus:ring-red-200' : 'border-gray-300 focus:border-indigo-500 focus:ring-indigo-200'} focus:outline-none focus:ring-4 transition-all duration-200 text-gray-700`}
                                value={email}
                                onChange={(e) => setEmail(e.target.value)}
                            />
                            {errors.email && <p className="text-red-500 text-xs font-medium mt-1.5">{errors.email}</p>}
                        </div>

                        <div>
                            <label className="block text-gray-700 text-sm font-semibold mb-2" htmlFor="password">Password</label>
                            <div className="relative">
                                <input
                                    id="password"
                                    type={showPassword ? "text" : "password"}
                                    placeholder="••••••••"
                                    className={`w-full px-4 py-3 pr-12 rounded-xl border ${errors.password ? 'border-red-500 bg-red-50 focus:ring-red-200' : 'border-gray-300 focus:border-indigo-500 focus:ring-indigo-200'} focus:outline-none focus:ring-4 transition-all duration-200 text-gray-700`}
                                    value={password}
                                    onChange={(e) => setPassword(e.target.value)}
                                />
                                <button
                                    type="button"
                                    className="absolute inset-y-0 right-0 pr-4 flex items-center text-gray-400 hover:text-indigo-600 transition-colors"
                                    onClick={() => setShowPassword(!showPassword)}
                                    tabIndex={-1}
                                >
                                    {showPassword ? <EyeOff size={20} /> : <Eye size={20} />}
                                </button>
                            </div>
                            {errors.password && <p className="text-red-500 text-xs font-medium mt-1.5">{errors.password}</p>}
                        </div>

                        <div className="pt-2">
                            <button
                                type="submit"
                                className="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-3.5 px-4 rounded-xl shadow-lg shadow-indigo-200 focus:outline-none focus:ring-4 focus:ring-indigo-300 transition-all duration-200 transform hover:-translate-y-0.5"
                            >
                                Sign In
                            </button>
                        </div>
                    </form>

                    <p className="mt-8 text-center text-sm text-gray-600">
                        Bạn chưa có tài khoản?{' '}
                        <Link to="/register" className="text-indigo-600 font-semibold hover:text-indigo-800 hover:underline transition-colors">
                            Register Now!
                        </Link>
                    </p>
                </div>
            </div>
        </div>
    );
};

export default Login;
