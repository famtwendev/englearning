import api from '../../../services/api';

export const ipaApi = {
    getPhonemes: async () => {
        const res = await api.get('/ipa/phonemes');
        return res.data.data;
    },
    getPhonemeById: async (id: string) => {
        const res = await api.get(`/ipa/phonemes/${id}`);
        return res.data.data;
    },
    getWordsForPhoneme: async (phonemeId: string) => {
        const res = await api.get(`/ipa/phonemes/${phonemeId}/words`);
        return res.data.data;
    },
    getAllWords: async () => {
        const res = await api.get('/ipa/words');
        return res.data.data;
    },
};
