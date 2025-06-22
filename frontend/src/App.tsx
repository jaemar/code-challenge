import { Routes, Route } from "react-router-dom";
import CartPage from "./pages/CartPage";
import CartListingPage from "./pages/CartListingPage";
import AddProductToCartPage from "./pages/AddProductToCartPage";
import ProductListingPage from "./pages/ProductListingPage";

function App() {
  return (
    <Routes>
      <Route path="/" element={<CartListingPage />} />
      <Route path="/carts" element={<CartListingPage />} />

      <Route path="/:id" element={<CartPage />} />
      <Route path="/carts/:id" element={<CartPage />} />

      <Route path="/:id/add_product" element={<AddProductToCartPage />} />

      <Route path="/products" element={<ProductListingPage />} />
    </Routes>
  );
}

export default App;
