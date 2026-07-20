# SYS-PROGRESSION-DISCOVERY — Tuyến review Level, Skill và Vigor

> **DRI:** Progression Designer + Skill Designer + Balance Designer
> **Approver:** Game Director
> **Reviewers:** Combat, Traversal, World, UX, Platform, QA
> **Status:** `DISCOVERY`

## 1. Những gì không còn là câu hỏi

Project Owner đã khóa: một trục Level 1→100+, bỏ Rank/Primary Attributes/Potential/Prestige; HP + Vigor là hai core meters UMBRA; Mana/Focus/Fatigue/Posture bị xóa; skill cadence mỗi 5 level; Dodge/Free Climb level 1; Hạ Kình sau combat lesson; Khinh Công level 10. Không hỏi lại các premise này và không dùng prototype để phục hồi hệ cũ.

## 2. Tuyến đọc

1. [Level và progression](01-level-and-progression.md).
2. [Capability mastery và build](02-capability-mastery.md).
3. [Skill Domain](../03-skills/README.md).
4. [Vitals/Vigor HUD](../../30-shared-contracts/08-vitals-resource-and-hud-contract.md) và [Traversal Contract](../../30-shared-contracts/09-traversal-state-surface-and-vigor-contract.md).
5. [Parameter Registry](../../60-quality/02-parameter-registry.md) cho phép tính đã khóa và các biến còn `OPEN`.

## 3. Discovery còn hợp lệ

- EXP curve/source mix và post-100 reward cadence.
- Loadout cap, authored skill lines và mốc nào trao skill/node/slot trong invariant mỗi 5 level.
- Damage/defense/counterplay/gear curve không dựa Primary Attributes hoặc Posture meter.
- Exact Vigor milestone distribution từ 100→240 và 25→40 trong target tối thiểu 480 active hours.
- Hạ Kình damage/stagger/target cap/recovery theo weapon family trong radius/fall-safety đã khóa.
- AI trait incidence, critical-HP threshold và lower-band population curve trong quota đã khóa.

## 4. Câu hỏi bằng chứng, không đẩy lại Product

1. Hai skill line ở cùng Level tạo cách giải tình huống khác nhau hay chỉ khác damage?
2. Preview từ level 1 có đủ điều kiện, cost/cooldown, target, animation, damage và interaction để lập build không?
3. Mỗi milestone Vigor có nhìn thấy tiến bộ mà không biến leo/chạy thành AFK grind không?
4. `VIG-DODGE-001` cùng recovery rule tạo nhịp agency hay cho phép spam/đợi quá nhiều trong encounter thật?
5. `GRD-WINDOW-001` giữ collision/intent/comfort ở logical-server baseline và hai góc nhìn không?
6. NPC high-level có hiếm, dễ đọc và đáng nhớ mà không quấy rối player yếu hoặc làm hub tốn pathfinding không?

## 5. Output

Discovery đóng theo từng Feature/contract độc lập: Skill Acquisition/Preview, Vigor Milestones, Damage/Counterplay, Hạ Kình combat envelope và Villager Trait/Density. Không gom chúng thành một “balance everything” package và không tạo ticket code trước khi cell tương ứng `IMPLEMENTATION_READY`.
