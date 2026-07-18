# PROD-ROADMAP — Roadmap capability luôn chơi được

> **DRI:** Producer + Game Director + Technical Director
> **Status:** `PROPOSED`

Roadmap giảm rủi ro theo thứ tự chi phí đảo ngược. Mỗi capability kết thúc bằng một playable internal snapshot, test manifest và safe continuation point. Public 1.0 chỉ đến ở cuối full promise; snapshot không phải public release.

| Slice | Playable proof | Foundation/design phải khóa | Exit evidence |
|---|---|---|---|
| `C0-DESIGN-OS` | người dùng đọc/feedback; Agent route đúng | architecture, roles, lifecycle, scope, traceability | validator + feedback loop + no parallel truth |
| `C1-FOUNDATION-KERNEL` | Fabric mod shell 26.2 mở integrated/dedicated test world, save/reload/quit/backup–restore sạch | pinned baseline, loader-neutral domain/save contract, Fabric adapter/import guard, logical-server authority, stable IDs, content/config validation, schema/migration/portable backup, feature flags, Việt/Anh resource skeleton, diagnostics, test source sets, Git workflow, Performance Constitution/harness | lifecycle/restore smoke, migration fixture, Fabric adapter conformance, common-core dependency proof, diagnostics export, CI/test/compat/performance manifest |
| `C2-PLAYER-EMBODIMENT` | đi/chạy/nhìn/mine/place/interact ở góc một và camera UMBRA; sau gate profile mới default góc ba | versioned action catalog/key baseline, ergonomic input context, camera rig/occlusion/aim ray, camera-relative movement/facing transitions, pose/animation seam, fixed-width HUD primitives, localization/accessibility, Creative provenance và game-mode/death policy | key/conflict matrix, movement-basis trace, camera room/HUD screenshots, locale/mode/lifecycle tests, frame profile, user comfort card |
| `C3-COMBAT-RHYTHM` | một arena/shelter: light attack + Dodge + một-charge Combat Flask + zombie đầu tạo sợ hãi nhưng có đường sống | action timeline, hit cadence, one authoritative health/environment mapping, Mana/Focus transaction, quick-recovery lifecycle, server validation, early-danger hypothesis, camera/facing, animation markers | spam/duplicate/latency, damage-source/lifecycle/flask idempotency + player–zombie pressure + feel/readability playtest |
| `C4-PERSISTENT-ACTIVITY` | một authored activity/Gate quest hoàn thành hoặc rời–reload/death–quay lại | Quest Kernel, Gate/objective/instance, journal minimal, typed test reward/effect, reconnect, idempotency, generation validation | transition/chaos/save/dedicated/quest recovery proof |
| `C5-ARISE-IDENTITY` | hạ → Trỗi Dậy → một Shadow có tên → summon/shatter/revive/save | capture/echo, identity, resource, ally AI, ownership | duplicate/death/reload/content-missing tests + attachment read |
| `C6-BUILD-GROWTH` | level/stat/specialization/skill/loadout tạo hai build thật | Balance Constitution, progression, Potential/respec, damage/counterplay rules, bounded HP/Mana/Focus và Flask capacity/potency growth, parameter registry, UI/migration | two-build simulation/playtest + max-resource/flask exploit matrix + old-save fixture |
| `C7-RETINUE-MASTERY` | Retinue mở dần; tối đa bốn active Shadow dùng role/order/formation thắng encounter bằng command, member thứ năm là dự bị | slot/membership/full-roster claim, command precedence, expression semantics, squad AI, target/camera framing, encounter/performance budget | slot 1→5 + reserve/full-roster usability; `PERF-S02A/B`; 0/1/2/4-active balance; attachment/ritual proof |
| `C8-RETURNING-WORLD` | activity thay đổi home/hub/quest/economy/NPC response | rich quest verticals, world mutation, production rewards/source-sink, Combat Flask refill/craft/shop production economy, family/narrative, living-society identity/ledger/tier, localization/assets | continuity/reload/source-sink/refill economy/world consequence/society performance/emotional proof |
| `C9-CORE-GAME-ALPHA` | survival→becoming→Gate→Shadow→return loop dài hạn nối được | system breadth locked, vertical content kits, campaign spine, endgame hypothesis | new-save journey, soak, content cadence, save support policy |
| `C10-FULL-PRODUCT` | full public promise milestone hoàn chỉnh | campaign/content/endgame breadth, install/support/compat/accessibility | release gates, migration/recovery, performance and complete journey; không đóng future first-party growth |

## Sequencing decisions

- Prologue/family được viết song song từ design phase nhưng content integration vào `C8`; `C2–C3` dùng test context trung tính để không khóa narrative vào foundation.
- First return/home beat xuất hiện ở `C8` và phải tồn tại trong `C9` core loop; không đợi polish cuối.
- Camera base đứng trước combat rhythm; lock-on/boss framing mở sau base aim/occlusion proof.
- Camera movement/facing basis được chứng minh sau base rig nhưng trước aim/layout/Dodge; ranged không mặc định ép first-person.
- Vitals/HUD topology đi trước balance combat; Combat Flask chỉ vào C3 với một charge thử nghiệm, còn capacity/potency/refill progression mở theo C6/C8.
- Third-person chỉ trở thành default sau exit evidence `C2`; trước đó giữ vanilla default.
- Quest Kernel vào `C4`; production quest chỉ dùng item/currency/world effect đã có owner contract.
- Multiplayer gameplay không chen vào current slices. Mount/vehicle/aquatic/extra Strata là first-party capability future được chèn theo dependency và gate, không bị đẩy cho external add-on.
- Future multiplayer ladder đã khóa seam: co-op party 2–4 trước; PvP 1v1/3v3 rồi ranking/event sau. Không mốc nào tự động được đưa vào current roadmap.
- Fabric là loader của current slices. C1 chỉ khóa portability boundary và Fabric conformance (`L0`); NeoForge spike/adapter/release là future capability train theo `DB-043`, không chen code giả vào foundation.

## Mainline gate chung

Mỗi slice: previous snapshot vẫn load/migrate; incomplete content không lộ; automated pack xanh; performance benchmark/control không regression ngoài waiver; user chỉ test human questions; exact known issues ghi; capability tiếp theo không bắt đầu trên invariant đỏ. Mỗi feature tối ưu theo profile/cardinality thật của slice, không trì hoãn mọi performance proof tới stress scene `C7`.
