# PROD-DESIGN-BACKLOG — Backlog nghiên cứu và quyết định

> **DRI:** Lead Designer + Producer
> **Status:** `ACTIVE`

`DB-*` là **design decision/research package**, không phải ticket code hoặc lời hứa “xong trong một chat”. Priority là tie-breaker khi nhiều item cùng Ready; cột `Dependencies` mới là DAG có quyền chặn. Mọi dependency dùng đầy đủ stable ID—không viết `DB-019/021`, range hoặc “authority/resources” mơ hồ—để validator kiểm được missing edge, cycle và priority inversion.

Một package được giữ tích hợp khi các output cùng đóng một contract/gate và bằng chứng chỉ có nghĩa khi đọc chung. Phải tách package nếu có approver/lifecycle/prototype độc lập, một nửa có thể đóng mà nửa kia chưa bắt đầu, hoặc package bắt đầu biến thành danh sách implementation task. Dù package lớn, nó **không bao giờ** được chuyển nguyên xi thành một ticket.

User đã khóa full-game/all-in-one direction; breadth content không bị ép vào fixed count. Shadow topology đã khóa `8 bonded / 4 active`; backlog chỉ research cách vận hành/chứng minh, không hỏi lại cap.

## Foundation và embodiment queue

| Priority | ID | Outcome/câu hỏi | Owner | Dependencies | Exit artifact |
|---:|---|---|---|---|---|
| 1 | `DB-019` | Exact Minecraft 26.2/Fabric/Java/build/render baseline, support-line lifecycle và GitHub port/release/EOL train nào được pin? | Release Tech | `PROD-UMBRA`, `PD-013`, `PD-029`, `PD-043` | Compatibility ADR + canonical version/support matrix + release manifest schema |
| 2 | `DB-021` | Bounded capability/layer/public surface/state-thread-transaction owner/failure taxonomy/kernel nào giữ blast radius nhỏ mà không thành framework vô hạn? | Technical Director | `DB-019` | Foundation Architecture Contract + State/Public-Surface/Dependency matrix schema + C1 fixture rows + fitness/violation/causal vertical proof |
| 3 | `DB-043` | Fabric-first/NeoForge-ready boundary, loader port catalog, import rules, save schema và adapter conformance nào khóa từ foundation? | Compatibility + Tech + QA | `DB-019`, `DB-021` | Loader Portability ADR + architecture/conformance plan |
| 4 | `DB-022` | Test OS tự động hóa claim nào; `PR-0–PR-3`, screenshot/input/human escalation ra sao? | QA + Tools | `DB-019`, `DB-021`, `DB-043` | Test Architecture + harness backlog |
| 5 | `DB-039` | Hardware/settings profile, hierarchical budget, benchmark scene, profiler và degradation contract nào áp cho mọi capability? | Performance + Tech + QA | `DB-019`, `DB-021`, `DB-022` | Performance Constitution + benchmark manifest |
| 6 | `DB-023` | Offline-first authority/ownership/security seams nào là irreversible cho M0 và future co-op 2–4/PvP instance? | Tech + Security | `DB-021` | threat/contract review |
| 7 | `DB-024` | Persist/reset/copy policy cho death, respawn, reconnect, creative, dimension và reload? | Platform + Systems + QA | `DB-021`, `DB-023`, `DB-043` | State Ownership Matrix |
| 8 | `DB-040` | Death consequence profile, Creative provenance và Survival/Adventure/Spectator/Hardcore composition chính xác ra sao? | Systems + Platform + UX + QA | `DB-024`, `DB-039` | Death/Game-mode Feature Cells + comparison plan |
| 9 | `DB-038` | World backup/manifest/restore/transfer/migration failure hoạt động thế nào? | Data + Release + QA | `DB-019`, `DB-024`, `DB-043` | Save Portability Contract + restore fixtures |
| 10 | `DB-030` | `vi_vn`/`en_us`, Minecraft locale reload, key parity/font/layout pipeline ra sao? | Localization + UX | `DB-019`, `DB-021` | Communication Contract + locale tests |
| 11 | `DB-053` | Action RPG cohort thực sự nhận ra embodiment/mastery/triumph qua hành vi, lỗi và quality threshold nào—not chỉ stated preference? | User Research + Combat + UX | `PD-040`, `PD-041`, `RES-AUDIENCE`, `DB-022` | cohort profiles + interview/reference-capture protocol + combat/boss quality rubric |
| 12 | `DB-029` | Vanilla key registry/version diff và UMBRA Action Catalog/context/conflict architecture ra sao? | UX/Input + Compatibility | `DB-019`, `DB-022` | Key Baseline + Action Catalog |
| 13 | `DB-031` | UI information architecture, visual direction, tokens/components scale ra sao? | UX + UI Art | `DB-030`, `PROD-UMBRA`, `MAP-SYSTEMS` | UI Design System + prototype plan |
| 14 | `DB-004` | Third-person base rig/occlusion/context architecture nào đạt mining/building parity và action-cohort quality bar? | Camera + Combat | `DB-019`, `DB-021`, `DB-022`, `DB-029`, `DB-053` | Camera Feature Cells + prototype report |
| 15 | `DB-048` | Camera-relative/target-relative/aim-relative movement basis, actor facing, transition và root-motion seam nào tránh đảo hướng/snap? | Camera + Controls + Animation | `DB-004`, `DB-029` | Movement/Facing prototype + trace/ADR |
| 16 | `DB-025` | Animation/render seam sống qua version/backend/loader change mà không sở hữu gameplay truth? | Animation + Rendering | `DB-019`, `DB-004`, `DB-039`, `DB-043`, `DB-048` | adapter/marker contract |
| 17 | `DB-049` | Traversal state, Vigor, surface/ledge taxonomy, capability grant, authority/save/world boundary và debug contract nào scale trong voxel world? | Traversal + Gameplay Tech + World + Platform | `DB-019`, `DB-021`, `DB-022`, `DB-024`, `DB-025`, `DB-029`, `DB-031`, `DB-039`, `DB-048` | `CTR-TRAVERSAL` ADR + surface/resource/proof plan |
| 18 | `DB-050` | Free Climb geometry/profile/revision, Jump/Sneak lineage, W/A/S/D diagonal/opposing input, targeted leap/dyno/eject, action-result matrix gồm Dodge/attack/skill, mantle/assist/Vigor/HUD, build/hit/fluid/piston/mode race và two-view prediction/feel hoạt động ra sao? | Traversal + Controls + Combat + UI + Animation + World + Platform | `DB-004`, `DB-025`, `DB-029`, `DB-048`, `DB-049` | Free Climb Feature Cell + ADR-0004 + one-edge-one-consumer/diagonal/action-conflict/entry/leap/Vigor/HUD/voxel mutation/prediction/feel validation package |
| 19 | `DB-037` | Soft target/lock/reticle/precision/first-person transition policy nào? | Camera + Combat + UX | `DB-004`, `DB-048` | Aim/Target validation package |
| 20 | `DB-002` | Default layout theo công thái học, remap và action precedence ra sao, gồm climb/Lightness/Grounding context? | UX + Combat + Traversal | `DB-029`, `DB-004`, `DB-037`, `DB-048`, `DB-049`, `DB-050` | layout experiment + ADR |
| 21 | `DB-033` | Asset registry/provenance/AI/LOD/VFX/audio pipeline scale ra sao? | Art/Audio + Tech Art | `DB-019`, `DB-031`, `DB-025`, `DB-039` | Asset Pipeline + exemplar manifest |
| 22 | `DB-035` | Content grammar→kit→instance→variant và interaction test sinh ra sao? | Content + Systems + QA | `DB-021`, `DB-022`, `DB-033` | Content Instance Contract + exemplars |
| 23 | `DB-036` | Quest Kernel/state/objective/reward-effect dependency nào phải có trước content? | Quest + Platform | `DB-021`, `DB-024`, `DB-030`, `DB-035` | Quest Kernel Contract + dependency map |

