import React, { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { useAuthStore } from '../store/authStore';
import api from '../services/api';
import { Eye, EyeOff, Sparkles } from 'lucide-react';
import axios from 'axios';

const Register = () => {
    const [firstName, setFirstName] = useState('');
    const [lastName, setLastName] = useState('');
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [confirmPassword, setConfirmPassword] = useState('');
    const [showPassword, setShowPassword] = useState(false);
    const [showConfirmPassword, setShowConfirmPassword] = useState(false);

    const [errors, setErrors] = useState<Record<string, string>>({});
    const [generalError, setGeneralError] = useState('');

    const setAuth = useAuthStore((state) => state.setAuth);
    const navigate = useNavigate();

    const validateClientSide = () => {
        const newErrors: Record<string, string> = {};
        if (!firstName) newErrors.firstName = "First name is required";
        if (!lastName) newErrors.lastName = "Last name is required";

        if (!email) {
            newErrors.email = "Email is required";
        } else if (!/\S+@\S+\.\S+/.test(email)) {
            newErrors.email = "Email format is invalid";
        }

        if (!password) {
            newErrors.password = "Password is required";
        } else if (password.length < 8) {
            newErrors.password = "Password must be at least 8 characters";
        }

        if (password !== confirmPassword) {
            newErrors.confirmPassword = "Passwords do not match";
        }

        setErrors(newErrors);
        return Object.keys(newErrors).length === 0;
    };

    const handleRegister = async (e: React.FormEvent) => {
        e.preventDefault();
        setGeneralError('');
        setErrors({});

        if (!validateClientSide()) {
            return;
        }

        try {
            const response = await api.post('/auth/register', { firstName, lastName, email, password });
            const { token, ...user } = response.data.data;
            setAuth(token, user);
            navigate('/');
        } catch (err) {
            if (axios.isAxiosError(err)) {
                if (err.response?.status === 409) {
                    setGeneralError(err.response?.data?.message || 'An account with this email already exists.');
                } else if (err.response?.status === 400 && err.response.data?.data) {
                    setErrors(err.response.data.data as Record<string, string>);
                } else if (err.response?.status === 403) {
                    setGeneralError('Registration blocked. Check permissions.');
                } else {
                    setGeneralError(err.response?.data?.message || 'Registration failed. Please check your input.');
                }
            } else {
                setGeneralError('An unexpected error occurred. Please try again later.');
            }
        }
    };

    return (
        <div className="min-h-screen bg-gray-50 flex">

            {/* Left Side: Branding / Image */}
            <div className="hidden lg:flex lg:w-1/2 bg-gradient-to-br from-emerald-400 via-teal-500 to-cyan-600 text-white flex-col justify-center items-center p-12">
                <div className="max-w-md text-center">
                    <Sparkles size={80} className="mx-auto mb-8 text-white opacity-90" />
                    <h1 className="text-4xl font-extrabold mb-6">Start Learning Today</h1>
                    <p className="text-lg opacity-90 leading-relaxed">
                        Join our community of learners. Build your vocabulary, improve pronunciation, and communicate with confidence.
                    </p>
                </div>
            </div>

            {/* Right Side: Form */}
            <div className="w-full lg:w-1/2 flex items-center justify-center p-8 overflow-y-auto">
                <div className="w-full max-w-md bg-white rounded-2xl shadow-xl p-8 border border-gray-100 my-8">
                    <div className="text-center mb-8">
                        <div className="inline-flex items-center justify-center w-16 h-16 rounded-full bg-teal-100 text-teal-600 mb-4 lg:hidden">
                            <Sparkles size={32} />
                        </div>
                        <h2 className="text-3xl font-bold text-gray-800 tracking-tight">Create Account</h2>
                        <p className="text-gray-500 mt-2">Sign up to get started on your journey.</p>
                    </div>

                    {generalError && (
                        <div className="bg-red-50 border-l-4 border-red-500 p-4 mb-6 rounded-md">
                            <p className="text-red-700 text-sm font-medium">{generalError}</p>
                        </div>
                    )}

                    <form onSubmit={handleRegister} className="space-y-5">
                        <div className="flex flex-col sm:flex-row gap-4">
                            <div className="w-full sm:w-1/2">
                                <label className="block text-gray-700 text-sm font-semibold mb-2" htmlFor="firstName">First Name</label>
                                <input
                                    id="firstName"
                                    type="text"
                                    placeholder="John"
                                    className={`w-full px-4 py-3 rounded-xl border ${errors.firstName ? 'border-red-500 bg-red-50 focus:ring-red-200' : 'border-gray-300 focus:border-teal-500 focus:ring-teal-200'} focus:outline-none focus:ring-4 transition-all duration-200 text-gray-700`}
                                    value={firstName}
                                    onChange={(e) => setFirstName(e.target.value)}
                                />
                                {errors.firstName && <p className="text-red-500 text-xs font-medium mt-1.5">{errors.firstName}</p>}
                            </div>
                            <div className="w-full sm:w-1/2">
                                <label className="block text-gray-700 text-sm font-semibold mb-2" htmlFor="lastName">Last Name</label>
                                <input
                                    id="lastName"
                                    type="text"
                                    placeholder="Doe"
                                    className={`w-full px-4 py-3 rounded-xl border ${errors.lastName ? 'border-red-500 bg-red-50 focus:ring-red-200' : 'border-gray-300 focus:border-teal-500 focus:ring-teal-200'} focus:outline-none focus:ring-4 transition-all duration-200 text-gray-700`}
                                    value={lastName}
                                    onChange={(e) => setLastName(e.target.value)}
                                />
                                {errors.lastName && <p className="text-red-500 text-xs font-medium mt-1.5">{errors.lastName}</p>}
                            </div>
                        </div>

                        <div>
                            <label className="block text-gray-700 text-sm font-semibold mb-2" htmlFor="email">Email Address</label>
                            <input
                                id="email"
                                type="email"
                                placeholder="john.doe@example.com"
                                className={`w-full px-4 py-3 rounded-xl border ${errors.email ? 'border-red-500 bg-red-50 focus:ring-red-200' : 'border-gray-300 focus:border-teal-500 focus:ring-teal-200'} focus:outline-none focus:ring-4 transition-all duration-200 text-gray-700`}
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
                                    className={`w-full px-4 py-3 pr-12 rounded-xl border ${errors.password ? 'border-red-500 bg-red-50 focus:ring-red-200' : 'border-gray-300 focus:border-teal-500 focus:ring-teal-200'} focus:outline-none focus:ring-4 transition-all duration-200 text-gray-700`}
                                    value={password}
                                    onChange={(e) => setPassword(e.target.value)}
                                />
                                <button
                                    type="button"
                                    className="absolute inset-y-0 right-0 pr-4 flex items-center text-gray-400 hover:text-teal-600 transition-colors"
                                    onClick={() => setShowPassword(!showPassword)}
                                    tabIndex={-1}
                                >
                                    {showPassword ? <EyeOff size={20} /> : <Eye size={20} />}
                                </button>
                            </div>
                            {errors.password && <p className="text-red-500 text-xs font-medium mt-1.5">{errors.password}</p>}
                            <p className="text-gray-400 text-xs mt-1.5">Must be at least 8 characters long.</p>
                        </div>

                        <div>
                            <label className="block text-gray-700 text-sm font-semibold mb-2" htmlFor="confirmPassword">Confirm Password</label>
                            <div className="relative">
                                <input
                                    id="confirmPassword"
                                    type={showConfirmPassword ? "text" : "password"}
                                    placeholder="••••••••"
                                    className={`w-full px-4 py-3 pr-12 rounded-xl border ${errors.confirmPassword ? 'border-red-500 bg-red-50 focus:ring-red-200' : 'border-gray-300 focus:border-teal-500 focus:ring-teal-200'} focus:outline-none focus:ring-4 transition-all duration-200 text-gray-700`}
                                    value={confirmPassword}
                                    onChange={(e) => setConfirmPassword(e.target.value)}
                                />
                                <button
                                    type="button"
                                    className="absolute inset-y-0 right-0 pr-4 flex items-center text-gray-400 hover:text-teal-600 transition-colors"
                                    onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                                    tabIndex={-1}
                                >
                                    {showConfirmPassword ? <EyeOff size={20} /> : <Eye size={20} />}
                                </button>
                            </div>
                            {errors.confirmPassword && <p className="text-red-500 text-xs font-medium mt-1.5">{errors.confirmPassword}</p>}
                        </div>

                        <div className="pt-2">
                            <button
                                type="submit"
                                className="w-full bg-teal-600 hover:bg-teal-700 text-white font-bold py-3.5 px-4 rounded-xl shadow-lg shadow-teal-200 focus:outline-none focus:ring-4 focus:ring-teal-300 transition-all duration-200 transform hover:-translate-y-0.5"
                            >
                                Register Now
                            </button>
                        </div>
                    </form>
                    <p className="mt-8 text-center text-sm text-gray-600">
                        Already have an account?{' '}
                        <Link to="/login" className="text-teal-600 font-semibold hover:text-teal-800 hover:underline transition-colors">
                            Log in
                        </Link>
                    </p>
                </div>
            </div>
        </div>
    );
};

export default Register;
