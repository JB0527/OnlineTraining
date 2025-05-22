import api from '@/api/index';
import userApi from '@/api/login';

const API_BASE = 'http://localhost:8080/api/v1/review';

const getAllReviews =  async(videoId) =>{
  const {data} = await api.get(`${API_BASE}/${videoId}`);
  return data;
}


const getSearchReviews =  async(videoId, content)=> {
  const {data} = await api.get(`${API_BASE}/search`, {
    params: { videoId, content }
  });
  return data;
}

const getReviewDetail =  async(reviewId) =>{
  const {data} = await api.get(`${API_BASE}/review/${reviewId}`);
  return data;
}

const writeReview =  async(reviewData) =>{
  const {data} = await userApi.post(API_BASE, reviewData);
  return data;
}

const updateReview =  async(reviewId, reviewData) =>{
  const {data} = await api.put(`${API_BASE}/${reviewId}`, reviewData);
  return data;
}

const deleteReview =  async(reviewId) =>{
  const {data} = await api.delete(`${API_BASE}/${reviewId}`);
  return data;
}

const updateClickCount =  async(reviewId) =>{
  const {data} = await api.patch(`${API_BASE}/${reviewId}/click`);
  return data;
}
export {
    getAllReviews,
    getSearchReviews,
    getReviewDetail,
    writeReview,
    updateReview,
    deleteReview,
    updateClickCount
}
