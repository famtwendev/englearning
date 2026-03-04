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

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/login" element={<Login />} />
        <Route path="/register" element={<Register />} />
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
      </Routes>
    </Router>
  );
}

export default App;
