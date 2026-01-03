export default function Layout({ children }) {
  return (
    <div>
      <header>
        <h2>BullBearEye</h2>
      </header>
      <main>{children}</main>
      <footer>
        <p>&copy; 2026 BullBearEye</p>
      </footer>
    </div>
  );
}
