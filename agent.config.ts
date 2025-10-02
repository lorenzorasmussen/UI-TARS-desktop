import { defineConfig } from '@agent-tars/cli';

export default defineConfig({
  model: {
    provider: 'openai-compatible',
    id: 'pplx-7b-online', // Smaller Perplexity model with web search retrieval; use 'pplx-7b-chat' for offline chat
    apiKey: process.env.PERPLEXITY_API_KEY, // Your Perplexity API key from .env
    baseUrl: 'https://api.perplexity.ai',
  },
  // Add other config as needed
});
