import { useEffect, useState } from "react";
import { Cart } from "../types/cart";
import { fetchCartById } from "../actions/cartActions";
import { Link, useParams } from "react-router-dom";

const CartPage = () => {
  const { id } = useParams();
  const [cart, setCart] = useState<Cart | null>(null);

  useEffect(() => {
    if (!id) return;
    fetchCartById(Number(id)).then(setCart);
  }, []);

  if (!cart) return <p>Loading...</p>;

  return (
    <div className="container-fluid">
      <h1>Cart ID: {cart.id}</h1>
      <div>
        <table className="table table-striped table-bordered">
          <thead>
            <tr>
              <th scope="col">Code</th>
              <th scope="col">Name</th>
              <th scope="col">Price</th>
            </tr>
          </thead>
          <tbody>
            {cart.items.map(item => (
              <tr>
                <td className="text-start align-middle">
                  {item.product.code}
                </td>
                <td className="text-start align-middle">
                  {item.product.name}
                </td>
                <td className="text-start align-middle">
                  {item.product.price} {item.product.currency}
                </td>
              </tr>
            ))}
            <tr className="font-weight-bold">
              <td colSpan={2}>Total: </td>
              <td>{cart.total_price} ({cart.currency})</td>
            </tr>
          </tbody>
        </table>
      </div>
      <div>
        <Link to={`/`} className="btn btn-outline-secondary">Back</Link>
        <Link to={`/${cart.id}/add_product`} className="btn btn-outline-primary float-end">Add Product</Link>
      </div>
    </div>
  );
};

export default CartPage;
