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

  return (
    <div className="container-fluid">
      <h1>Cart ID: {id}</h1>
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
            { !cart ? (
              <tr>
                <td colSpan={3} className="text-center align-middle">
                  Loading...
                </td>
              </tr>
            ) : (
              cart.items.map(item => (
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
              ))
            )}
            <tr>
              <td colSpan={3}></td>
            </tr>
            <tr className="font-weight-bold">
              <td colSpan={2}>Subtotal: </td>
              <td>{ !cart ? "0" : `${cart.subtotal}${cart.currency}` }</td>
            </tr>
            <tr className="font-weight-bold">
              <td colSpan={2}>Applied discount: </td>
              <td>{ !cart ? "0" : `${cart.discount}${cart.currency}` }</td>
            </tr>
            <tr className="font-weight-bold">
              <td colSpan={2}>Total: </td>
              <td>{ !cart ? "0" : `${cart.total_price}${cart.currency}` }</td>
            </tr>
          </tbody>
        </table>
      </div>
      <div>
        <Link to={`/`} className="btn btn-outline-secondary">Back</Link>
        {cart && (
          <Link to={`/${cart.id}/add_product`} className="btn btn-outline-primary float-end">Add Product</Link>
        )}
      </div>
    </div>
  );
};

export default CartPage;
