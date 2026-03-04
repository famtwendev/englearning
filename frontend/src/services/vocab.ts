import api from './api';

export interface Topic {
    id: number;
    name: string;
    description: string;
    difficulty: string;
}

export interface Vocabulary {
    id: number;
    word: string;
    meaning: string;
    ipa: string;
    example: string;
    audioUrl?: string;
    partOfSpeech: string;
    difficultyLevel: string;
}

export const vocabApi = {
    getTopics: async () => {
        const response = await api.get<any>('/topics');
        return response.data.data as Topic[];
    },
    getTopicDetails: async (id: number) => {
        try {
            const response = await api.get<any>(`/topics/${id}`);
            return response.data.data as Topic;
        } catch (error: any) {
            console.error("Error fetching topic details:", error);
            throw error;
        }
    },
    getTopicPractice: async (id: number) => {
        try {
            const response = await api.get<any>(`/topics/${id}/practice`);
            return response.data.data as Vocabulary[] || [];
        } catch (error: any) {
            console.error("Error fetching topic practice logic:", error);
            throw error;
        }
    },
    updateProgress: async (vocabId: number, isCorrect: boolean, responseTimeMs: number) => {
        const response = await api.post<any>('/progress/update', {
            vocabId,
            isCorrect,
            responseTime: responseTimeMs
        });
        return response.data.data;
    }
};
