# CTR-RESOURCE-MODIFIER — Resource, cost và modifier

> **DRI:** Systems Designer
> **Status:** `DISCOVERY`

Resource definition khai owner, scope, cap, current value, cost moment, refund, recovery, persistence và UI visibility. Cost là reservation/commit/refund có transaction ID; thất bại/retry không trừ hai lần.

Contract này sở hữu giao dịch chung. Semantic riêng của Health/Mana/Focus, environmental damage, rule khi Max đổi và HUD fixed-width thuộc [`CTR-VITALS-HUD`](08-vitals-resource-and-hud-contract.md); không lặp công thức hoặc presentation tại đây.

Modifier có source ID, target stat/tag, operation, priority/layer, duration/expiry, stacking key, cap và dispel/persistence. Thứ tự chuẩn phải được Parameter Registry khóa trước implementation. Không cộng stat bằng callback ẩn rải trong feature.

HP, Mana, Focus, Vigor, Fatigue, posture, currency và attempt đều dùng vocabulary này nhưng có policy riêng ở domain owner. Vigor/surface/locomotion transition thuộc [`CTR-TRAVERSAL`](09-traversal-state-surface-and-vigor-contract.md).
