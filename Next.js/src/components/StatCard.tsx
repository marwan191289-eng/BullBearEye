import React from 'react';

interface StatCardProps {
  label: string;
  value: string | number;
  icon?: React.ReactNode;
}

const StatCard: React.FC<StatCardProps> = ({ label, value, icon }) => (
  <div className="flex flex-col items-center justify-center bg-card rounded-lg shadow p-4 min-w-[120px]">
    {icon && <div className="mb-2 text-primary">{icon}</div>}
    <div className="text-2xl font-bold text-primary">{value}</div>
    <div className="text-sm text-muted-foreground mt-1">{label}</div>
  </div>
);

export default StatCard;
