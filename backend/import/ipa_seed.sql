INSERT INTO ipa_phonemes (id, symbol, is_vowel, is_consonant, is_monophthongs, is_diphthongs, audio_url)
VALUES 
-- Insert Vowel Monophthongs
(gen_random_uuid(), 'i:',  true, false, true, false, ''),
(gen_random_uuid(), 'ɪ', true, false, true, false, ''),
(gen_random_uuid(), 'ʊ', true, false, true, false, ''),
(gen_random_uuid(), 'u:', true, false, true, false, ''),
(gen_random_uuid(), 'e', true, false, true, false, ''),
(gen_random_uuid(), 'ə', true, false, true, false, ''),
(gen_random_uuid(), 'ɜ:', true, false, true, false, ''),
(gen_random_uuid(), 'ɔ:', true, false, true, false, ''),
(gen_random_uuid(), 'æ', true, false, true, false, ''),
(gen_random_uuid(), 'ʌ', true, false, true, false, ''),
(gen_random_uuid(), 'ɑ:', true, false, true, false, ''),
(gen_random_uuid(), 'ɒ', true, false, true, false, ''),
-- Insert Vowel diphthong phonemes
(gen_random_uuid(), 'ɪə', true, false, false, true, ''),
(gen_random_uuid(), 'eɪ', true, false, false, true, ''),
(gen_random_uuid(), 'ʊə', true, false, false, true, ''),
(gen_random_uuid(), 'ɔɪ', true, false, false, true, ''),
(gen_random_uuid(), 'əʊ', true, false, false, true, ''),
(gen_random_uuid(), 'eə', true, false, false, true, ''),
(gen_random_uuid(), 'aɪ', true, false, false, true, ''),
(gen_random_uuid(), 'aʊ', true, false, false, true, ''),
-- Insert consonant phonemes
(gen_random_uuid(), 'p', false, true, false, false, ''),
(gen_random_uuid(), 'b', false, true, false, false, ''),
(gen_random_uuid(), 't', false, true, false, false, ''),
(gen_random_uuid(), 'd', false, true, false, false, ''),
(gen_random_uuid(), 'k', false, true, false, false, ''),
(gen_random_uuid(), 'g', false, true, false, false, ''),
(gen_random_uuid(), 'f', false, true, false, false, ''),
(gen_random_uuid(), 'v', false, true, false, false, ''),
(gen_random_uuid(), 'θ', false, true, false, false, ''),
(gen_random_uuid(), 'ð', false, true, false, false, ''),
(gen_random_uuid(), 's', false, true, false, false, ''),
(gen_random_uuid(), 'z', false, true, false, false, ''),
(gen_random_uuid(), 'ʃ', false, true, false, false, ''),
(gen_random_uuid(), 'ʒ', false, true, false, false, ''),
(gen_random_uuid(), 'h', false, true, false, false, ''),
(gen_random_uuid(), 'm', false, true, false, false, ''),
(gen_random_uuid(), 'n', false, true, false, false, ''),
(gen_random_uuid(), 'ŋ', false, true, false, false, ''),
(gen_random_uuid(), 'l', false, true, false, false, ''),
(gen_random_uuid(), 'r', false, true, false, false, ''),
(gen_random_uuid(), 'j', false, true, false, false, ''),
(gen_random_uuid(), 'w', false, true, false, false, ''),
-- Insert consonant cluster phonemes (like 'tʃ' and 'dʒ')
(gen_random_uuid(), 'tʃ', false, true, false, false, ''),
(gen_random_uuid(), 'dʒ', false, true, false, false, '');


