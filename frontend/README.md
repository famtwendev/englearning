# English Learning MVP - Frontend

This project was bootstrapped with Vite, React, TypeScript, and Tailwind CSS.

## Features
- **State Management**: Zustand
- **Routing**: React Router
- **Styling**: Tailwind CSS
- **API Client**: Axios (with interceptors for JWT auth)

## Prerequisites
- Node.js (v18 or higher recommended)
- npm or yarn

## Getting Started

### 1. Install Dependencies
```bash
npm install
```

### 2. Configure Environment Variables
Ensure the backend services (API Gateway) are running locally, typically on `http://localhost:8080`.
The API client default base URL points to `http://localhost:8080/api/v1`.

### 3. Start Development Server
```bash
npm run dev
```

Open `http://localhost:5173` with your browser to see the result. The development server supports Hot Module Replacement (HMR).
