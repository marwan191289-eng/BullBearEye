import Link from "next/link";

export default function Footer() {
  return (
    <footer style={{textAlign: "center", padding: 16, fontSize: 13, color: "#888"}}>
      <span>
        جميع المعلومات المقدمة لأغراض تعليمية فقط ولا تشكل نصيحة استثمارية. <Link href="/disclaimer">إخلاء المسؤولية</Link> | <Link href="/terms">الشروط</Link> | <Link href="/compliance">الامتثال</Link>
      </span>
    </footer>
  );
}
