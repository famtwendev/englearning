import axios from 'axios';
import { useAuthStore } from '../store/authStore';

const api = axios.create({
    baseURL: 'http://localhost:8080/api/v1',
    headers: {
        'Content-Type': 'application/json',
    },
});

api.interceptors.request.use(
    (config) => {
        const state = useAuthStore.getState();
        if (state.token) {
            config.headers.Authorization = `Bearer ${state.token}`;
        }
        if (state.user?.id) {
            config.headers['X-User-Id'] = state.user.id.toString();
        }
        return config;
    },
    (error) => Promise.reject(error)
);

export default api;
