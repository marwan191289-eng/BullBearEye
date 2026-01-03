import React from 'react';

interface WhaleTableProps {
  data: Array<{
    address: string;
    amount: number;
    txType: string;
    timestamp: string;
  }>;
}

const WhaleTable: React.FC<WhaleTableProps> = ({ data }) => (
  <div className="overflow-x-auto rounded-lg shadow bg-card">
    <table className="min-w-full text-sm rtl:text-right ltr:text-left">
      <thead>
        <tr className="bg-muted">
          <th className="px-4 py-2">العنوان</th>
          <th className="px-4 py-2">القيمة</th>
          <th className="px-4 py-2">نوع العملية</th>
          <th className="px-4 py-2">الوقت</th>
        </tr>
      </thead>
      <tbody>
        {data.map((row, idx) => (
          <tr key={idx} className="border-b border-border">
            <td className="px-4 py-2 font-mono break-all">{row.address}</td>
            <td className="px-4 py-2">{row.amount}</td>
            <td className="px-4 py-2">{row.txType}</td>
            <td className="px-4 py-2">{row.timestamp}</td>
          </tr>
        ))}
      </tbody>
    </table>
  </div>
);

export default WhaleTable;
