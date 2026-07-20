# PROD-ROADMAP — Roadmap capability như mod độc lập

> **DRI:** Producer + Game Director + Technical Director
> **Status:** `PROPOSED`

Mỗi phase kết thúc bằng một playable/internal snapshot có flag, manifest, save/migration, automated proof và rollback riêng. “Như mod độc lập” nghĩa outcome có thể chạy/đánh giá/cô lập; không nghĩa tách gameplay truth, universal JAR hoặc fork save. Public 1.0 vẫn là full coherent game.

## 1. Tầng ổn định và tầng thay đổi

```text
Tầng A — version/loader adapters        thay theo Minecraft/Fabric; không giữ game rule
Tầng B — kernel + public contracts      ổn định, đổi có ADR/migration/consumer proof
Tầng C — capability implementations     phát triển cuốn chiếu sau Feature gate
Tầng D — data/content/presentation      đổi thường xuyên qua schema/validation/fallback
Design plane — living docs/DB/CR         sửa liên tục nhưng luôn rebaseline ticket/code/test
```

Foundation chỉ được thêm abstraction khi có blocker khó đảo hoặc ít nhất hai consumer thật. Tầng ổn định không đồng nghĩa đóng băng vĩnh viễn; nó có version, compatibility promise và migration. Tầng thay đổi không được bypass public contract để “đi nhanh”.

## 2. Capability phases

| Phase | Outcome đóng phase | Dependency/gate chính | Independent snapshot proof |
|---|---|---|---|
| `C0-DESIGN-OS` | feedback dài được atomize, route và rebaseline không mất ý | governance, Product decisions, traceability | validator + cold-agent continuity/CR fixtures |
| `C1-FOUNDATION-KERNEL` | Fabric shell trên baseline đã pin; modular-monolith boundary, authority, flags, save/migration, locale, diagnostics/test harness hoạt động | `DB-019`, `DB-021`, `DB-022`, `DB-023`, `DB-024`, `DB-030`, `DB-038`, `DB-039`, `DB-043` | integrated/dedicated load→save→restore, architecture/import violations, causal trace, performance control |
| `C2-PLAYER-EMBODIMENT` | Camera UMBRA: third-person rig/occlusion, camera-relative movement/facing, aim/build/mine và first-person parity | C1 + Input/Camera/Animation contracts | camera room + toggle/rollback; không cần skill/combat content |
| `C2S-SKILL-PLATFORM` | versioned Skill Definition/validator, full-future Library preview, Level 1/5 grant ledger và equip sandbox với một harmless exemplar | C1 + skill acquisition/UI/content contracts | skill sandbox + missing-content/migration/locale/100-card stress; không cần final damage/quest |
| `C2B-VERTICAL-FREEDOM` | Vigor HUD/ledger + Level-1 Dodge movement + Free Climb/mantle trong voxel room; trở lại mine/place bình thường | C1 + C2 camera seams + Vigor/Climb/Dodge movement contracts | exact arithmetic, voxel collision, lifecycle/save/rollback, `PERF-S09A` |
| `C3-COMBAT-RHYTHM` | one HP truth, Light Attack/hit cadence, Dodge defensive window và một-charge Combat Flask trong shelter arena | C2 + C2S public action/effect seam + combat Feature Cells | spam/idempotency/damage-source/feel/early-danger proof |
| `C3B-AERIAL-MASTERY` | Hạ Kình sau combat lesson và Khinh Công Level 10 chạy qua loaded terrain/dummy ở hai camera | C2B + C3 action/hit | 1–100+ drop, fall conversion/radius/collision, Lightness anti-flight, `PERF-S09B` |
| `C3S-SKILL-EXPRESSION` | hai authored skill lines khác role, full preview và loadout tạo hai cách giải arena mà không resource bar mới | C2S + C3 | setup/conversion/fallback, input/UI, save/migration và effect-cardinality proof |
| `C4-PERSISTENT-ACTIVITY` | một authored activity/Gate quest có observation/interact/combat, leave–reload–return | C1 + C3 | quest/instance/reward idempotency và recovery |
| `C4B-BECOMING-SPINE` | reward→EXP/Level/mốc skill→return record/home anchor→save | C2S + C4 | Level 4→5/9→10/multi-level/catch-up + continuity proof |
| `C5-ARISE-IDENTITY` | hạ→Trỗi Dậy→một Shadow có tên→summon/shatter/revive/save | C4B + Shadow contracts | duplicate/death/reload/missing-content proof |
| `C6-BUILD-EXPRESSION` | skill/loadout/gear/Retinue/capability mastery tạo nhiều build thật, không Rank/Primary Attribute/Potential/Prestige | C3S + C5 | multi-build/mastery/migration; HP/Vigor cap exploit matrix |
| `C7-RETINUE-MASTERY` | roster 1→8, tối đa 4 active, command/role/formation/identity sâu | C5 + C6 | 0/1/2/4 active balance, eight-save/usability, `PERF-S02A/B` |
| `C8-RETURNING-WORLD` | Village Hub có Level-power/density, rare traits/Bully/Guardian/flee, quest/economy/home consequence | C4 + C7 + society Feature Cells | hub merge/split/save/performance, nonlethal/flee/personality comprehension |
| `C9-CORE-GAME-ALPHA` | survival→skill/traversal→Gate→growth→Shadow→return loop dài hạn | các phase trước xanh | new-save journey, soak, content cadence, save support |
| `C10-FULL-PRODUCT` | full public promise | campaign/content/endgame/install/support gates | complete journey + migration/recovery/performance/accessibility |

