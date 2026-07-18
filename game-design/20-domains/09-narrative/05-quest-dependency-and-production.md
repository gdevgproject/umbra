# SYS-QUEST-DELIVERY — Dependency map và quy trình sản xuất quest

> **DRI:** Quest Lead + Producer + Technical Designer
> **Status:** `PROPOSED`

## 1. Dependency graph

```text
stable IDs + events + save/migration + localization
                    ↓
Quest Kernel: state/objective/condition/debug/test
       ↓                 ↓                    ↓
journal/marker      gameplay events      reward/effect contracts
       ↓                 ↓                    ↓
       └──────── quest vertical slice ────────┘
                         ↓
dialogue/character/world mutation/cinematics/content breadth
```

## 2. Sequencing by capability

| Slice | Quest work hợp lệ |
|---|---|
| `C1` | ID/schema/event envelope, save/migration, localization/test fixtures—chưa quest content |
| `C2` | prompt/journal/navigation primitives và input/accessibility proof |
| `C2B` | disposable traversal training/grant scenario; chưa production quest hoặc dialogue |
| `C3` | authoritative combat/survive/interact event oracles; training micro-scenario có thể disposable |
| `C3B` | disposable Grounding Strike/Lightness training proof; capability không phụ thuộc Quest Kernel |
| `C4` | Quest Kernel vertical: một activity/Gate quest rời–reload–death–return, typed test reward |
| `C5–C7` | Arise/identity/build/squad objective/effect adapters và character quest exemplars |
| `C8` | home/family/world/economy/faction consequences; rich quest verticals và campaign kits |
| `C9+` | chapter/campaign breadth, systemic recombination, continuity/soak/polish |

Typed test reward ở C4 không phải production economy. Quest trao item/currency/reputation thật chỉ khi owner contract và source/sink policy Ready.

Production delivery của Free Climb/Hạ Kình/Khinh Công là early universal training chain sau Quest Kernel: level/milestone tạo eligibility, quest trao capability + tutorial, migration/over-level có catch-up grant. Quest không biến core traversal thành missable branch, Potential choice hoặc inventory token.

## 3. Quest production gates

```text
Narrative/experience seed → dependency audit → beat map
→ state/objective graph → paper continuity review → graybox
→ gameplay/reward/world integration → dialogue/asset production
→ localization/accessibility → transition/save/chaos tests
→ pacing/emotional playtest → release
```

Không viết full dialogue/cinematic trước graybox flow. Không batch quest từ template trước khi một exemplar của family đi hết pipeline. Quest quality review đánh meaning, agency, pacing, variety, re-entry sau nghỉ dài và world consequence; số phút hoặc số objective không chứng minh chất lượng.

## 4. Cross-system impact checklist

Mỗi quest khai rõ dependency state (`AVAILABLE/REQUIRED/OPTIONAL/FALLBACK`) cho combat, AI/NPC, item, currency/shop, progression, faction, world generation/mutation, location, camera/cutscene, dialogue/voice, UI/journal, localization, save/migration và multiplayer authority. Producer không xếp implementation trước dependency `REQUIRED`.

## 5. Scale rule

Campaign có thể rất dài, nhưng production mở theo kit/exemplar và dependency maturity. Late content được phép phối hợp nhiều hệ hơn vì interaction harness đã tồn tại; early quest cố ý hẹp để chứng minh kernel, không đại diện trần tham vọng.
