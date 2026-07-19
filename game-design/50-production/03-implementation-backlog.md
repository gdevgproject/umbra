# PROD-IMPLEMENTATION-BACKLOG — Hàng đợi triển khai

> **DRI:** Producer + Technical Director
> **Status:** `BLOCKED_BY_DESIGN`

Chưa gameplay ticket nào `READY`. Các `EPIC-*` dưới đây là **candidate owner/dependency boundaries**, không phải authorization code và không phải ticket. Một epic chỉ được mở sau design gate; sau đó tiếp tục cắt thành `TKT-*` theo [Ticket Standard](04-ticket-standard.md). Không được copy một row thành ticket.

Dependency epic biểu diễn integration order trong slice; design dependency dùng đầy đủ stable ID để validator bắt drift. Epic có thể triển khai song song nếu design gate, previous snapshot và dependency epic đều xanh.

Trong các row dưới đây, “`DB-*` implementation-ready” là viết gọn cho: package đã có exit artifact approved và mọi Feature/Contract được epic tiêu thụ đã đạt `IMPLEMENTATION_READY`. Bản thân một backlog row không thừa kế lifecycle của Feature Cell.

## C1 — Foundation Kernel

| Epic ID | Outcome/proof boundary | Design gate mở | Epic dependency |
|---|---|---|---|
| `EPIC-C1-01` | reproducible Fabric 26.2 project shell + exact build/artifact/baseline manifest | `DB-019` approved | none |
| `EPIC-C1-02` | bounded capability/layer/public-surface skeleton + architecture report/violation fixtures | `DB-021` approved | `EPIC-C1-01` |
| `EPIC-C1-03` | loader-neutral common boundary + Fabric adapter/import guard/conformance | `DB-043` approved | `EPIC-C1-01`, `EPIC-C1-02` |
| `EPIC-C1-04` | stable IDs, content/reference/config validation và capability manifest/flags | `DB-021`, `DB-035` approved | `EPIC-C1-02`, `EPIC-C1-03` |
| `EPIC-C1-05` | canonical save envelope, schema/migration journal và state ownership fixtures | `DB-021`, `DB-024` approved | `EPIC-C1-02`, `EPIC-C1-03`, `EPIC-C1-04` |
| `EPIC-C1-06` | portable backup/manifest/restore-as-copy/transfer fixtures | `DB-038`, `DB-043` approved | `EPIC-C1-05` |
| `EPIC-C1-07` | command/payload/ownership/security guards + typed failure/idempotency | `DB-021`, `DB-023` approved | `EPIC-C1-02`, `EPIC-C1-03` |
| `EPIC-C1-08` | causal trace/state inspector/diagnostics + integrated/dedicated/lifecycle/performance-risk harness | `DB-022`, `DB-024`, `DB-039` approved | `EPIC-C1-05`, `EPIC-C1-07` |
| `EPIC-C1-09` | Việt/Anh resource skeleton + locale/key/placeholder reload validation | `DB-030` approved | `EPIC-C1-01`, `EPIC-C1-04` |

## C2 — Player Embodiment

| Epic ID | Outcome/proof boundary | Design gate mở | Epic dependency |
|---|---|---|---|
| `EPIC-C2-01` | Action Catalog/key baseline/context/remap/conflict diagnostics | `DB-029`, `DB-002` approved | `EPIC-C1-08`, `EPIC-C1-09` |
| `EPIC-C2-02` | camera harness room + third-person rig/occlusion/mining–placing parity | `DB-004` implementation-ready | `EPIC-C2-01` |
| `EPIC-C2-03` | camera-relative movement/facing/recenter/transition trace | `DB-048` implementation-ready | `EPIC-C2-02` |
| `EPIC-C2-04` | aim/reticle/soft-target/lock lifecycle + first-person parity | `DB-037` implementation-ready | `EPIC-C2-02`, `EPIC-C2-03` |
| `EPIC-C2-05` | animation semantic/marker/root-motion/fallback adapter proof | `DB-025`, `DB-033` approved | `EPIC-C2-03` |
| `EPIC-C2-06` | UI token/component foundation + fixed-width meter primitives/localized fallback | `DB-031` approved | `EPIC-C1-09`, `EPIC-C2-02` |

## C2B — Vertical Freedom

