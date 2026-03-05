import React, { useCallback } from 'react';
import { Typography, RadioGroup, FormControlLabel, Radio, Paper } from '@mui/material';
import type { QuestionProps } from '../QuestionRenderer';

interface MCQContent {
    prompt: string;
    options: Array<{ id: string; text: string }>;
}

export const MCQSingle: React.FC<QuestionProps> = ({ question, userAnswer, onChange }) => {
    const content = question.content as MCQContent;

    const handleChange = useCallback((event: React.ChangeEvent<HTMLInputElement>) => {
        onChange({ selectedOptionId: event.target.value });
    }, [onChange]);

    const selectedValue = userAnswer?.selectedOptionId || '';

    return (
        <Paper sx={{ p: 3, mb: 3 }}>
            <Typography variant="h3" sx={{ mb: 2 }}>{content.prompt}</Typography>

            <RadioGroup value={selectedValue} onChange={handleChange}>
                {content.options.map((option) => (
                    <FormControlLabel
                        key={option.id}
                        value={option.id}
                        control={<Radio color="primary" />}
                        label={<Typography variant="body1">{option.text}</Typography>}
                        sx={{
                            mb: 1,
                            p: 1,
                            borderRadius: 1,
                            border: '1px solid',
                            borderColor: selectedValue === option.id ? 'primary.main' : 'divider',
                            bgcolor: selectedValue === option.id ? 'action.hover' : 'transparent',
                            transition: 'all 0.2s',
                        }}
                    />
                ))}
            </RadioGroup>
        </Paper>
    );
};

export default MCQSingle;
