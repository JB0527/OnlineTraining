import axios from 'axios';

const API_BASE = 'http://localhost:8080/api/v1/review';

export async function getAllReviews(videoId) {
  const res = await axios.get(`${API_BASE}/${videoId}`);
  return res.data;
}

export async function getSearchReviews(videoId, content) {
  const res = await axios.get(`${API_BASE}/search`, {
    params: { videoId, content }
  });
  return res.data;
}

export async function getReviewDetail(reviewId) {
  const res = await axios.get(`${API_BASE}/review/${reviewId}`);
  return res.data;
}

export async function writeReview(reviewData) {
  const res = await axios.post(API_BASE, reviewData);
  return res.data;
}

export async function updateReview(reviewId, reviewData) {
  const res = await axios.put(`${API_BASE}/${reviewId}`, reviewData);
  return res.data;
}

export async function deleteReview(reviewId) {
  const res = await axios.delete(`${API_BASE}/${reviewId}`);
  return res.data;
}

export async function updateClickCount(reviewId) {
  const res = await axios.patch(`${API_BASE}/${reviewId}/click`);
  return res.data;
}