| Epic ID | Outcome/proof boundary | Design gate mở | Epic dependency |
|---|---|---|---|
| `EPIC-C2B-01` | traversal locomotion state, surface/ledge profiles, Vigor transaction, authority/save/debug | `DB-049` implementation-ready | `EPIC-C2-01`, `EPIC-C2-03`, `EPIC-C2-05`, `EPIC-C2-06` |
| `EPIC-C2B-02` | Free Climb attach/move/leap/corner/mantle/collision + two-camera presentation | `DB-050` implementation-ready | `EPIC-C2B-01` |
| `EPIC-C2B-03` | voxel-room integration, lifecycle/security/performance pack và return-to-vanilla proof | `DB-049`, `DB-050` proof plan approved | `EPIC-C2B-02` |

## C3 — Combat Rhythm

| Epic ID | Outcome/proof boundary | Design gate mở | Epic dependency |
|---|---|---|---|
| `EPIC-C3-01` | one authoritative health/environment mapping + Mana/Focus transaction/HUD projection | `DB-042`, `DB-046` implementation-ready | `EPIC-C2-06` |
| `EPIC-C3-02` | Action Timeline/Hit cadence + one Light Attack chống click/packet spam | `DB-003`, `DB-053` implementation-ready | `EPIC-C2-03`, `EPIC-C2-05`, `EPIC-C3-01` |
| `EPIC-C3-03` | Dodge direction/collision/defensive category/resource/prediction | `DB-005` implementation-ready | `EPIC-C2-04`, `EPIC-C3-02` |
| `EPIC-C3-04` | one-charge Combat Flask action/transaction/HUD/interrupt | `DB-047` implementation-ready | `EPIC-C3-01`, `EPIC-C3-02`, `EPIC-C3-03` |
| `EPIC-C3-05` | early-danger zombie teaching exemplar + player–world escape/readability | `DB-006`, `DB-034` implementation-ready | `EPIC-C2B-03`, `EPIC-C3-02`, `EPIC-C3-03`, `EPIC-C3-04` |
| `EPIC-C3-06` | integrated shelter/arena Combat Craft snapshot + spam/latency/feel/performance evidence | `DB-054` implementation-ready | `EPIC-C3-01`, `EPIC-C3-02`, `EPIC-C3-03`, `EPIC-C3-04`, `EPIC-C3-05` |

## C3B — Aerial Mastery

| Epic ID | Outcome/proof boundary | Design gate mở | Epic dependency |
|---|---|---|---|
| `EPIC-C3B-01` | Hạ Kình time-to-impact/fall conversion/weapon adapter/AoE idempotency | `DB-051` implementation-ready | `EPIC-C2B-03`, `EPIC-C3-02` |
| `EPIC-C3B-02` | Khinh Công launch–apex–descent/steering/Vigor/collision | `DB-052` implementation-ready | `EPIC-C3B-01` |
| `EPIC-C3B-03` | world/enemy/follower seam + sequence-break/security/two-view integration | `DB-051`, `DB-052` proof plan approved | `EPIC-C3-05`, `EPIC-C3B-01`, `EPIC-C3B-02` |

## C4 và C4B — Persistent Activity → Becoming Spine

| Epic ID | Outcome/proof boundary | Design gate mở | Epic dependency |
|---|---|---|---|
| `EPIC-C4-01` | Quest Kernel state/objective/condition/journal/debug/save contract | `DB-036` implementation-ready | `EPIC-C1-05`, `EPIC-C1-08`, `EPIC-C1-09` |
| `EPIC-C4-02` | Gate/objective/instance/death/reconnect/generation lifecycle | `DB-007` implementation-ready | `EPIC-C4-01` |
| `EPIC-C4-03` | authored discovery/activity exemplar + typed test reward + leave/reload/recovery proof | `DB-007`, `DB-026` implementation-ready | `EPIC-C3-06`, `EPIC-C4-02` |
| `EPIC-C4B-01` | reward→XP/level/milestone/rank-or-unlock cue→return record/home anchor→save/migrate | `DB-056` implementation-ready | `EPIC-C4-03` |

## C5 — Arise Identity

| Epic ID | Outcome/proof boundary | Design gate mở | Epic dependency |
|---|---|---|---|
| `EPIC-C5-01` | corpse/Soul Echo/Arise eligibility–attempt–cost–claim transaction | `DB-008` implementation-ready | `EPIC-C4B-01` |
| `EPIC-C5-02` | one persistent Shadow Identity/content exemplar/missing-content recovery | `DB-009` implementation-ready | `EPIC-C5-01` |
| `EPIC-C5-03` | summon/dismiss/shatter/revive/save + one ally AI + attachment snapshot | `DB-010` implementation-ready | `EPIC-C5-02` |

## C6 — Build Growth

