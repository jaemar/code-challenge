import { useEffect, useState } from "react";
import { fetchCarts } from "../actions/cartActions";
import { Cart } from "../types/cart";

const CartListingPage = () => {
  const [carts, setCarts] = useState<Cart[] | null>(null);

  useEffect(() => {
    fetchCarts().then(setCarts);
  }, []);

  if (!carts) return <p>Loading...</p>;

  return (
    <div>
      <h1>Carts</h1>
      <table>
        <thead>
            <tr>
                <th>Basket</th>
                <th>Total Price</th>
            </tr>
        </thead>
        <tbody>
            {carts.map(cart => (
            <tr>
                <td>
                    {cart.basket}
                </td>
                <td>
                    {cart.total_price} {cart.currency}
                </td>
            </tr>
            ))}
        </tbody>
      </table>
    </div>
  );
};

export default CartListingPage;
