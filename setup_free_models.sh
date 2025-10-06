/*

 */
#!/bin/bash
# Setup script for free model API keys

echo "Setting up free model API keys for Trae Agent..."

# Google AI Studio (1M tokens/min free)
echo "Visit: https://makersuite.google.com/app/apikey"
echo "Create API key and set: GOOGLE_API_KEY=your_key"
export GOOGLE_API_KEY="your_google_api_key_here"

# Groq (300+ tokens/sec free)
echo "Visit: https://console.groq.com"
echo "Get API key and set: GROQ_API_KEY=your_key"
export GROQ_API_KEY="your_groq_api_key_here"

# OpenRouter (free tier models)
echo "Visit: https://openrouter.ai/keys"
echo "Create account and key, set: OPENROUTER_API_KEY=your_key"
export OPENROUTER_API_KEY="your_openrouter_api_key_here"

# DeepSeek (generous free tier)
echo "Visit: https://platform.deepseek.com"
echo "Register and get API key, set: DEEPSEEK_API_KEY=your_key"
export DEEPSEEK_API_KEY="your_deepseek_api_key_here"

# Hugging Face (300+ free models)
echo "Visit: https://huggingface.co/settings/tokens"
echo "Generate token, set: HUGGINGFACE_TOKEN=your_token"
export HUGGINGFACE_TOKEN="your_huggingface_token_here"

echo "API keys setup complete!"
echo "Remember to replace the placeholder values with your actual API keys."