-- Mock word to let the UI fetch successfully
INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'see', '/si:/', '', id FROM ipa_phonemes WHERE symbol = 'i:';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'see', '/si:/', '', id FROM ipa_phonemes WHERE symbol = 'i:';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'sit', '/sɪt/', '', id FROM ipa_phonemes WHERE symbol = 'ɪ';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'book', '/bʊk/', '', id FROM ipa_phonemes WHERE symbol = 'ʊ';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'food', '/fuːd/', '', id FROM ipa_phonemes WHERE symbol = 'u:';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'bed', '/bed/', '', id FROM ipa_phonemes WHERE symbol = 'e';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'about', '/əˈbaʊt/', '', id FROM ipa_phonemes WHERE symbol = 'ə';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'bird', '/bɜːd/', '', id FROM ipa_phonemes WHERE symbol = 'ɜ:';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'law', '/lɔː/', '', id FROM ipa_phonemes WHERE symbol = 'ɔ:';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'cat', '/kæt/', '', id FROM ipa_phonemes WHERE symbol = 'æ';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'cup', '/kʌp/', '', id FROM ipa_phonemes WHERE symbol = 'ʌ';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'father', '/ˈfɑːðə/', '', id FROM ipa_phonemes WHERE symbol = 'ɑ:';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'hot', '/hɒt/', '', id FROM ipa_phonemes WHERE symbol = 'ɒ';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'here', '/hɪə/', '', id FROM ipa_phonemes WHERE symbol = 'ɪə';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'day', '/deɪ/', '', id FROM ipa_phonemes WHERE symbol = 'eɪ';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'tour', '/tʊə/', '', id FROM ipa_phonemes WHERE symbol = 'ʊə';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'boy', '/bɔɪ/', '', id FROM ipa_phonemes WHERE symbol = 'ɔɪ';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'go', '/gəʊ/', '', id FROM ipa_phonemes WHERE symbol = 'əʊ';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'hair', '/heə/', '', id FROM ipa_phonemes WHERE symbol = 'eə';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'time', '/taɪm/', '', id FROM ipa_phonemes WHERE symbol = 'aɪ';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'house', '/haʊs/', '', id FROM ipa_phonemes WHERE symbol = 'aʊ';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'pen', '/pen/', '', id FROM ipa_phonemes WHERE symbol = 'p';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'bat', '/bæt/', '', id FROM ipa_phonemes WHERE symbol = 'b';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'top', '/tɒp/', '', id FROM ipa_phonemes WHERE symbol = 't';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'dog', '/dɒg/', '', id FROM ipa_phonemes WHERE symbol = 'd';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'cat', '/kæt/', '', id FROM ipa_phonemes WHERE symbol = 'k';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'go', '/gəʊ/', '', id FROM ipa_phonemes WHERE symbol = 'g';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'fish', '/fɪʃ/', '', id FROM ipa_phonemes WHERE symbol = 'f';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'van', '/væn/', '', id FROM ipa_phonemes WHERE symbol = 'v';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'think', '/θɪŋk/', '', id FROM ipa_phonemes WHERE symbol = 'θ';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'this', '/ðɪs/', '', id FROM ipa_phonemes WHERE symbol = 'ð';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'sun', '/sʌn/', '', id FROM ipa_phonemes WHERE symbol = 's';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'zoo', '/zuː/', '', id FROM ipa_phonemes WHERE symbol = 'z';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'ship', '/ʃɪp/', '', id FROM ipa_phonemes WHERE symbol = 'ʃ';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'vision', '/ˈvɪʒən/', '', id FROM ipa_phonemes WHERE symbol = 'ʒ';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'hat', '/hæt/', '', id FROM ipa_phonemes WHERE symbol = 'h';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'man', '/mæn/', '', id FROM ipa_phonemes WHERE symbol = 'm';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'no', '/nəʊ/', '', id FROM ipa_phonemes WHERE symbol = 'n';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'sing', '/sɪŋ/', '', id FROM ipa_phonemes WHERE symbol = 'ŋ';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'light', '/laɪt/', '', id FROM ipa_phonemes WHERE symbol = 'l';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'red', '/red/', '', id FROM ipa_phonemes WHERE symbol = 'r';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'yes', '/jes/', '', id FROM ipa_phonemes WHERE symbol = 'j';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'we', '/wiː/', '', id FROM ipa_phonemes WHERE symbol = 'w';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'chair', '/tʃeə/', '', id FROM ipa_phonemes WHERE symbol = 'tʃ';

INSERT INTO ipa_words (id, text, ipa_text, audio_url, primary_phoneme_id)
SELECT gen_random_uuid(), 'job', '/dʒɒb/', '', id FROM ipa_phonemes WHERE symbol = 'dʒ';