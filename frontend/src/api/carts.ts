
import api from "./api";
import { Cart } from "../types/cart";

export const getCart = (id: string) => {
    return api.get<Cart>(`/carts/${id}`);
}

export const getCarts = () => {
    return api.get<Cart[]>(`/carts`);
};