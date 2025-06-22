import api from "./api";
import { Product } from "../types/product";

export const getProducts = () => {
    return api.get<Product[]>("/products");
}