| Epic ID | Outcome/proof boundary | Design gate mở | Epic dependency |
|---|---|---|---|
| `EPIC-C6-01` | attributes/rank/specialization/Potential/respec mở rộng từ C4B spine | `DB-011` implementation-ready | `EPIC-C4B-01`, `EPIC-C5-03` |
| `EPIC-C6-02` | Skill Definition/tree/rune/loadout 4+1 + bounded effect/synergy contract | `DB-012` implementation-ready | `EPIC-C6-01` |
| `EPIC-C6-03` | bounded HP/Mana/Focus và Flask capacity/potency growth + migration/exploit proof | `DB-011`, `DB-047` implementation-ready | `EPIC-C3-01`, `EPIC-C3-04`, `EPIC-C6-01` |
| `EPIC-C6-04` | two-build simulation/playtest/integration snapshot | `DB-011`, `DB-012` evidence plan approved | `EPIC-C6-02`, `EPIC-C6-03` |

## C7 — Retinue Mastery

| Epic ID | Outcome/proof boundary | Design gate mở | Epic dependency |
|---|---|---|---|
| `EPIC-C7-01` | slot 2→8/membership/pending claim/full-roster/parting/reserve/home persistence | `DB-044` implementation-ready | `EPIC-C5-03`, `EPIC-C6-04` |
| `EPIC-C7-02` | command selection/order/formation/acknowledgement UX cho tối đa bốn active | `DB-013` implementation-ready | `EPIC-C2-04`, `EPIC-C7-01` |
| `EPIC-C7-03` | Retinue squad AI/LOD/vertical follower + expression arbitration/fallback | `DB-045` implementation-ready | `EPIC-C3B-03`, `EPIC-C7-02` |
| `EPIC-C7-04` | 0/1/2/4-active balance, roster-eight usability/home rotation và `PERF-S02A/B` snapshot | `DB-018`, `DB-044`, `DB-045` approved | `EPIC-C7-01`, `EPIC-C7-02`, `EPIC-C7-03` |

## C8 — Returning World

| Epic ID | Outcome/proof boundary | Design gate mở | Epic dependency |
|---|---|---|---|
| `EPIC-C8-01` | production currency/item reward/source–sink + Flask refill/craft/shop loop | `DB-016` implementation-ready | `EPIC-C4-03`, `EPIC-C6-03` |
| `EPIC-C8-02` | living-society identity/event ledger + observable hub/service reaction | `DB-041` implementation-ready for identity/hub cells | `EPIC-C4-01`, `EPIC-C7-04` |
| `EPIC-C8-03` | rich quest branch/recovery/reward/world-effect vertical | `DB-015` implementation-ready | `EPIC-C8-01`, `EPIC-C8-02` |
| `EPIC-C8-04` | home/family/Shadow presence/return consequence integration + discovery portfolio proof | `DB-017`, `DB-026` implementation-ready | `EPIC-C8-03` |

Settlement/faction/deep-individual society chỉ có epic mới sau Feature Cell riêng; `EPIC-C8-02` không cấp quyền kéo toàn bộ ladder `DB-041` vào một ticket.

## C9 — Gate Boss Teaching Vertical

| Epic ID | Outcome/proof boundary | Design gate mở | Epic dependency |
|---|---|---|---|
| `EPIC-C9-01` | boss move/action kit + AI selection/pattern memory + phase/arena/objective | `DB-055`, `DB-014` implementation-ready | `EPIC-C4-03`, `EPIC-C7-04` |
| `EPIC-C9-02` | camera/target framing + animation–hit + audio/VFX/readability assets | `DB-055`, `DB-014` implementation-ready | `EPIC-C9-01` |
| `EPIC-C9-03` | difficulty/assist/retry/save/reward/capture contracts | `DB-055`, `DB-014` implementation-ready | `EPIC-C8-01`, `EPIC-C9-01` |
| `EPIC-C9-04` | Iron Knight learning→competent→expert integrated proof | `DB-014` evidence plan approved | `EPIC-C9-02`, `EPIC-C9-03` |

## Decomposition guard

- Một ticket có đúng một primary authoritative writer/lifecycle và một rollback/evidence story. Hai domain cùng tham gia review không tự buộc tách; hai state machine có thể release/rollback độc lập thì phải tách.
- Integration ticket chỉ nối các epic đã có contract/test; nó không được phát minh player rule còn thiếu.
- `PR-*`, save/migration, loader surface hoặc human feel question khác lane có thể là lý do tách ticket dù cùng một epic.
- Epic chưa có design gate đầy đủ giữ nguyên candidate; không tạo class/schema/placeholder để “chuẩn bị”.

NeoForge adapter/artifact **không** nằm trong current implementation backlog. Nó chỉ mở sau `DB-043` và rollout gate `L1`, trên matching Minecraft baseline, bằng portability spike riêng; không sửa domain rule để vượt port.
