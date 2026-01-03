import React from "react";

export default function TradingChart() {
  return (
    <iframe
      src="https://s.tradingview.com/widgetembed/?symbol=BINANCE:BTCUSDT"
      style={{ width: "100%", height: 500, border: 0 }}
      allowFullScreen
      title="TradingView Chart"
    />
  );
}