## Gameplay, discovery và vertical queue

| Priority | ID | Outcome/câu hỏi | Owner | Dependencies | Exit artifact |
|---:|---|---|---|---|---|
| 24 | `DB-026` | Portfolio nào cân bằng transformed-familiar, frontier novelty, mechanical revelation, systemic recombination và meaning discovery mà không thành checklist/reskin/catalog debt? | World + Content + Systems + User Research | `PD-042`, `DB-033`, `DB-035` | Discovery Portfolio Contract + novelty/affordance/exemplar matrix |
| 25 | `DB-042` | Attribute topology, power budget, damage/defense, hệ/counterplay, damage UI và ruleset separation nào đúng fantasy? | Balance + Player + Combat + UX | `PD-028`, `DB-031`, `DB-035`, `DB-053` | Balance Constitution + research/prototype plan; exact feature numbers remain child validation |
| 26 | `DB-046` | Một health substrate, HP/Mana/Focus numerical band, fixed HUD và environmental damage matrix nào scale nhưng vẫn giữ Minecraft lifecycle? | Combat Systems + UI + Platform + Balance | `DB-021`, `DB-024`, `DB-031`, `DB-039`, `DB-042` | Vitals/HUD prototype + damage-source/lifecycle matrix |
| 27 | `DB-003` | Light attack chống click/packet spam, cancel và buffer ra sao? | Combat | `DB-002`, `DB-004`, `DB-025`, `DB-048`, `DB-053` | Feature Cell + timeline/hit matrix |
| 28 | `DB-051` | Hạ Kình dùng armed fresh-Attack/mining precedence, time-to-impact/Vigor, weapon-family adapter, bounded AoE/occlusion, fall conversion và wall/mantle/aerial-action rules nào để mạnh, đúng ý định nhưng không auto-save/grief? | Traversal + Combat + Animation + Balance + Input + World | `PD-049`, `DB-003`, `DB-025`, `DB-046`, `DB-049`, `DB-050` | Grounding Strike Feature Cell + input-owner/attached-not-airborne/fall/weapon/AoE/block-safe proof |
| 29 | `DB-005` | Dodge neutral/sector/resource/i-frame/collision ra sao trên movement basis đã khóa? | Combat | `DB-003`, `DB-037`, `DB-046`, `DB-048`, `DB-053` | Dodge validation package |
| 30 | `DB-052` | Khinh Công phân xử hold Jump với normal Jump/Climb Leap, charge từ ground/wall, launch–apex–long descent, Vigor reserve/drain, obstruction/collision/combat/aerial seam và early progression ra sao mà không thành input lag/hover/flight? | Traversal + Controls + World + Balance + Accessibility | `PD-048`, `DB-002`, `DB-025`, `DB-037`, `DB-048`, `DB-049`, `DB-050`, `DB-051` | Lightness Feature Cell + tap/hold/accessibility/charge/trajectory/world/extension-seam proof |
| 31 | `DB-047` | Combat Flask initial/max charge, potency, refill/economy, commit/cancel/hit matrix, key và HUD nào tạo recovery có rủi ro nhưng không thành chore? | Combat + Items + Economy + UX | `DB-002`, `DB-003`, `DB-005`, `DB-031`, `DB-046` | Flask Feature Cell + economy/action/usability prototype |
| 32 | `DB-034` | Player–zombie–world levers nào tạo sợ đầu game nhưng giữ agency sau Free Climb/Khinh Công? | Combat + World + AI | `DB-003`, `DB-004`, `DB-005`, `DB-042`, `DB-046`, `DB-047`, `DB-050`, `DB-051`, `DB-052` | Early Danger experiment report |
| 33 | `DB-006` | Enemy đầu dạy attack–dodge–escape–recover và phản ứng vertical escape bằng pattern nào? | AI + Encounter | `DB-003`, `DB-004`, `DB-005`, `DB-034`, `DB-035`, `DB-042`, `DB-047`, `DB-050`, `DB-051`, `DB-052`, `DB-053` | Enemy Content Dossier + Teaching Card |
| 34 | `DB-054` | Combat Craft grammar nào nối input–camera–animation–audio/VFX–enemy question với dodge/parry/spacing/weapon/skill/build cho learning–competent–expert? | Combat + Skills + AI + Camera + Animation + Audio/VFX + UX | `DB-003`, `DB-005`, `DB-006`, `DB-033`, `DB-037`, `DB-042`, `DB-046`, `DB-053` | paired combat vertical + expression/synergy matrix + evidence plan |
| 35 | `DB-007` | Gate + Quest Kernel clock/leave/death/reconnect/recovery chính xác? | Dungeon + Quest + Platform | `DB-023`, `DB-024`, `DB-036`, `DB-040` | activity vertical contract + tests |
| 36 | `DB-056` | Minimal Becoming Spine nào biến activity reward thành XP/level/milestone/rank-or-unlock cue và một return record bền vững trước Arise mà chưa khóa full build? | Player + Quest + World + UX + Platform | `PROD-EXPERIENCE`, `DB-007`, `DB-031`, `DB-036` | Becoming Spine Feature Cells + reward/return/save/migration proof plan; không chờ full attribute/damage balance |
| 37 | `DB-008` | Arise eligibility/attempt/cost/echo/ownership? | Shadows | `DB-007`, `DB-042`, `DB-046`, `DB-056` | Capture Feature Cell + ADR |
| 38 | `DB-009` | Shadow Identity tối thiểu nào tạo gắn kết lâu dài? | Shadows + Narrative | `DB-008`, `DB-021`, `DB-024`, `DB-035` | state intent + content exemplar |
| 39 | `DB-010` | Summon/shatter/revive không upkeep cân bằng bằng gì? | Shadows + Balance | `DB-008`, `DB-009`, `DB-042`, `DB-046` | resource experiment |
| 40 | `DB-044` | Slot 1→8 mở bằng milestone/cadence nào; pending claim/full-roster/parting/rotation giữ breadth mà không thành power tax, filler hay chore ra sao? | Shadows + Balance + UX + Platform | `DB-008`, `DB-009`, `DB-010`, `DB-031`, `DB-042` | Retinue Capacity prototype + membership/save/rotation/home/usability matrix |
| 41 | `DB-011` | Candidate stat/specialization/Potential nào qua combat/traversal proof và migration/respec test? | Player + Balance | `DB-042`, `DB-046`, `DB-049`, `DB-050`, `DB-051`, `DB-052`, `DB-054` | approved build parameters + migration rules |
| 42 | `DB-012` | Skill tree/rune/loadout 4+1 có breadth, setup–conversion–fallback synergy mà không overload input/UI hoặc thành một rotation? | Skill + UX | `DB-002`, `DB-011`, `DB-031`, `DB-035`, `DB-054` | two-build/input/synergy test |
| 43 | `DB-013` | Command UX nhỏ nhất cho tối đa bốn active Shadow và rotation trong roster tám member là gì? | Shadows + UX | `DB-002`, `DB-037`, `DB-044`, `DB-049`, `DB-050`, `DB-052` | usability test |
| 44 | `DB-045` | Quỳ/cúi/acknowledgement/ritual/idle social được chọn, phối hợp và fallback theo personality thế nào mà không spam/cắt combat? | AI + Narrative + Animation + UX | `DB-009`, `DB-013`, `DB-025`, `DB-033`, `DB-044` | Expression semantic registry + exemplar/playtest plan |
| 45 | `DB-055` | Gate Boss Challenge Framework tách lesson/moveset/AI pattern/phase/difficulty–assist/retry/camera/animation–hit/audio-VFX ra sao qua mastery bands? | Encounter + Combat + AI + Balance + Presentation + Accessibility + QA | `DB-003`, `DB-005`, `DB-006`, `DB-007`, `DB-033`, `DB-035`, `DB-037`, `DB-042`, `DB-046`, `DB-053`, `DB-054` | Boss framework + decomposition template + mastery/difficulty validation plan |
| 46 | `DB-014` | Iron Knight dạy gì; Arise beat có gây bực? | Encounter + Narrative | `DB-008`, `DB-055` | Boss Card + playtest |
| 47 | `DB-016` | Currency/shop/item reward contracts và source/sink nào cần cho quest và Combat Flask production? | Economy | `DB-007`, `DB-035`, `DB-036`, `DB-047` | source-sink/refill simulation |
| 48 | `DB-041` | Living society identity/ledger→hub→relationship→settlement→faction ladder scale ra sao; current slice dừng ở lớp nào? | World + AI + Quest + Performance | `DB-024`, `DB-035`, `DB-036`, `DB-039` | Living Society Contract + staged Feature Cell/hub exemplar plan |
| 49 | `DB-015` | Một rich quest vertical có branch/recovery/reward/world effect/pacing ra sao? | Quest + World | `DB-007`, `DB-016`, `DB-031`, `DB-041` | quest content dossier + playable proof |
| 50 | `DB-017` | Home/family/hub xuất hiện thế nào ở first full returning-world loop? | World + Narrative | `DB-015`, `DB-041`, `C8-RETURNING-WORLD` | playable return brief |
| 51 | `DB-018` | Player + 4 active Shadow và hostile mix/crowd dùng composition, vertical follower policy, representation tier và cue nào cho `PERF-S02A/B`? | Performance + AI + Encounter | `DB-006`, `DB-013`, `DB-035`, `DB-039`, `DB-044`, `DB-045`, `DB-049`, `DB-050`, `DB-051`, `DB-052`, `DB-055` | encounter + spectacle benchmark results |
| 52 | `DB-020` | Accessibility/onboarding baseline hoàn thiện theo core mechanics nào? | UX + Localization | `MAP-SYSTEMS`, `DB-030`, `DB-031`, `DB-046`, `DB-047`, `DB-049`, `DB-050`, `DB-051`, `DB-052`, `DB-053`, `DB-055` | communication/onboarding contract |
| 53 | `DB-057` | Nhịp Không Trung/Double Jump và Aerial Dodge dùng input, `AerialChain`, one-use reset, Vigor/Focus, direction/collision/defense, Step↔Dodge cancel, Climb/Lightness/Grounding conflict và skill delivery nào để tăng expression mà không infinite flight/i-frame? | Traversal + Combat/Dodge + Input + Skills + Balance + Animation + QA | `PD-047`, `DB-002`, `DB-005`, `DB-012`, `DB-025`, `DB-037`, `DB-048`, `DB-049`, `DB-050`, `DB-051`, `DB-052`, `DB-054` | Aerial Step + Aerial Dodge Feature Cells, ADR/chain contract, direction/resource/collision/defense/loop prototype và paired feel proof |

