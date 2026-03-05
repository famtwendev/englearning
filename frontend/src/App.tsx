import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import { useAuthStore } from './store/authStore';
import Login from './pages/Login';
import Register from './pages/Register';
import Dashboard from './pages/Dashboard';
import TopicList from './pages/TopicList';
import Theory from './pages/Theory';
import Practice from './pages/Practice';
import React from 'react';

import Navbar from './components/Navbar';
import TestLandingPage from './features/exam/pages/TestLandingPage';
import ExamEngine from './features/exam/pages/ExamEngine';
import IpaDashboard from './features/ipa/pages/IpaDashboard';

const PrivateRoute = ({ children }: { children: React.ReactNode }) => {
  const isAuthenticated = useAuthStore((state) => state.isAuthenticated);
  return isAuthenticated ? (
    <div className="min-h-screen flex flex-col bg-gray-50">
      <Navbar />
      <div className="flex-1">
        {children}
      </div>
    </div>
  ) : <Navigate to="/login" />;
};

const GuestRoute = ({ children }: { children: React.ReactNode }) => {
  const isAuthenticated = useAuthStore((state) => state.isAuthenticated);
  return isAuthenticated ? <Navigate to="/" replace /> : <>{children}</>;
};

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/login" element={<GuestRoute><Login /></GuestRoute>} />
        <Route path="/register" element={<GuestRoute><Register /></GuestRoute>} />
        <Route
          path="/"
          element={
            <PrivateRoute>
              <Dashboard />
            </PrivateRoute>
          }
        />
        <Route path="/topics" element={<PrivateRoute><TopicList /></PrivateRoute>} />
        <Route path="/topics/:id/theory" element={<PrivateRoute><Theory /></PrivateRoute>} />
        <Route path="/topics/:id/practice" element={<PrivateRoute><Practice /></PrivateRoute>} />
        <Route path="/ipa" element={<PrivateRoute><IpaDashboard /></PrivateRoute>} />
        <Route path="/exam/landing" element={<PrivateRoute><TestLandingPage /></PrivateRoute>} />
        <Route path="/exam/engine" element={<PrivateRoute><ExamEngine /></PrivateRoute>} />
        <Route path="*" element={<Navigate to="/" replace />} />
      </Routes>
    </Router>
  );
}

export default App;
