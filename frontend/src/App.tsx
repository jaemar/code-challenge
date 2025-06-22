import { Routes, Route } from "react-router-dom";
import CartPage from "./pages/CartPage";
import CartListingPage from "./pages/CartListingPage";

function App() {
  return (
    <Routes>
      <Route path="/carts/:id" element={<CartPage />} />
      <Route path="/carts" element={<CartListingPage />} />
    </Routes>
  );
}

export default App;