## Product/content direction đã framed

| ID | Trạng thái | Câu hỏi nội bộ tiếp theo |
|---|---|---|
| `DB-001` | `DECIDED` | full coherent all-in-one game; release manifest do quality/coherence gate, không hỏi user fixed count |
| `DB-027` | `DISCOVERY` | first-party living world/building/mount/vehicle capability dependency graph và exemplar order; society chi tiết do `DB-041` |
| `DB-028` | `FRAMED` | M1 co-op 2–4; M2 PvP 1v1/3v3; M3 ranking/event — hiện chỉ giữ seam và threat model |

## Critical paths và lane song song

```text
Foundation: DB-019 → DB-021 → {DB-043, DB-022, DB-023} → {DB-024, DB-039, DB-038}
Embodiment: DB-053 → DB-004; DB-029 → DB-004 → DB-048 → DB-025 → {DB-049, DB-050} → {DB-002, DB-037}
Content/discovery: DB-033 → DB-035 → DB-026; DB-035 → DB-036
Combat: {DB-053, DB-042, DB-046} → DB-003 → {DB-005, DB-051} → {DB-052, DB-047} → {DB-034, DB-006} → DB-054
Activity/becoming: {DB-036, DB-040} → DB-007 → DB-056 → {DB-008, DB-009, DB-010}
Retinue/world: DB-044 → {DB-013, DB-045} → {DB-055, DB-014}; {DB-016, DB-041} → {DB-015, DB-017}
Future aerial expression: {DB-005, DB-012, DB-050, DB-051, DB-052, DB-054} → DB-057
```

