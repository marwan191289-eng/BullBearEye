import React from 'react';

const ThemeToggle: React.FC = () => {
  // Placeholder: Implement theme switching logic (dark/light)
  return (
    <button
      className="rounded px-3 py-1 bg-muted text-primary hover:bg-primary hover:text-background transition"
      aria-label="تبديل الوضع الليلي"
    >
      🌓
    </button>
  );
};

export default ThemeToggle;
