import { Item } from "./item";

export interface Cart {
    id: number;
    total_price: string;
    basket: string;
    currency: string;
    items: Item[];
    discount: string;
    subtotal: string;
}