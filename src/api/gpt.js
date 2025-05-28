import axios from 'axios'

const gptInstance = axios.create({
  baseURL: 'https://api.openai.com/v1',
  headers: {
    'Content-Type': 'application/json',
    Authorization: "Bearer your api key",
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
