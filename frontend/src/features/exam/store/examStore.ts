import { create } from 'zustand';

export type ExamStateStatus = 'INIT' | 'IN_PROGRESS' | 'SUBMITTED' | 'REVIEW';

interface ExamState {
    status: ExamStateStatus;
    templateId: string | null;
    timeRemainingSec: number;
    currentQuestionIndex: number;
    answers: Record<string, any>; // questionId -> answer payload

    // Actions
    startExam: (templateId: string, durationSec: number) => void;
    submitExam: () => void;
    setReviewMode: () => void;
    tickTimer: () => void;
    setAnswer: (questionId: string, answerData: any) => void;
    nextQuestion: () => void;
    prevQuestion: () => void;
}

export const useExamStore = create<ExamState>((set) => ({
    status: 'INIT',
    templateId: null,
    timeRemainingSec: 0,
    currentQuestionIndex: 0,
    answers: {},

    startExam: (templateId, durationSec) =>
        set({ status: 'IN_PROGRESS', templateId, timeRemainingSec: durationSec, currentQuestionIndex: 0, answers: {} }),

    submitExam: () =>
        set({ status: 'SUBMITTED' }),

    setReviewMode: () =>
        set({ status: 'REVIEW' }),

    tickTimer: () =>
        set((state) => ({ timeRemainingSec: Math.max(0, state.timeRemainingSec - 1) })),

    setAnswer: (questionId, answerData) =>
        set((state) => ({ answers: { ...state.answers, [questionId]: answerData } })),

    nextQuestion: () =>
        set((state) => ({ currentQuestionIndex: state.currentQuestionIndex + 1 })),

    prevQuestion: () =>
        set((state) => ({ currentQuestionIndex: Math.max(0, state.currentQuestionIndex - 1) }))
}));
