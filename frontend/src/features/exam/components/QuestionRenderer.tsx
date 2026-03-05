import React, { lazy, Suspense } from 'react';
import { Box, Typography } from '@mui/material';

// The general shape of a question content object (from JSONB)
export interface QuestionData {
    id: string;
    type: string;
    content: any; // Dynamic JSON content depending on the type
}

export interface QuestionProps {
    question: QuestionData;
    userAnswer?: any;
    onChange: (answerData: any) => void;
}

// 1. Define the Registry
// Lazy loading prevents bundling all question types when they are not used.
const questionComponents: Record<string, React.FC<QuestionProps>> = {
    MULTIPLE_CHOICE_SINGLE: lazy(() => import('./types/MCQSingle')),
    // FILL_BLANK: lazy(() => import('./types/FillBlank')),
    // SPEAKING: lazy(() => import('./types/SpeakingAudio')),
};

const UnsupportedQuestion: React.FC<{ type: string }> = ({ type }) => (
    <Box sx={{ p: 2, bgcolor: 'error.light', color: 'error.contrastText', borderRadius: 1 }}>
        <Typography>Unsupported Question Type: {type}</Typography>
    </Box>
);

const QuestionFallback = () => (
    <Box sx={{ p: 4, textAlign: 'center' }}>
        <Typography color="text.secondary">Loading question...</Typography>
    </Box>
);

export const QuestionRenderer: React.FC<QuestionProps> = ({ question, userAnswer, onChange }) => {
    const Component = questionComponents[question.type];

    if (!Component) {
        return <UnsupportedQuestion type={question.type} />;
    }

    // 2. Render from Registry without Switch-Cases
    return (
        <Suspense fallback={<QuestionFallback />}>
            <Component question={question} userAnswer={userAnswer} onChange={onChange} />
        </Suspense>
    );
};

export default QuestionRenderer;
