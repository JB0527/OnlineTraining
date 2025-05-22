import axios from "axios";

const userApi = axios.create({
    baseURL: import.meta.env.VITE_PRJ_API_URL,
    headers: {
        'Content-Type': 'application/json',
        "access-token": sessionStorage.getItem('access-token')
    }
})

export default userApi;