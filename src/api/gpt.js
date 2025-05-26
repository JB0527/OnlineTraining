import axios from 'axios'

const gptInstance = axios.create({
  baseURL: 'https://api.openai.com/v1',
  headers: {
    'Content-Type': 'application/json',
    Authorization: "Bearer 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",
  }
})

export async function chatWithGPT(messages) {
  const response = await gptInstance.post('/chat/completions', {
    model: 'gpt-3.5-turbo',
    messages: [
      { role: 'system', content: 'You are a helpful assistant.' },
      ...messages
    ],
    temperature: 0.7
  })
  return response.data.choices[0].message.content.trim()
}
