# Project Design Document: English Learning MVP

## 1. Product Overview
- **Goal**: A multi-skill English Learning web application MVP supporting multiple user personas (beginners to test prep).
- **Core Skills**: Vocabulary, Pronunciation, Idioms, Reading, Listening, Writing, Speaking.
- **Key Features**: Topic-based vocabulary learning with active recall, audio pronunciation checking, reading comprehension with pop-up dictionary, idioms flashcards, and AI-assisted speaking/writing evaluation.

## 2. Target Audience
- **General English Learners**: Focus on vocabulary, listening, reading, idioms, and pronunciation.
- **Test Prep Users (IELTS/TOEIC/TOEFL)**: Focus on AI-graded writing and speaking.
- **Business Professionals**: Practical application of communication skills.

## 3. Technology Stack
- **Frontend**: ReactJS, TypeScript, Vite, Tailwind CSS. Focus on a highly interactive and responsive UI.
- **Backend**: Java (Spring Boot) following a Granular Microservices architecture.
- **Database**: PostgreSQL (Core Data). Redis (Caching/Rankings). Cloud Storage like AWS S3 (Audio/Images).
- **Third-Party Integrations**: OpenAI / Gemini APIs for AI Grading and Speech-to-Text.

## 4. Architecture: Granular Microservices
The system will be split into specialized domains to allow for independent scaling and development. All services will be containerized and orchestrated locally using **Docker Compose**.

1. **API Gateway**: Route requests from frontend to specific microservices, handling cross-cutting concerns (CORS, Rate Limiting).
2. **Identity & Auth Service**: Manage users, login, registration, and JWT tokens.
3. **Core Learning Service (Vocabulary & Grammar)**:
   - Handle topic creation.
   - Manage the core learning loop: View Word -> Spell Word -> Play Pronunciation Audio.
4. **Assessment Service (Reading/Listening/Idioms)**:
   - Manage reading passages, listening audio, and multiple-choice questions.
5. **AI Evaluator Service (Speaking/Writing)**:
   - Handle text/audio submission from users.
   - Communicate securely with OpenAI/Gemini to process Speech-to-Text and evaluate grammar/fluency.
   - Return structured feedback to the user.
6. **Docker Compose**: Used to spin up all backend microservices, the PostgreSQL database, and Redis cache simultaneously for local development.

## 5. Non-Functional Requirements (Assumptions)
- **Scale**: Built to handle thousands of active users gracefully thanks to Spring Boot and Microservices.
- **Performance**: High focus on frontend load speed and instantaneous feedback during vocabulary learning. AI assessments might have a slight delay (asynchronous processing if needed).
- **Maintenance**: Using Java Spring Boot ensures enterprise-grade maintainability, strong typing, and vast ecosystem support.

## 6. Development Phases
1. **Foundation**: System setup, API gateway, Identity Service.
2. **Phase 1: Vocabulary MVP**: Build the topic-based vocabulary feature end-to-end to release the first playable version.
3. **Phase 2: Receptive Skills**: Add Reading, Listening, and Idioms modules with standard quizzes.
4. **Phase 3: Productive Skills (AI)**: Integrate AI to power Speaking, Pronunciation, and Writing evaluations.
