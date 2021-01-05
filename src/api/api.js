import axios from 'axios';

let headers = {
    'Authorization': localStorage.getItem("accessToken"),
    "Content-type": "Application/json",
}
let local_host = 'http://localhost:3000';
console.log(headers)


export const getShopCarts = () => { return axios.get(`/api/get-cart`), {headers: headers}}

export const addShopCart = params => { return axios.post(`${local_host}/shopcarts/`, params) }

export const updateShopCart = (goodsId, params) => { return axios.put(`${local_host}/update-merchandise-quantity`, params) }

export const deleteShopCart = goodsId => { return axios.delete(`${local_host}/delete-merchandise/`+goodsId+'/') }
