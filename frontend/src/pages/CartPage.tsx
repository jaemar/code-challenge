import { useEffect, useState } from "react";
import { Cart } from "../types/cart";
import { fetchCartById } from "../actions/cartActions";
import { useParams } from "react-router-dom";

const CartPage = () => {
  const { id } = useParams();
  const [cart, setCart] = useState<Cart | null>(null);

  useEffect(() => {
    if (!id) return;
    fetchCartById(Number(id)).then(setCart);
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
