export interface Phoneme {
    id: string;
    symbol: string;
    description: string;
    audioUrl: string;
    vowel: boolean;
    consonant: boolean;
    monophthongs: boolean;
    diphthongs: boolean;
}

export interface IpaWord {
    id: string;
    text: string;
    ipaText: string;
    audioUrl: string;
    primaryPhoneme: Phoneme;
}
