import React from 'react';

interface SignalCardProps {
  title: string;
  description: string;
  signal: 'bullish' | 'bearish' | 'neutral';
}

const signalColors = {
  bullish: 'text-green-500',
  bearish: 'text-red-500',
  neutral: 'text-gray-500',
};

const SignalCard: React.FC<SignalCardProps> = ({ title, description, signal }) => (
  <div className="bg-card rounded-lg shadow p-4 flex flex-col gap-2">
    <div className="flex items-center gap-2">
      <span className={`font-bold ${signalColors[signal]}`}>{signal.toUpperCase()}</span>
      <span className="text-lg font-semibold text-primary">{title}</span>
    </div>
    <div className="text-sm text-muted-foreground">{description}</div>
  </div>
);

export default SignalCard;
