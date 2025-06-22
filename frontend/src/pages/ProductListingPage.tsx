import { useEffect, useState } from "react";
import { Product } from "../types/product";
import { fetchProducts } from "../actions/productActions";

const ProductListingPage = () => {
  const [products, setProducts] = useState<Product[] | null>(null);

  useEffect(() => {
    fetchProducts().then(setProducts);
  }, []);

  return (
    <div className="container-fluid">
      <div className="row">
        <div className="col">
          <h1 className="float-start">Products</h1>
        </div>
      </div>
      <div>
        <table className="table table-striped table-bordered">
          <thead>
              <tr>
                  <th scope="col">Code</th>
                  <th scope="col">Basket</th>
                  <th scope="col">Total Price</th>
              </tr>
          </thead>
          <tbody>
            { !products ? (
              <tr>
                <td colSpan={4} className="text-center align-middle">
                  Loading...
                </td>
              </tr>
            ) : (
              products.map(product => (
                <tr>
                    <td scope="row" className="text-start align-middle">
                        {product.code}
                    </td>
                    <td className="text-start align-middle">
                        {product.name}
                    </td>
                    <td className="text-start align-middle">
                        {product.price} {product.currency}
                    </td>
                </tr>
              ))
            )}
          </tbody>
        </table>
      </div>
    </div>
  )
};

export default ProductListingPage;