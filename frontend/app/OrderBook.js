import React, { useState } from 'react';

const sampleOrders = [
  { price: 100, amount: 5, total: 5, type: 'bid' },
  { price: 101, amount: 10, total: 15, type: 'bid' },
  { price: 102, amount: 2, total: 17, type: 'ask' },
  { price: 103, amount: 8, total: 25, type: 'ask' },
];

export default function OrderBook() {
  const [threshold, setThreshold] = useState(0);
  const filteredOrders = sampleOrders.filter(o => o.amount >= threshold);

  return (
    <section>
      <h2>Order Book</h2>
      <label>
        Filter by amount:
        <select value={threshold} onChange={e => setThreshold(Number(e.target.value))}>
          <option value={0}>All</option>
          <option value={5}>Above 5</option>
          <option value={10}>Above 10</option>
        </select>
      </label>
      <table style={{ width: '100%', marginTop: 10 }}>
        <thead>
          <tr>
            <th>Type</th>
            <th>Price</th>
            <th>Amount</th>
            <th>Total</th>
          </tr>
        </thead>
        <tbody>
          {filteredOrders.map((order, idx) => (
            <tr key={idx}>
              <td>{order.type}</td>
              <td>{order.price}</td>
              <td>
                <div style={{ display: 'flex', alignItems: 'center' }}>
                  <div style={{
                    width: `${order.amount * 10}px`,
                    height: '10px',
                    background: order.type === 'bid' ? '#b3e5fc' : '#ffcdd2',
                    marginRight: 5,
                  }} />
                  {order.amount}
                </div>
              </td>
              <td>
                <div style={{ display: 'flex', alignItems: 'center' }}>
                  <div style={{
                    width: `${order.total * 5}px`,
                    height: '10px',
                    background: order.type === 'bid' ? '#81d4fa' : '#ef9a9a',
                    marginRight: 5,
                  }} />
                  {order.total}
                </div>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </section>
  );
}
