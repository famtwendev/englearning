import React, { useMemo } from 'react';
import { Box, Typography, Container, CircularProgress, Tooltip, ButtonBase } from '@mui/material';
import { useSuspenseQuery } from '@tanstack/react-query';
import { ipaApi } from '../api/ipaApi';
import type { Phoneme, IpaWord } from '../types';

// Softer, more pleasant colors perfectly suited for a standard IPA chart
const COLOR_MONO = '#7b08ffff'; // Soft Deep Blue
const COLOR_DIPH = '#f88628ff'; // Soft Rust Red
const COLOR_CONS = '#1bc261cc'; // Smooth Dark Grey
const HEADER_BG = '#F3F4F6';

// Inner component for a single Phoneme block
const PhonemeBlock: React.FC<{
    phoneme: Phoneme,
    word: IpaWord | undefined,
    bgColor: string
}> = ({ phoneme, word, bgColor }) => {
    const symbol = phoneme.symbol;
    const displayWord = word ? word.text : '';

    const handlePlayPhoneme = (e: React.MouseEvent) => {
        e.stopPropagation();
        if (phoneme?.audioUrl) {
            new Audio(phoneme.audioUrl).play().catch(console.error);
        } else {
            const utterance = new SpeechSynthesisUtterance(symbol);
            utterance.lang = 'en-GB';
            window.speechSynthesis.speak(utterance);
        }
    };

    const handlePlayWord = (e: React.MouseEvent) => {
        e.stopPropagation();
        if (word?.audioUrl) {
            new Audio(word.audioUrl).play().catch(console.error);
        } else if (displayWord) {
            const utterance = new SpeechSynthesisUtterance(displayWord);
            utterance.lang = 'en-GB';
            window.speechSynthesis.speak(utterance);
        }
    };

    return (
        <Box
            sx={{
                bgcolor: 'white',
                p: { xs: 0.5, sm: 2 },
                borderRadius: 2,
                boxShadow: '0 2px 8px rgba(0,0,0,0.06)',
                border: '1px solid #e9e9e9ff',
                display: 'flex',
                flexDirection: 'column',
                gap: { xs: 0.5, sm: 0.75 }, // Space between the three internal blocks
                width: '100%',
                height: '100%', // Crucial to ensure grids scale blocks equivalently
                userSelect: 'none',
                transition: 'box-shadow 0.2s ease'
            }}
        >
            {/* Top Block: Phoneme Symbol */}
            <Tooltip title="Play Phoneme">
                <ButtonBase
                    onClick={handlePlayPhoneme}
                    sx={{
                        width: '100%',
                        flex: 1.2, // Makes sure symbol container expands nicely
                        minHeight: { xs: 45, sm: 60, md: 70 }, // Prevents crushing
                        bgcolor: bgColor,
                        color: 'white',
                        borderRadius: 1.25,
                        display: 'flex',
                        justifyContent: 'center',
                        alignItems: 'center',
                        transition: 'filter 0.2s ease, background-color 0.2s ease',
                        '&:hover': { filter: 'brightness(1.15)' }
                    }}
                >
                    <Typography sx={{
                        fontWeight: 800,
                        color: 'white',
                        fontFamily: 'system-ui, sans-serif',
                        fontSize: { xs: '1.4rem', sm: '1.8rem', md: '2.2rem' }
                    }}>
                        {symbol}
                    </Typography>
                </ButtonBase>
            </Tooltip>

            {/* Middle Block: Example Word */}
            <Tooltip title={displayWord ? "Play Word Example" : ""}>
                <ButtonBase
                    onClick={displayWord ? handlePlayWord : undefined}
                    disabled={!displayWord}
                    sx={{
                        width: '100%',
                        flex: 1,
                        minHeight: { xs: 40, sm: 50, md: 55 },
                        bgcolor: bgColor,
                        color: 'white',
                        py: { xs: 0.5, sm: 0.75 },
                        borderRadius: 1.25,
                        display: 'flex',
                        flexDirection: 'column',
                        justifyContent: 'center',
                        alignItems: 'center',
                        transition: 'filter 0.2s ease',
                        '&:hover': { filter: displayWord ? 'brightness(1.15)' : 'none' }
                    }}
                >
                    <Box sx={{
                        width: '90%',

                        borderRadius: 1,
                        py: { xs: 0.5, sm: 0.75 },
                        display: 'flex',
                        flexDirection: 'column',
                        alignItems: 'center',
                        justifyContent: 'center'
                    }}>
                        {displayWord ? (
                            <>
                                <Typography sx={{
                                    fontWeight: 800,
                                    fontFamily: 'system-ui, sans-serif',
                                    color: 'white',
                                    fontSize: { xs: '0.7rem', sm: '0.8rem', md: '0.9rem' },
                                    lineHeight: 1.1,
                                    mb: 0.5,
                                    letterSpacing: 0.5
                                }}>
                                    {displayWord}
                                </Typography>
                                <Typography sx={{
                                    fontWeight: 600,
                                    color: 'rgba(255,255,255,0.9)',
                                    fontSize: { xs: '0.6rem', sm: '0.7rem', md: '0.8rem' },
                                    fontFamily: 'monospace',
                                    lineHeight: 1.1
                                }}>
                                    /{word?.ipaText || symbol}/
                                </Typography>
                            </>
                        ) : (
                            <Typography sx={{ opacity: 0.5, fontSize: { xs: '0.7rem', sm: '0.8rem' } }}>
                                -
                            </Typography>
                        )}
                    </Box>
                </ButtonBase>
            </Tooltip>

            {/* Bottom Block: Note */}
            <Box sx={{
                width: '100%',
                py: { xs: 0.25, sm: 0.5 },
                borderRadius: 1,
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'left',
                mt: 'auto'
            }}>
                <Typography sx={{
                    fontWeight: 800,
                    fontFamily: 'system-ui, sans-serif',
                    fontSize: { xs: '0.55rem', sm: '0.6rem', md: '0.65rem' },
                    letterSpacing: 0.5,
                }}>
                    Note:
                </Typography>
            </Box>
        </Box>
    );
};

