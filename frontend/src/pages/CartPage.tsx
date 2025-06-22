import { useEffect, useState } from "react";
import { Cart } from "../types/cart";
import { fetchCartById } from "../actions/cartActions";

const CartPage = () => {
  const [cart, setCart] = useState<Cart | null>(null);

  useEffect(() => {
    fetchCartById("1").then(setCart);
  }, []);

  if (!cart) return <p>Loading...</p>;

  return (
    <div>
      <h1>Cart #{cart.id}</h1>
      <p>{cart.total_price} ({cart.currency})</p>
    </div>
  );
};

export default CartPage;
