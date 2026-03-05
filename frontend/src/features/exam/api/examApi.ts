import api from '../../../services/api';

export const examApi = {
    getTemplates: async () => {
        const res = await api.get('/exams/templates');
        return res.data;
    },
    getTemplateById: async (id: string) => {
        const res = await api.get(`/exams/templates/${id}`);
        return res.data;
    },
    getAnalyticsRadar: async (userId: string) => {
        const res = await api.get(`/analytics/radar/${userId}`);
        return res.data;
    },
};
