import { Cart } from "../types/cart";
import { getCart, getCarts, addToCart } from "../api/cartApi";

export const fetchCartById = async (id: number): Promise<Cart> => {
    const response = await getCart(id);
    return response.data;
};

export const fetchCarts = async (): Promise<Cart[]> => {
    const response = await getCarts();
    return response.data;
};

export const addProductToCart = async (cartId: number, productId: number): Promise<Cart> => {
    const response = await addToCart(cartId, productId);
    return response.data;
};