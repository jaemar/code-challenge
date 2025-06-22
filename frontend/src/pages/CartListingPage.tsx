import { useEffect, useState } from "react";
import { fetchCarts } from "../actions/cartActions";
import { Cart } from "../types/cart";
import { Link } from "react-router-dom";

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
                <th>Action</th>
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
                <td>
                  <Link to={`/${cart.id}/add_product`}>Add Product</Link>
                </td>
            </tr>
            ))}
        </tbody>
      </table>
    </div>
  );
};

export default CartListingPage;
