export async function fetchYoutubeLinks(videoTitles) {
  const titlesArray = Array.isArray(videoTitles) ? videoTitles : [videoTitles];

  const prompt = `운동 목적에 맞는 유튜브 영상 링크를 최대 5개 추천해줘. 각 영상은 새로운 줄로 구분해서 제공해줘.`;

  const response = await fetch("https://api.openai.com/v1/chat/completions", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Authorization: "Bearer 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",
    },
    body: JSON.stringify({
      model: "gpt-3.5-turbo",
      messages: [
        {
          role: "system",
          content: "운동 목적에 맞는 유튜브 영상 링크를 여러 개 추천해줘. 각 링크는 줄바꿈으로 구분하고, 링크에 설명 달아줘."
        },
        {
          role: "user",
          content: prompt + "\n\n운동 목적:\n" + titlesArray.join('\n')
        }
      ],
      temperature: 0.7
    })
  });

  const data = await response.json();
  const content = data.choices?.[0]?.message?.content || "";
  const links = [...content.matchAll(/https?:\/\/[^\s]+/g)].map(m => m[0]);

  return {
    links,
    text: content
  };
}
