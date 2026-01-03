import React from 'react';

const sampleOrders = [
  { price: 100, amount: 5, type: 'bid' },
  { price: 101, amount: 10, type: 'bid' },
  { price: 102, amount: 2, type: 'ask' },
  { price: 103, amount: 8, type: 'ask' },
];

function getDepth(orders, type) {
  let depth = [];
  let cumulative = 0;
  orders.filter(o => o.type === type).forEach(order => {
    cumulative += order.amount;
    depth.push({ price: order.price, cumulative });
  });
  return depth;
}

export default function OrderBookDepthChart() {
  const bidDepth = getDepth(sampleOrders, 'bid');
  const askDepth = getDepth(sampleOrders, 'ask');

  return (
    <section>
      <h2>Order Book Depth Chart</h2>
      <div style={{ display: 'flex', gap: 40 }}>
        <div>
          <h3>Bids</h3>
          {bidDepth.map((d, idx) => (
            <div key={idx} style={{ marginBottom: 4 }}>
              <span>Price: {d.price}</span>
              <div style={{
                width: `${d.cumulative * 10}px`,
                height: '10px',
                background: '#b3e5fc',
                display: 'inline-block',
                marginLeft: 8,
              }} />
              <span style={{ marginLeft: 8 }}>Cumulative: {d.cumulative}</span>
            </div>
          ))}
        </div>
        <div>
          <h3>Asks</h3>
          {askDepth.map((d, idx) => (
            <div key={idx} style={{ marginBottom: 4 }}>
              <span>Price: {d.price}</span>
              <div style={{
                width: `${d.cumulative * 10}px`,
                height: '10px',
                background: '#ffcdd2',
                display: 'inline-block',
                marginLeft: 8,
              }} />
              <span style={{ marginLeft: 8 }}>Cumulative: {d.cumulative}</span>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