Các lane có thể research song song khi dependency xanh; không dùng số Priority để bắt Art/UX chờ một decision kỹ thuật không liên quan. Baseline/irreversibility → save/security/data-loss → observability/test/performance → control/camera → content grammar → player-visible vertical vẫn là tie-breaker chung.

## Audit granularity hiện tại

- `DB-021`, `DB-054`, `DB-055` là **integrator packages**: chúng đóng coherence/architecture/framework bằng nhiều workstream nhưng tuyệt đối không trở thành một implementation ticket.
- `DB-042` dừng ở topology/constitution; exact HP/resource/Flask/build parameter đã có `DB-046`, `DB-047`, `DB-011`, tránh một “balance everything” item.
- `DB-041` tạo staged contract và Feature Cells; identity/hub proof không cấp quyền implement settlement/faction/deep-individual cùng một ticket.
- `DB-026` được đưa vào active queue để discovery/novelty không còn là lời hứa không có owner/proof.
- `DB-056` lấp dependency gap giữa persistent activity và Arise; full build depth vẫn thuộc `DB-011` và `DB-012`.
- `DB-057` cố ý đứng sau core traversal/combat/skill grammar: có thể research song song nhưng không được kéo Double Jump/Aerial Dodge vào `C2B/C3B` exit gate hoặc làm chậm core loop trước khi base Climb, Dodge, Grounding và Lightness đã có evidence.

Content lớn/khó làm muộn khi interaction contract chưa ổn định, không phải vì giới hạn tham vọng. “Nền tảng” phải có consumer/proof; không xây abstraction vô hạn hoặc NeoForge code giả trước matching port spike.
