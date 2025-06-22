import { useEffect, useState } from "react";
import { fetchCarts, newCart } from "../actions/cartActions";
import { Cart } from "../types/cart";
import { Link, useNavigate } from "react-router-dom";

const CartListingPage = () => {
  const navigate = useNavigate();
  const [carts, setCarts] = useState<Cart[] | null>(null);

  useEffect(() => {
    fetchCarts().then(setCarts);
  }, []);

  if (!carts) return <p>Loading...</p>;
  const handleCreateCart = async () => {
    try {
      const cart = await newCart();
      navigate(`/${cart.id}/add_product`, {
        state: { status: "Cart successfully created."}
      });
    } catch (error) {
      console.log("Failed to create cart: ", error);
    }
  };

  return (
    <div>
      <h1>Carts</h1>

      <button
        className="btn btn-primary"
        onClick={handleCreateCart}>
        New Cart
      </button>
      <table className="table table-striped">
        <thead>
            <tr>
                <th scope="col">Basket</th>
                <th scope="col">Total Price</th>
                <th scope="col">Action</th>
            </tr>
        </thead>
        <tbody>
            {carts.map(cart => (
            <tr>
                <td>
                    {cart.basket ? cart.basket : '-'}
                </td>
                <td>
                    {cart.total_price} {cart.currency}
                </td>
                <td>
                  <Link to={`/${cart.id}/add_product`} className="btn btn-primary">Add Product</Link>
                </td>
            </tr>
            ))}
        </tbody>
      </table>
    </div>
  );
};

export default CartListingPage;
