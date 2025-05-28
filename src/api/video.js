import api from '@/api/index';
import userApi from '@/api/login';
// TODO 로그인 필요한 API 접근 시 userApi로 변경바람. -> 비디오 등록 시에 유저 아이디와 이름이 들어가야 결제 시스템 가능할 듯?
const BASE_URL = "http://localhost/api/v1/video";

const getVideoList =  async() => {
  const { data } = await api.get(BASE_URL);
  return data;
}

const getVideoListDesc =  async() => {
  const { data } = await api.get(BASE_URL+"/desc");
  return data;
}

const getVideoDetail = async(videoId) => {
  const { data } = await api.get(BASE_URL+"/"+videoId);
  return data;
}

const insertVideo = async(video) => {
  const { data } = await userApi.post(BASE_URL+"/insert", video);
  return data;
}

const updateVideo = async(video) => {
  const { data } = await api.put(BASE_URL, video);
  return data;
}

const deleteVideo = async(videoId) => {
  return await userApi.delete(BASE_URL+"/delete/"+videoId);
}

const updateClickCount =  async(videoId) =>{
  const {data} = await api.patch(`${BASE_URL}/${videoId}/click`);
  return data;
}

export {
    getVideoList,
    getVideoDetail,
    insertVideo,
    updateVideo,
    deleteVideo,
    updateClickCount,
    getVideoListDesc
}
