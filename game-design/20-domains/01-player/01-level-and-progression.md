# SYS-PLAYER-PROGRESSION — Level và tiến trình nhân vật

> **DRI:** Progression Designer
> **Approver:** Game Director + Lead Game Designer
> **Reviewers:** Skills, Traversal, Combat, World, UI, Platform, QA
> **Status:** `DISCOVERY`

## 1. Contract

`Level` bắt đầu ở 1, tiếp tục tới 100+ và là ordinal progression toàn cục duy nhất của player. Rank, Primary Attributes, Potential và Prestige cũ không còn tồn tại trong luật, UI, save schema, content gate hoặc công thức.

Level biểu đạt quãng đường phát triển và cấp eligibility/unlock đã authored; nó không được tự tạo mọi chỉ số bằng một multiplier vô hạn. Exact EXP curve, post-100 cadence và damage curve vẫn cần simulation.

## 2. Baseline và unlock bắt buộc

| Mốc | Outcome bắt buộc |
|---:|---|
| Level 1 | một active skill đã biết; Dodge và Free Climb sẵn sàng |
| sau combat lesson đầu | Hạ Kình được grant như universal passive technique |
| mọi `L ≥ 5` và `L mod 5 = 0` | đúng một `SkillUnlockEvent` idempotent của tuyến hiện hành |
| Level 10 | eligibility + training ngắn để grant Khinh Công; catch-up path nếu player đã vượt mốc |
| Level 100+ | tiếp tục cùng trục Level; không chuyển sang Prestige/Rank khác |

Formula/samples canonical là `SKL-START/CADENCE/GRANTS-001` tại [Parameter Registry](../../60-quality/02-parameter-registry.md). Grant có thể là skill mới, node hoặc slot theo tuyến authored. Nó **không** có nghĩa số active hotbar slot đồng thời tăng ở mọi mốc; Skills sở hữu loadout cap và preview.

## 3. EXP và level transaction

- EXP source giữ Minecraft sandbox có giá trị: combat, activity/quest, exploration, building/survival milestone và các hành động vanilla hợp lệ; exact mix/curve chưa khóa.
- Một EXP operation có ID, source, ruleset, amount và level transition result; retry/reload không nhân đôi reward/unlock.
- Level-up publish event sau commit; Skill/Traversal/UI chỉ consume event, không tự ghi Level.
- Over-level, migration hoặc content missing chạy catch-up theo stable milestone ID; không bắt replay quest đã miss và không grant hai lần.
- Creative/admin/debug có thể grant Level/capability với provenance; chuyển mode/reload không xóa progression.
- Save dùng integer có headroom trên 100; không serialize Level bằng byte hoặc hard-code 100 như trần kỹ thuật.

## 4. Phân biệt Level với mastery

Vigor capacity/recovery milestone, weapon familiarity, skill proficiency và relationship progression là state theo capability, không phải Rank/Primary Attribute trá hình. Chúng chỉ hợp lệ khi:

- có hành vi hoặc reward cụ thể, preview được và có cap;
- không tổng hợp lại thành một ordinal “power rank” thứ hai;
- không khóa core world access ngoài các mốc Product đã nêu;
- có anti-AFK/provenance, save/migration và catch-up rõ.

## 5. NPC và world relation

NPC có Level cố định để world đọc được sức mạnh; player là actor tăng trưởng. World/AI sở hữu silhouette, power band, density quota và reaction. Player Progression chỉ publish Level snapshot/query; AI không đọc input kín hoặc scan toàn player state để gian lận.

## 6. Proof bắt buộc

- Level 1/new save có đúng baseline capability/skill; death/reload không mất hoặc nhân đôi.
- Level 4→5, 9→10, multi-level reward và Level 100→101 phát đúng event, kể cả retry/save migration.
- Skill preview và grant ledger khớp; content thiếu dùng fallback chứ không corrupt save.
- Không còn serialized/display/condition key cho Rank, Primary Attributes, Potential hoặc Prestige.
- EXP farm/AFK/teleport không vượt source policy; exact curve qua long-run simulation trước approve.

## 7. Open decisions

- EXP curve và source weights nào đạt nhịp dài hạn mà không biến Minecraft activity thành chore?
- Post-100 unlock cadence có tiếp tục mỗi 5 level hay đổi reward content trong khi vẫn giữ một trục Level?
- Loadout cap và loại reward tại từng mốc thuộc `DB-SKILL-PROGRESSION`, không được Progression tự phát minh.
