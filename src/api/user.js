import api from '@/api/index';

const API_BASE = 'http://localhost:8080/api/v1/user';

const signup =  async(user) =>{
  const { data } = await api.post(`${API_BASE}/signup`, user);
  return data;
}

const subscribe = async(userId) => {
  await api.put(`${API_BASE}/subscribe/${userId}`);
}

export {
    signup,
    subscribe
}