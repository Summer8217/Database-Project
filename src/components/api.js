import axios from 'axios';

const headers = {
    'Authorization': localStorage.getItem("accessToken")
}
let local_host = 'http://127.0.0.1:3000';
console.log(headers)

export const getShopCarts = () => { return axios.get(`${local_host}/get-cart`,{headers: headers} )}

export const addShopCart = params => { return axios.post(`${local_host}/shopcarts/`, params) }

export const updateShopCart = (goodsId, params) => { return axios.put(`${local_host}/update-merchandise-quantity`, params) }

export const deleteShopCart = goodsId => { return axios.delete(`${local_host}/delete-merchandise/`+goodsId+'/') }
