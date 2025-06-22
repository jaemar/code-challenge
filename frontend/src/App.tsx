import { Routes, Route } from "react-router-dom";
import CartPage from "./pages/CartPage";
import CartListingPage from "./pages/CartListingPage";
import AddProductToCartPage from "./pages/AddProductToCartPage";

function App() {
  return (
    <Routes>
      <Route path="/:id" element={<CartPage />} />
      <Route path="/" element={<CartListingPage />} />
      <Route path="/:id/add_product" element={<AddProductToCartPage />} />
    </Routes>
  );
}

export default App;
