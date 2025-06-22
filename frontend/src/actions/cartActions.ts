import { Cart } from "../types/cart";
import { getCart, getCarts } from "../api/carts";

export const fetchCartById = async (id: string): Promise<Cart> => {
    const response = await getCart(id);
    return response.data;
};

export const fetchCarts = async (): Promise<Cart[]> => {
    const response = await getCarts();
    return response.data;
};