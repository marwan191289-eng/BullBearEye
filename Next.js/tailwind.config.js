/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: 'class',
  content: [
    "./src/app/**/*.{js,ts,jsx,tsx}",
    "./src/components/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ["var(--font-geist-sans)", "sans-serif"],
        mono: ["var(--font-geist-mono)", "monospace"],
      },
      colors: {
        primary: '#00BFAE',
        background: '#18181b',
        card: '#23232a',
        border: '#333',
        muted: '#2d2d36',
        'muted-foreground': '#a1a1aa',
      },
    },
  },
  plugins: [require('tailwindcss-rtl')],
};
