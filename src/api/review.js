import axios from 'axios';

export async function getAllReviews(videoId) {
  const { data } = await axios.get('/api/review', { params: { videoId } });
  return data;
}

export async function getSearchReviews(videoId, searchContent) {
  const { data } = await axios.get('/api/review/search', {
    params: { videoId, searchContent }
  });
  return data;
}

export async function getReviewById(reviewId) {
  const { data } = await axios.get(`/api/review/${reviewId}`);
  return data;
}

export async function addReview(review) {
  const { data } = await axios.post('/api/review', review);
  return data;
}

export async function updateReview(reviewId, title, content) {
  return await axios.put(`/api/review/${reviewId}`, { title, content });
}

export async function deleteReview(reviewId) {
  return await axios.delete(`/api/review/${reviewId}`);
}

export async function updateCount(reviewId) {
  return await axios.patch(`/api/review/${reviewId}/count`);
}