`C2` và `C2S` là hai train ưu tiên sau C1; có thể song song vì cùng chỉ đọc kernel public surfaces. Chúng không được import internals của nhau. `C2B` tích hợp camera seam và Vigor movement; `C3S` tích hợp skill platform với combat sau khi hit/damage đã có owner.

## 3. Sequencing invariants

- Không code gameplay khi Feature/Contract consumed chưa `IMPLEMENTATION_READY`; draft ticket không phải authorization.
- Baseline Minecraft/Fabric phải pin trước project shell; không invent 26.2 API từ memory. NeoForge future chỉ claim support sau matching artifact/parity gate.
- Camera base và Skill Platform đứng trước combat content rộng. Final damage không chặn harmless skill exemplar; Skill Platform không phát minh damage rule.
- Dodge/Free Climb có từ Level 1 trong product, nhưng implementation snapshot có thể dùng grant fixture trước Level/Quest integration.
- Hạ Kình cần Light Attack/hit/fall owner; Khinh Công cần Vigor/collision/camera. Production grant theo combat lesson/Level 10 chỉ nối ở C4B; không làm physics code phụ thuộc quest order.
- Society/NPC density không chen vào kernel. Kernel chỉ cung cấp identity/save/LOD/spatial/diagnostic primitive bằng consumer proof.
- Prologue/family được design song song; first integrated return beat ở C8/C9. Multiplayer gameplay không chen current phases.
- Mọi phase giữ snapshot trước load/migrate được, incomplete feature không lộ và rollback không corrupt world.

## 4. Mainline exit gate chung

1. scope/outcome/non-goal và design baseline exact;
2. public surface/writer/thread/clock/transaction/failure/consumer map;
3. feature flag + rollback + save/migration/missing-content recovery;
4. targeted, neighbor, integration, lifecycle và `PR-0–PR-3` evidence xanh;
5. Fabric adapter/import conformance; NeoForge `N/A — not yet supported` cho tới port gate;
6. `vi_vn/en_us`, accessibility và first/third view khi liên quan;
7. one-question Vietnamese Test Card chỉ sau automated pack;
8. manifest/ledger/handoff đủ để cold Agent tiếp tục từ repo.
