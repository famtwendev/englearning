import { createTheme } from '@mui/material/styles';

/**
 * Aesthetic: Editorial / Minimalist Academic
 * Typography: Serious Serif for display/reading, Clean Sans-Serif for interface controls.
 * Colors: Deep slate (primary) and muted ivory/off-white background.
 */
export const theme = createTheme({
    palette: {
        mode: 'light',
        primary: {
            main: '#1c1f26', // Deep Slate
        },
        secondary: {
            main: '#8c2b2b', // Subtle Crimson accent
        },
        background: {
            default: '#fbfbf9', // Muted ivory
            paper: '#ffffff',
        },
        text: {
            primary: '#1a1a1a',
            secondary: '#666666',
        },
    },
    typography: {
        fontFamily: '"Geist", "Inter", "Helvetica", "Arial", sans-serif',
        h1: {
            fontFamily: '"Merriweather", "Lora", serif',
            fontWeight: 700,
            letterSpacing: '-0.02em',
        },
        h2: {
            fontFamily: '"Merriweather", "Lora", serif',
            fontWeight: 600,
            letterSpacing: '-0.01em',
        },
        h3: {
            fontFamily: '"Merriweather", "Lora", serif',
            fontWeight: 600,
        },
        h4: {
            fontFamily: '"Merriweather", "Lora", serif',
            fontWeight: 500,
        },
        body1: {
            fontSize: '1.125rem', // Slightly larger for academic reading
            lineHeight: 1.7,
            color: '#1a1a1a',
        },
        body2: {
            fontSize: '0.95rem',
            lineHeight: 1.6,
            color: '#444444',
        },
    },
    shape: {
        borderRadius: 4, // Sharp corners for an editorial look
    },
    components: {
        MuiButton: {
            styleOverrides: {
                root: {
                    textTransform: 'none',
                    fontWeight: 600,
                    borderRadius: 2,
                    padding: '8px 24px',
                },
                containedPrimary: {
                    backgroundColor: '#1c1f26',
                    boxShadow: 'none',
                    '&:hover': {
                        backgroundColor: '#000000',
                        boxShadow: 'none',
                    },
                },
            },
        },
        MuiPaper: {
            styleOverrides: {
                root: {
                    boxShadow: '0 4px 24px -8px rgba(0, 0, 0, 0.05)',
                    border: '1px solid #eaeaea',
                },
            },
        },
    },
});
