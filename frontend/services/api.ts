export async function getSignal(symbol = "BTC/USDT") {
  const res = await fetch("http://127.0.0.1:8000/signals/?symbol=" + encodeURIComponent(symbol));
  if (!res.ok) throw new Error("Failed to fetch signal");
  return res.json();
}
