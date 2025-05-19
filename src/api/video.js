import axios from 'axios';

const BASE_URL = "http://localhost:8080/api/v1/video"

const getVideoList =  async() => {
  const { data } = await axios.get(BASE_URL);
  return data;
}

export async function getVideoDetail(videoId) {
  const { data } = await axios.get(BASE_URL+"/"+videoId);
  return data;
}

export async function insertVideo(video) {
  const { data } = await axios.post(BASE_URL, video);
  return data;
}

export async function updateVideo(video) {
  const { data } = await axios.put(BASE_URL, video);
  return data;
}

export async function deleteVideo(videoId) {
  return await axios.delete(BASE_URL+"/"+videoId);
}
export {
    getVideoList,
    
}
