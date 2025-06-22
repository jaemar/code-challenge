import { useEffect, useState } from "react";
import { Product } from "../types/product";
import { fetchProducts } from "../actions/productActions";
import { addProductToCart } from "../actions/cartActions";
import { Link, useLocation, useParams } from "react-router-dom";

const AddProductToCartPage = () => {
  const { id } = useParams();
  const location = useLocation();

  const [products, setProducts] = useState<Product[]>([]);
  const [selectedProductId, setSelectedProductId] = useState<number | null>(null);
  const [loading, setLoading] = useState(false);
  const [status, setStatus] = useState<string | null>(null);
  const newCartStatus = location.state?.status;

  useEffect(() => {
    if (!id) return;
    fetchProducts().then(setProducts);
    
    if (newCartStatus) {
      setStatus(newCartStatus)
    }
  }, []);

  const handleSubmit = async () => {
    if (!selectedProductId) return;

    setLoading(true);
    setStatus(null);

    try {
      await addProductToCart(Number(id), selectedProductId);
      setStatus("Product added to cart!");
    } catch (error) {
      setStatus("Error adding product.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div>
      <h1>Add Product to Cart</h1>

      {status && <div className="alert alert-primary">{status}</div>}
      <div className="input-group mb-3">
        <div className="input-group-prepend">
          <label className="input-group-text">Products</label>
        </div>
        <select
          className="form-control"
          value={selectedProductId ?? ""}
          onChange={(e) => setSelectedProductId(Number(e.target.value))}
        >
          <option value="" disabled>Choose...</option>
          {products.map((product) => (
            <option key={product.id} value={product.id}>
              ({product.code}){product.name} - {product.price} {product.currency}
            </option>
          ))}
        </select>
      </div>
      <div>
        <button onClick={handleSubmit} disabled={!selectedProductId || loading} className="btn btn-outline-primary">
          {loading ? "Adding..." : "Add to Cart"}
        </button>
        <Link to={`/`} className="btn btn-outline-secondary">Cancel</Link>
      </div>
    </div>
  );
};

export default AddProductToCartPage;
