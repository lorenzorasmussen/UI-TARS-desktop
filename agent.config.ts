import { defineConfig } from '@agent-tars/cli';

export default defineConfig({
  model: {
    provider: 'openrouter',
    id: 'openrouter/sonoma-dusk-alpha', // Default model
    apiKey: process.env.OPENROUTER_API_KEY,
  },
  // Add other config as needed
});
