
import api from "./api";
import { Cart } from "../types/cart";

export const createCart = () => {
    return api.post<Cart>('/carts');
}

export const getCart = (id: number) => {
    return api.get<Cart>(`/carts/${id}`);
}

export const getCarts = () => {
    return api.get<Cart[]>(`/carts`);
};

export const addToCart = (cartId: number, productId: number) => {
    const params = {
        item: {
            product_id: productId
        }
    }
    return api.post<Cart>(`/carts/${cartId}/add_to_basket`, params);
}