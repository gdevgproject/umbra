# CTR-RESOURCE-MODIFIER — Resource, cost và modifier

> **DRI:** Systems Designer
> **Status:** `DISCOVERY`

Resource definition khai owner, scope, cap, current value, cost moment, refund, recovery, persistence và UI visibility. Cost là reservation/commit/refund có transaction ID; thất bại/retry không trừ hai lần.

Contract này sở hữu giao dịch chung. Semantic riêng của HP/Vigor, environmental damage, rule khi Max đổi và HUD fixed-width thuộc [`CTR-VITALS-HUD`](08-vitals-resource-and-hud-contract.md) cùng [`CTR-TRAVERSAL`](09-traversal-state-surface-and-vigor-contract.md); không lặp công thức hoặc presentation tại đây.

Modifier có source ID, target stat/tag, operation, priority/layer, duration/expiry, stacking key, cap và dispel/persistence. Thứ tự chuẩn phải được Parameter Registry khóa trước implementation. Không cộng stat bằng callback ẩn rải trong feature.

HP, Vigor, currency, charge và attempt dùng vocabulary này nhưng có policy riêng ở domain owner. Mana, Focus, Fatigue và Posture đã bị xóa; migration có thể đọc field cũ nhưng runtime không đăng ký chúng. Vigor/surface/locomotion transition thuộc [`CTR-TRAVERSAL`](09-traversal-state-surface-and-vigor-contract.md).
