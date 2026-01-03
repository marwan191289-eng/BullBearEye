import Header from "../components/Header";
import StatCard from "../components/StatCard";
import SignalCard from "../components/SignalCard";
import WhaleTable from "../components/WhaleTable";

const whaleData = [
  { address: "0x123...abcd", amount: 1200, txType: "شراء", timestamp: "2026-01-02 12:00" },
  { address: "0x456...efgh", amount: 800, txType: "بيع", timestamp: "2026-01-02 13:00" },
];

export default function Home() {
  return (
    <div className="min-h-screen bg-background text-foreground font-sans flex flex-col gap-8">
      <Header />
      <main className="flex flex-col gap-8 px-4 max-w-5xl mx-auto w-full">
        <section className="flex flex-wrap gap-4 justify-center md:justify-between">
          <StatCard label="إجمالي الصفقات" value={2026} />
          <StatCard label="حجم التداول" value={"$1.2M"} />
          <StatCard label="عدد الحيتان" value={42} />
        </section>
        <section className="flex flex-col md:flex-row gap-4">
          <SignalCard title="إشارة السوق" description="السوق في حالة صعود قوية." signal="bullish" />
          <SignalCard title="إشارة الحيتان" description="نشاط شراء مرتفع من الحيتان." signal="bullish" />
        </section>
        <section>
          <h2 className="text-xl font-bold mb-2">جدول الحيتان</h2>
          <WhaleTable data={whaleData} />
        </section>
      </main>
    </div>
  );
}
// ...existing code...
