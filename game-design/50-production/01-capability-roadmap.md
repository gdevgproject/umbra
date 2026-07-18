# PROD-ROADMAP — Roadmap theo capability slice

> **DRI:** Producer + Game Director
> **Status:** `PROPOSED`

Roadmap là thứ tự giảm rủi ro, không là lịch hứa. Một capability chỉ mở capability sau khi exit evidence đạt; không chạy hàng loạt domain độc lập rồi ghép cuối.

| Slice | Bản chơi chứng minh | Design phải khóa trước | Exit proof |
|---|---|---|---|
| `C0-DESIGN-OS` | người đọc/Agent định tuyến và review được toàn game | architecture, scope, owner, lifecycle, traceability | doc validation + director feedback loop |
| `C1-PLATFORM-PROOF` | mod shell vào world/save/reload an toàn | baseline, authority, data/version, observability | client + dedicated server + migration fixture + benchmark harness |
| `C2-COMBAT-BEAT` | một arena, light attack + Dodge, một enemy | action/hit, input, camera, animation, Focus, fairness | anti-spam/latency tests + human feel/readability playtest |
| `C3-GATE-RUN` | vào một authored Gate, hoàn objective, rời đúng luật | Gate lifecycle, objective, instance, death/reconnect | transition/reload/idempotency/generation proof |
| `C4-ARISE-COMPANION` | hạ → Arise → một shadow có identity → summon/revive | capture, identity, resource, persistence, ally AI | no-duplicate/save/command/readability proof |
| `C5-BUILD-GROWTH` | level/stat/specialization/skill/loadout tạo hai build khác | progression, Potential, skill tree, parameters, UI | migration + build diversity + onboarding proof |
| `C6-SQUAD-MASTERY` | squad nhỏ có role/order/formation chống encounter dạy command | command precedence, squad AI, LOD, encounter budget | usability + performance + three-profile balance |
| `C7-WORLD-CONSEQUENCE` | Gate run thay đổi hub/home/quest/economy/narrative | city, quest, faction, reward, family, localization | continuity/source-sink/world mutation proof |
| `C8-RELEASE-CORE` | core loop dài hạn coherent với curated content | campaign slice, content roster, accessibility, compatibility | release gates + soak + complete new-player journey |

## Sau core release

Strata/Tower, boss 7–12, đầy đủ Cửu Vương, aquatic content, mount nước/bay, co-op, controller và social expansion chỉ được chọn sau evidence từ core. Mỗi expansion bắt đầu lại từ discovery; không xem danh sách này là promise.
