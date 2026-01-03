## Feature Request: Institutional-Grade Signal Engine

**Summary:**
Implement an institutional-grade Signal Engine based on market structure (BOS/CHoCH), liquidity sweeps, order-flow confirmation, and smart money phases. The engine should produce confidence-scored trade recommendations with dynamic risk parameters (entry, SL, TP).

**Details:**
- Market structure detection (Break of Structure, Change of Character)
- Liquidity sweep identification
- Order-flow confirmation
- Smart money phase analysis
- Confidence scoring for signals
- Dynamic risk parameters (entry, stop-loss, take-profit)
- Integration with existing AI/ML and compliance logging

**Acceptance Criteria:**
- Signals include reason and confidence score
- Risk parameters are dynamically calculated
- All signals logged for audit
- Refactor existing signal logic to use new institutional methods

---
Alternative (bug/tech debt):
Current signal logic relies on basic indicators and lacks liquidity/order-flow validation, resulting in low-confidence and false signals. Refactor to institutional logic with proper scoring and risk management.
