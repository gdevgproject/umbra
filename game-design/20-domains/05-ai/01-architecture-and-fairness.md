# SYS-AI-CORE — Kiến trúc và fairness

> **DRI:** AI Designer
> **Status:** `DISCOVERY`

## Mô hình hybrid

- Behavior Tree giữ safety, sequence có điều kiện và lifecycle ổn định.
- Utility scoring chọn mục tiêu/tactic từ các lựa chọn hợp lệ.
- Squad brain phân vai, reservation và shared intent.
- Encounter director điều nhịp ở cấp encounter, không điều khiển từng animation.

Perception → blackboard → candidate actions → utility/BT arbitration → intent → action contract. Gameplay action vẫn qua cùng authority/timeline như player.

## Fairness contract

AI không đọc keypress, camera ray chưa biểu lộ, inventory kín hoặc vị trí xuyên vật cản nếu không có năng lực được telegraph. Reaction có latency band; accuracy và prediction có noise/constraint giải thích được. Cooldown, interruption và line-of-sight áp dụng nhất quán.

## Debug contract

Mỗi quyết định log actor, perceived facts, candidates, score/rejection reason, chosen intent và transition. Seed và encounter state phải tái hiện được đủ để QA điều tra divergence.
