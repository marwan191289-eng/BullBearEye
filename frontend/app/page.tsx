
'use client';

import { useEffect, useState } from "react";

export default function Home() {
  const [theme, setTheme] = useState<any>(null);
  useEffect(() => {
    fetch("/tenant-config").then(res => res.json()).then(setTheme);
  }, []);

  useEffect(() => {
    if (theme && theme.primaryColor) {
      document.body.style.background = theme.theme === "dark" ? "#18181b" : "#fff";
      document.body.style.color = theme.theme === "dark" ? "#fff" : "#000";
      document.body.style.setProperty("--primary-color", theme.primaryColor);
    }
  }, [theme]);

  return <main style={{ maxWidth: 400, margin: "40px auto", padding: 24, border: "1px solid #eee", borderRadius: 8 }}>
    <h1>{theme ? `مرحبًا بك في ${theme.name}` : "..."}</h1>
    <p>تمت إزالة نظام الاشتراكات.</p>
    {theme && <img src={theme.logo} alt="logo" style={{ maxWidth: 120, margin: "16px auto" }} />}
  </main>;
}
