import React from 'react';
import { Box, Typography, Button, Paper, Divider, Chip } from '@mui/material';
import { useNavigate } from 'react-router-dom';
import { useExamStore } from '../store/examStore';

export const TestLandingPage: React.FC = () => {
    const navigate = useNavigate();
    const startExam = useExamStore((state) => state.startExam);

    const handleStart = () => {
        // Simulating starting an exam with 60 minutes
        startExam('template-uuid-1234', 3600);
        navigate('/exam/engine');
    };

    return (
        <Box sx={{ minHeight: '100vh', display: 'flex', alignItems: 'center', justifyContent: 'center', bgcolor: 'background.default', p: 3 }}>
            <Paper sx={{ p: { xs: 3, md: 6 }, maxWidth: 800, width: '100%' }}>
                <Typography variant="h1" gutterBottom sx={{ fontSize: { xs: '2.5rem', md: '3.5rem' }, color: 'primary.main' }}>
                    Advanced English Proficiency Test
                </Typography>

                <Box sx={{ display: 'flex', gap: 1, mb: 4, flexWrap: 'wrap' }}>
                    <Chip label="Level: HIGH" color="error" variant="outlined" />
                    <Chip label="Reading" variant="outlined" />
                    <Chip label="Listing" variant="outlined" />
                    <Chip label="Speaking" variant="outlined" />
                </Box>

                <Divider sx={{ mb: 4 }} />

                <Box sx={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: 4, mb: 6 }}>
                    <Box>
                        <Typography variant="h4" color="text.secondary">Total Questions</Typography>
                        <Typography variant="h2">40</Typography>
                    </Box>
                    <Box>
                        <Typography variant="h4" color="text.secondary">Duration</Typography>
                        <Typography variant="h2">60 mins</Typography>
                    </Box>
                    <Box>
                        <Typography variant="h4" color="text.secondary">Total Attempts</Typography>
                        <Typography variant="h2">1,204</Typography>
                    </Box>
                </Box>

                <Typography variant="body1" sx={{ mb: 4 }}>
                    This simulated test environment closely mirrors real-world examination standards. You will be evaluated on your grammar, vocabulary inference, and comprehension skills.
                </Typography>

                <Button
                    variant="contained"
                    color="primary"
                    size="large"
                    fullWidth
                    onClick={handleStart}
                    sx={{ py: 2, fontSize: '1.25rem' }}
                >
                    Begin Examination
                </Button>
            </Paper>
        </Box>
    );
};

export default TestLandingPage;