export const IpaDashboard: React.FC = () => {
    const { data: phonemes } = useSuspenseQuery<Phoneme[]>({
        queryKey: ['phonemes'],
        queryFn: ipaApi.getPhonemes,
    });

    const { data: words } = useSuspenseQuery<IpaWord[]>({
        queryKey: ['words'],
        queryFn: ipaApi.getAllWords,
    });

    // We make sure the data mapping is isolated and safely fallback to empty arrays
    const monophthongs = useMemo(() => phonemes?.filter(p => p.vowel && p.monophthongs) || [], [phonemes]);
    const diphthongs = useMemo(() => phonemes?.filter(p => p.vowel && p.diphthongs) || [], [phonemes]);
    const consonants = useMemo(() => phonemes?.filter(p => p.consonant) || [], [phonemes]);

    return (
        <Container maxWidth="xl" sx={{ py: { xs: 4, md: 6 }, px: { xs: 1, sm: 2, md: 3 } }}>
            <Box sx={{ mb: { xs: 4, md: 6 }, textAlign: 'center' }}>
                <Typography variant="h2" sx={{ mb: 2, fontWeight: 800, color: '#111827', fontFamily: 'system-ui, sans-serif', fontSize: { xs: '2rem', md: '3rem' } }}>
                    Interactive Phonemic Chart
                </Typography>
                <Typography variant="body1" sx={{ color: '#4b5563', maxWidth: 900, mx: 'auto', mb: 4, fontSize: { xs: '0.9rem', md: '1rem' } }}>
                    Click on any sound block to hear its pronunciation along with an example word.
                </Typography>
            </Box>

            <Box sx={{ display: 'flex', flexDirection: 'column', gap: { xs: 3, sm: 5 }, maxWidth: 1050, mx: 'auto' }}>

                {/* Vowels Headers */}
                <Box sx={{ display: 'flex', ml: { xs: 4, sm: 6 } }}>
                    <Box sx={{ flex: 4, bgcolor: HEADER_BG, textAlign: 'center', py: { xs: 1, sm: 1.5 }, borderTopLeftRadius: 8, borderBottomLeftRadius: 8 }}>
                        <Typography sx={{ fontWeight: 700, fontSize: { xs: '0.8rem', sm: '1rem' }, color: '#374151', fontFamily: 'system-ui, sans-serif' }}>Monophthongs</Typography>
                    </Box>
                    <Box sx={{ width: { xs: 12, sm: 16 } }} /> {/* Gap matching grid */}
                    <Box sx={{ flex: 4, bgcolor: HEADER_BG, textAlign: 'center', py: { xs: 1, sm: 1.5 }, borderTopRightRadius: 8, borderBottomRightRadius: 8 }}>
                        <Typography sx={{ fontWeight: 700, fontSize: { xs: '0.8rem', sm: '1rem' }, color: '#374151', fontFamily: 'system-ui, sans-serif' }}>Diphthongs</Typography>
                    </Box>
                </Box>

                {/* Vowels Section */}
                <Box sx={{ display: 'flex', position: 'relative' }}>

                    {/* Vowels Sidebar Label */}
                    <Box sx={{ width: { xs: 32, sm: 48 }, position: 'relative' }}>
                        <Typography
                            sx={{
                                position: 'absolute',
                                top: '50%',
                                left: '50%',
                                transform: 'translate(-50%, -50%) rotate(-90deg)',
                                letterSpacing: 4,
                                fontWeight: 800,
                                color: 'black',
                                fontSize: { xs: '0.75rem', sm: '0.9rem' },
                                fontFamily: 'system-ui, sans-serif'
                            }}
                        >
                            VOWELS
                        </Typography>
                    </Box>

                    {/* Vowels Grids Combined */}
                    <Box sx={{ display: 'flex', gap: { xs: 1.5, sm: 2 }, flex: 1, alignItems: 'flex-start' }}>

                        {/* Monophthongs Grid */}
                        {/* 3 columns -> exact half width of 6 total standard size columns */}
                        <Box sx={{
                            flex: 1,
                            display: 'grid',
                            gridTemplateColumns: { xs: 'repeat(3, 1fr)', sm: 'repeat(3, 1fr)' },
                            gap: { xs: 1.5, sm: 2 }
                        }}>
                            {monophthongs.map(phoneme => (
                                <PhonemeBlock
                                    key={phoneme.id}
                                    phoneme={phoneme}
                                    word={words?.find(w => w.primaryPhoneme?.id === phoneme.id)}
                                    bgColor={COLOR_MONO}
                                />
                            ))}
                        </Box>

                        {/* Diphthongs Grid */}
                        <Box sx={{
                            flex: 1,
                            display: 'grid',
                            gridTemplateColumns: { xs: 'repeat(3, 1fr)', sm: 'repeat(3, 1fr)' },
                            gap: { xs: 1.5, sm: 2 }
                        }}>
                            {diphthongs.map(phoneme => (
                                <PhonemeBlock
                                    key={phoneme.id}
                                    phoneme={phoneme}
                                    word={words?.find(w => w.primaryPhoneme?.id === phoneme.id)}
                                    bgColor={COLOR_DIPH}
                                />
                            ))}
                        </Box>

                    </Box>
                </Box>

                {/* Consonants Section */}
                <Box sx={{ display: 'flex', position: 'relative', mt: { xs: 0, sm: 2 } }}>
                    {/* Consonants Sidebar Label */}
                    <Box sx={{ width: { xs: 32, sm: 48 }, position: 'relative' }}>
                        <Typography
                            sx={{
                                position: 'absolute',
                                top: '50%',
                                left: '50%',
                                transform: 'translate(-50%, -50%) rotate(-90deg)',
                                letterSpacing: 4,
                                fontWeight: 800,
                                color: 'black',
                                fontSize: { xs: '0.75rem', sm: '0.9rem' },
                                fontFamily: 'system-ui, sans-serif'
                            }}
                        >
                            CONSONANTS
                        </Typography>
                    </Box>

                    {/* Consonants Grid */}
                    {/* Matches the total columns from Vowels exactly (3+3=6) at all sizes */}
                    <Box
                        sx={{
                            flex: 1,
                            display: 'grid',
                            gridTemplateColumns: { xs: 'repeat(6, 1fr)', sm: 'repeat(6, 1fr)' },
                            gridAutoRows: '1fr',
                            gap: { xs: 1.5, sm: 2 }
                        }}
                    >
                        {consonants.map(phoneme => (
                            <PhonemeBlock
                                key={phoneme.id}
                                phoneme={phoneme}
                                word={words?.find(w => w.primaryPhoneme?.id === phoneme.id)}
                                bgColor={COLOR_CONS}
                            />
                        ))}
                    </Box>
                </Box>
            </Box>

        </Container>
    );
};

export default IpaDashboard;
