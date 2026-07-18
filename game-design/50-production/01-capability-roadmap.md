# PROD-ROADMAP — Roadmap capability luôn chơi được

> **DRI:** Producer + Game Director + Technical Director
> **Status:** `PROPOSED`

Roadmap giảm rủi ro theo thứ tự chi phí đảo ngược. Mỗi capability kết thúc bằng một playable internal snapshot, test manifest và safe continuation point. Public 1.0 chỉ đến ở cuối full promise; snapshot không phải public release.

| Slice | Playable proof | Foundation/design phải khóa | Exit evidence |
|---|---|---|---|
| `C0-DESIGN-OS` | người dùng đọc/feedback; Agent route đúng | architecture, roles, lifecycle, scope, traceability | validator + feedback loop + no parallel truth |
| `C1-FOUNDATION-KERNEL` | mod shell mở integrated/dedicated test world, save/reload/quit sạch | baseline adapter, logical-server authority, stable IDs, content/config validation, schema/migration/backup, feature flags, diagnostics, test source sets, Git workflow | lifecycle smoke, migration fixture, diagnostics export, CI/test manifest |
| `C2-PLAYER-EMBODIMENT` | đi/chạy/nhìn/mine/place/interact ở góc một và camera góc ba base | input context, camera rig/occlusion/aim ray, pose/animation seam, UI/localization/accessibility, creative/survival policy | camera room screenshots, mode/lifecycle matrix, user comfort card |
| `C3-COMBAT-RHYTHM` | một arena: light attack + Dodge + một enemy dạy nhịp | action timeline, hit cadence, server validation, Focus candidate, camera/facing, animation markers | spam/duplicate/latency tests + feel/readability playtest |
| `C4-PERSISTENT-ACTIVITY` | một authored activity/Gate hoàn thành hoặc rời–reload–quay lại | Gate/objective/instance, death/respawn/reconnect, reward idempotency, generation validation | transition/chaos/save/dedicated proof |
| `C5-ARISE-IDENTITY` | hạ → Trỗi Dậy → một Shadow có tên → summon/shatter/revive/save | capture/echo, identity, resource, ally AI, ownership | duplicate/death/reload/content-missing tests + attachment read |
| `C6-BUILD-GROWTH` | level/stat/specialization/skill/loadout tạo hai build thật | progression, Potential/respec, parameter registry, UI/migration | two-build simulation/playtest + old-save fixture |
| `C7-SQUAD-MASTERY` | squad nhỏ có role/order/formation thắng encounter bằng command | command precedence, squad AI, LOD, target/camera framing, encounter budget | usability + 40/80 stress direction + three-profile balance |
| `C8-RETURNING-WORLD` | activity thay đổi home/hub/quest/economy/NPC response | world mutation, quest recovery, source/sink, family/narrative, localization | continuity/reload/source-sink/world consequence proof |
| `C9-CORE-GAME-ALPHA` | survival→becoming→Gate→Shadow→return loop dài hạn nối được | system breadth locked, vertical content kits, campaign spine, endgame hypothesis | new-save journey, soak, content cadence, save support policy |
| `C10-FULL-PRODUCT` | full public promise hoàn chỉnh | campaign/content/endgame breadth, install/support/compat/accessibility | release gates, migration/recovery, performance and complete journey |

## Sequencing decisions

- Prologue/family được viết song song từ design phase nhưng content integration vào `C8`; `C2–C3` dùng test context trung tính để không khóa narrative vào foundation.
- First return/home beat xuất hiện ở `C8` và phải tồn tại trong `C9` core loop; không đợi polish cuối.
- Camera base đứng trước combat rhythm; lock-on/boss framing mở sau base aim/occlusion proof.
- Multiplayer gameplay, mount/vehicle breadth, aquatic expansion và extra Strata không chen vào `C1–C10`; chỉ foundation seams liên quan được test.

## Mainline gate chung

Mỗi slice: previous snapshot vẫn load/migrate; incomplete content không lộ; automated pack xanh; user chỉ test human questions; exact known issues ghi; capability tiếp theo không bắt đầu trên invariant đỏ.
