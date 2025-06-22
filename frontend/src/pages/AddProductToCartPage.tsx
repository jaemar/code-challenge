import { useEffect, useState } from "react";
import { Product } from "../types/product";
import { fetchProducts } from "../actions/productActions";
import { addProductToCart } from "../actions/cartActions";
import { useParams } from "react-router-dom";

const AddProductToCartPage = () => {
  const { id } = useParams();

  const [products, setProducts] = useState<Product[]>([]);
  const [selectedProductId, setSelectedProductId] = useState<number | null>(null);
  const [loading, setLoading] = useState(false);
  const [status, setStatus] = useState<string | null>(null);

  useEffect(() => {
    if (!id) return;
    fetchProducts().then(setProducts);
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

      <select
        value={selectedProductId ?? ""}
        onChange={(e) => setSelectedProductId(Number(e.target.value))}
      >
        <option value="" disabled>Select a product</option>
        {products.map((product) => (
          <option key={product.id} value={product.id}>
            ({product.code}){product.name} - {product.price} {product.currency}
          </option>
        ))}
      </select>

      <button onClick={handleSubmit} disabled={!selectedProductId || loading}>
        {loading ? "Adding..." : "Add to Cart"}
      </button>

      {status && <p>{status}</p>}
    </div>
  );
};

export default AddProductToCartPage;
