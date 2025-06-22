import { Product } from "../types/product";
import { getProducts } from "../api/productApi";

export const fetchProducts = async (): Promise<Product[]> => {
    const response = await getProducts();
    return response.data;
}