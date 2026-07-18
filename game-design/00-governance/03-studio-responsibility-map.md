# GOV-ROLES — Bản đồ trách nhiệm của một game studio

> **Owner:** Producer / Design Operations
> **Status:** `APPROVED_FOR_DOCUMENTATION`

Không có một con số “đúng” về số vị trí. Một studio nhỏ có thể một người đội 15 mũ; studio lớn tách một mũ thành cả nhóm. Điều bắt buộc là **mọi trách nhiệm có người chịu trách nhiệm cuối (DRI)**, dù không có nhân sự chuyên biệt.

## 1. Lãnh đạo và sản xuất

| Vai trò | Quyết định/đầu việc chính | Artifact sở hữu |
|---|---|---|
| Game Director | fantasy, pillars, trải nghiệm tổng thể, quyết định cuối về game | Product Charter, pillar, greenlight lớn |
| Creative Director | tính nhất quán art–narrative–audio–gameplay | Creative Bible |
| Lead Game Designer | coherence toàn bộ rule, domain boundary, design review | System Map, design standards |
| Producer | phạm vi, thứ tự, dependency, rủi ro, capacity | Initiative, milestone, release slice |
| Design Operations | taxonomy, status, link, template, meeting/decision hygiene | Governance, catalog, audit |

## 2. Thiết kế

| Vai trò | Đầu việc |
|---|---|
| Systems Designer | progression, resource, skill, item, rule và state machine |
| Combat Designer | action timing, hit rules, weapon rhythm, feel, camera phối hợp |
| Technical Designer | biến design thành data/authoring contract, prototype, validator requirement |
| UX/UI Designer | flow, information architecture, HUD, remap, onboarding, accessibility |
| Economy/Balance Designer | faucet/sink, power budget, target range, simulation và tuning plan |
| AI Designer | perception, decision, telegraph, squad behavior và counterplay |
| Encounter/Boss Designer | arena, composition, phase, teaching goal, fail/retry loop |
| Level/Dungeon Designer | topology, pacing, objective, puzzle, traversal và procedural grammar |
| World Designer | vanilla integration, settlement, event, biome/dimension, systemic world |
| Narrative Designer | lore, character arc, quest meaning, dialogue, environmental delivery |
| Quest Designer | objective grammar, branching, state/failure/recovery, reward và pacing |
| Content Designer | author faction/enemy/item/skill/room instance theo contract |
| Accessibility Designer | motor/visual/audio/cognitive options và test profile |
| Design Researcher | benchmark, player research, source synthesis, usability evidence |

## 3. Kỹ thuật gắn với thiết kế

| Vai trò | Đầu việc |
|---|---|
| Technical Director | platform constraints, architectural risk, ownership và ADR kỹ thuật |
| Gameplay Engineer | action/system implementation, deterministic rule, debugging hooks |
| AI Engineer | runtime AI, navigation, LOD, authoring/debug tooling |
| Client/UI Engineer | HUD/screen/input/camera/prediction/accessibility implementation |
| Animation Engineer | animation graph, event timing, root motion policy, blend/cancel |
| Rendering/VFX Engineer | render pipeline, shader compatibility, performance budget |
| Data/Tools Engineer | schema, editor, validator, migration, content pipeline |
| Platform/Compatibility Engineer | Fabric/Minecraft boundary, mod interop, version support |
| Performance Engineer | budgets, profiler, benchmark, soak/regression |
| Build/Release Engineer | reproducible build, CI, packaging, release matrix |
| Network/Security Engineer | authority, packet validation, latency/abuse model khi có multiplayer |

## 4. Art và audio

| Vai trò | Đầu việc |
|---|---|
| Art Director | visual language, quality bar, silhouette/color ownership |
| Concept Artist | exploration, shape language, reference transformation |
| Character/Creature Artist | model/texture/rig readiness |
| Environment Artist | block palette, structure, prop/readability |
| Technical Artist | pipeline, rig/material/VFX budget, exporter |
| Animator | first/third-person motion, locomotion, combat/readability |
| VFX Artist | telegraph, impact, state language, reduced-motion variant |
| UI Artist | component skin, iconography, typography |
| Audio Director/Sound Designer | cue language, combat impact, notification, spatial mix |
| Composer | thematic score và adaptive music nếu cần |

## 5. Quality và phát hành

| Vai trò | Đầu việc |
|---|---|
| QA Lead | risk strategy, acceptance, triage, release confidence |
| Embedded QA / Feature QA | scenario matrix, exploratory test, reproduction |
| Automation Engineer | unit/integration/GameTest/bot harness |
| Compatibility QA | Minecraft/Fabric/mod/shader/save matrix |
| Localization Lead | terminology, string pipeline, locale fallback, linguistic QA |
| User Researcher | playtest design, interview, behavior analysis |
| Community/Support | issue taxonomy, feedback loop, release communication |

## 6. Mô hình review cho UMBRA

Mỗi artifact có:

- **DRI:** đúng một người/mũ chịu trách nhiệm hoàn tất.
- **Approver:** đúng một người/mũ có quyền greenlight ở gate hiện tại.
- **Reviewers:** chỉ những discipline chịu tác động.
- **Consulted:** cung cấp dữ kiện, không có quyền ngầm chặn.
- **Informed:** cần biết kết quả.

Ví dụ `FEAT-COMBAT-DODGE`: DRI Combat Designer; approver Lead Game Designer; reviewers UX/Input, Animation, Gameplay Engineering, QA, Accessibility; consulted Balance, Camera, Compatibility; Game Director được informed nếu fantasy không đổi.

Solo developer vẫn ghi các mũ này để biết mình đang ra quyết định ở vai trò nào và tránh một suy nghĩ kỹ thuật vô tình thay thế quyết định UX.
## 7. Mô hình vận hành một người + Agent

Các role trong tài liệu là **góc trách nhiệm**, không giả định có nhân sự thật. Người dùng giữ Game Director/Product Owner. Agent lần lượt đội mũ DRI/reviewer chuyên môn, phải thực hiện review pass tách biệt và ghi risk/evidence; không tự tạo cảm giác “đã được nhiều người duyệt”. Repository, ticket, test report và Git commit là bộ nhớ qua các phiên chat. Quy trình chi tiết: [Engineering/Git Workflow](06-engineering-and-git-workflow.md).
