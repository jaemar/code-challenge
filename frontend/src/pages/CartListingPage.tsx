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
    <div className="container-fluid">
      <div className="row">
        <div className="col">
          <h1 className="float-start">Carts</h1>
        </div>
        <div className="col d-flex justify-content-end align-items-center">
          <button
            className="btn btn-primary"
            onClick={handleCreateCart}>
            New Cart
          </button>
        </div>
      </div>
      <div>
        <table className="table table-striped table-bordered">
          <thead>
              <tr>
                  <th scope="col"></th>
                  <th scope="col">Basket</th>
                  <th scope="col">Total Price</th>
                  <th scope="col">Actions</th>
              </tr>
          </thead>
          <tbody>
              {carts.map(cart => (
              <tr>
                  <td scope="row" className="text-center align-middle">
                      {cart.id}
                  </td>
                  <td className="text-start align-middle">
                      {cart.basket ? cart.basket : '-'}
                  </td>
                  <td className="text-start align-middle">
                      {cart.total_price} {cart.currency}
                  </td>
                  <td>
                    <Link to={`/${cart.id}`} className="btn btn-outline-secondary">View</Link>
                    <Link to={`/${cart.id}/add_product`} className="btn btn-outline-primary">Add Product</Link>
                  </td>
              </tr>
              ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default CartListingPage;
