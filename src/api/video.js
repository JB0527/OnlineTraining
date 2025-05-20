import api from '@/api/index';

const BASE_URL = "http://localhost:8080/api/v1/video"

const getVideoList =  async() => {
  const { data } = await api.get(BASE_URL);
  return data;
}

const getVideoDetail = async(videoId) => {
  const { data } = await api.get(BASE_URL+"/"+videoId);
  return data;
}

const insertVideo = async(video) => {
  const { data } = await api.post(BASE_URL, video);
  return data;
}

const updateVideo = async(video) => {
  const { data } = await api.put(BASE_URL, video);
  return data;
}

const deleteVideo = async(videoId) => {
  return await api.delete(BASE_URL+"/"+videoId);
}
export {
    getVideoList,
    getVideoDetail,
    insertVideo,
    updateVideo,
    deleteVideo
}
