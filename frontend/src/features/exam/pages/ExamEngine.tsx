import React, { useEffect, Suspense } from 'react';
import { Box, Typography, Button, Container, LinearProgress, CircularProgress } from '@mui/material';
import { useExamStore } from '../store/examStore';
import QuestionRenderer from '../components/QuestionRenderer';
import { useSuspenseQuery } from '@tanstack/react-query';
import { examApi } from '../api/examApi';

const ExamEngineContent: React.FC = () => {
    const { status, templateId, timeRemainingSec, currentQuestionIndex, answers, setAnswer, submitExam, tickTimer, nextQuestion, prevQuestion } = useExamStore();

    const { data: template } = useSuspenseQuery({
        queryKey: ['examTemplate', templateId],
        queryFn: () => examApi.getTemplateById(templateId!),
    });

    useEffect(() => {
        if (status !== 'IN_PROGRESS') return;
        const interval = setInterval(() => {
            tickTimer();
        }, 1000);
        return () => clearInterval(interval);
    }, [status, tickTimer]);

    if (status === 'SUBMITTED' || status === 'REVIEW') {
        return (
            <Container maxWidth="md" sx={{ py: 8, textAlign: 'center' }}>
                <Typography variant="h2" gutterBottom>Exam Submitted Successfully</Typography>
                <Typography variant="body1" sx={{ mb: 4 }}>
                    Your responses have been securely recorded. Analytics and detailed explanations are being generated.
                </Typography>
                <Button variant="contained">View Detailed Analytics</Button>
            </Container>
        );
    }

    const formatTime = (seconds: number) => {
        const m = Math.floor(seconds / 60);
        const s = seconds % 60;
        return `${m}:${s < 10 ? '0' : ''}${s}`;
    };

    // Fallback if template is somehow empty
    const currentQuestion = template?.questions?.[currentQuestionIndex] || {
        id: 'placeholder',
        type: 'MULTIPLE_CHOICE_SINGLE',
        content: { prompt: 'Loading question from backend...', options: [] }
    };

    return (
        <Container maxWidth="md" sx={{ py: 4 }}>
            {/* Header / Timer */}
            <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 2 }}>
                <Typography variant="h3">{template?.title || 'Examination In Progress'}</Typography>
                <Typography variant="h3" color="error.main" sx={{ fontVariantNumeric: 'tabular-nums' }}>
                    {formatTime(timeRemainingSec)}
                </Typography>
            </Box>
            <LinearProgress variant="determinate" value={(currentQuestionIndex / Math.max(template?.questions?.length || 1, 1)) * 100} sx={{ height: 8, borderRadius: 4, mb: 4 }} />

            {/* Dynamic Question Render */}
            <QuestionRenderer
                question={currentQuestion}
                userAnswer={answers[currentQuestion.id]}
                onChange={(data) => setAnswer(currentQuestion.id, data)}
            />

            {/* Navigation */}
            <Box sx={{ display: 'flex', justifyContent: 'space-between', mt: 4 }}>
                <Button variant="outlined" size="large" onClick={prevQuestion} disabled={currentQuestionIndex === 0}>Previous</Button>
                <Box sx={{ display: 'flex', gap: 2 }}>
                    {currentQuestionIndex < (template?.questions?.length || 1) - 1 ? (
                        <Button variant="outlined" size="large" onClick={nextQuestion}>Next Question</Button>
                    ) : (
                        <Button variant="contained" color="secondary" size="large" onClick={submitExam}>Submit Exam</Button>
                    )}
                </Box>
            </Box>
        </Container>
    );
};

export const ExamEngine: React.FC = () => {
    const status = useExamStore(state => state.status);
    if (status === 'INIT') {
        return <Typography>Exam not started. Redirecting...</Typography>;
    }
    return (
        <Suspense fallback={<Box sx={{ display: 'flex', justifyContent: 'center', py: 8 }}><CircularProgress /></Box>}>
            <ExamEngineContent />
        </Suspense>
    );
};

export default ExamEngine;
