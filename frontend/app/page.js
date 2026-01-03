import OrderBook from './OrderBook';
import OrderBookDepthChart from './OrderBookDepthChart';

export default function Home() {
  return (
    <main>
      <h1>Welcome to BullBearEye!</h1>
      <p>This is a default Next.js entry point.</p>
      <OrderBook />
      <OrderBookDepthChart />
    </main>
  );
}
