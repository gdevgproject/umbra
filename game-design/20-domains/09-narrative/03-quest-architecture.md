# SYS-QUEST — Kiến trúc quest dài hạn và có thể mở rộng

> **DRI:** Quest Designer + Technical Designer
> **Status:** `DISCOVERY`

## 1. Quest promise

Quest không phải danh sách `kill N` hoặc chiếc vỏ phát reward. Nó điều phối mục tiêu, khám phá, nhân vật, lựa chọn, world mutation và consequence thành một hành trình có nhịp, save/reload an toàn và đáng nhớ.

UMBRA cần campaign/character/world quest dài và đa dạng như một game hoàn chỉnh, đồng thời có systemic contracts để thế giới phản ứng. Không đặt trần số quest; mỗi quest cụ thể vẫn là Content Instance có state graph, staging và quality gate riêng.

## 2. Hai lớp không được trộn

- **Quest Kernel:** stable IDs/version, state machine, objective events, branch/condition, journal/marker hooks, reward/effect transaction, save/migration, debug/test. Kernel được chứng minh sớm cùng activity/Gate.
- **Quest Content:** câu chuyện, pacing, objective composition, character/world consequences, assets/dialogue/rewards. Rich content mở dần sau khi dependency thật sẵn sàng.

Kernel sớm không có nghĩa viết campaign trước combat, item, economy hoặc world mutation contracts.

## 3. Quest families

| Family | Vai trò và quality question |
|---|---|
| Main | campaign/reveal/world transformation; mỗi chapter đổi câu hỏi hoặc năng lực gì? |
| Character | bond, identity, conflict và arc; lựa chọn có đổi quan hệ/hành vi không? |
| Training | dạy rồi kiểm tra mechanic trong tình huống, có retry/recall help |
| Guild/Contract | objective có biến thể, faction/economy consequence; không thành chore board |
| World/Systemic | phản ứng với Gate, Break, faction, settlement và event state |
| Discovery | observation/environmental inference; không marker hóa mọi bí mật |
| Construction/Management | xây, bảo vệ, quy hoạch hoặc cung ứng có world payoff, không maintenance daily |

## 4. Lifecycle

```text
LOCKED → AVAILABLE → OFFERED → ACTIVE → RESOLVING → COMPLETED
                         ↘ FAILED / ABANDONED / SUSPENDED
```

Quest definition có stable ID/version, prerequisites, offer policy, objective/branch graph, dialogue refs, world effects, rewards, failure/abandon/recovery, localization keys và debug hooks. Quest instance chỉ lưu branch choices, objective progress, committed effects/rewards và timestamps cần thiết; display/cached target là derived.

## 5. Objective grammar

Event-driven primitives: reach, talk, inspect, interact, defeat, survive, protect, escort, acquire/submit, craft, build/repair, discover, choose, wait-for-world-state và composite all/any/sequence. Primitive chỉ là vocabulary; quest hay đến từ context, staging, changing conditions, character/world meaning và consequence—not đổi động từ cho có.

Polling tick chỉ dùng khi không có event hợp lệ. Combat objective nhận authoritative defeat event, không đếm click/animation/client packet.

## 6. Reward/effect transaction

Quest không tự spawn item/cộng tiền/sửa block bằng script tùy ý. Nó gửi typed reward/effect request tới owner: item/economy, progression, faction, world mutation, unlock hoặc relationship. Transaction có preview khi cần, idempotency key, validation, commit result và recovery. Reward dependency chưa Ready thì quest content chưa Ready.

## 7. Safety and continuity

- Transition/reward/world effect idempotent.
- Save/load/reconnect không replay cutscene, dialogue gate hoặc claim.
- Target mất/chunk unload/NPC chết hoặc version content đổi có recovery/suspended reason.
- Branch không bị ghi đè bởi update; migration bảo tồn irreversible choice.
- Quest text không chứa logic machine-readable duy nhất.
- Marker/journal/difficulty guidance có policy theo quest.
- Main quest không block vĩnh viễn vì một optional economy/shop/faction state.
- Abandon/reaccept/replay không duplicate unique item, relationship hoặc world mutation.

## 8. Definition of Ready

Intent/theme, prior state, state graph, objective oracle, staging/pacing, branch/consequence, fail/recovery, typed reward/effect dependencies, world ownership, localization, assets, debug command, transition tests và continuity review đều có owner. Thiếu một dependency thật thì quest ở `DISCOVERY`, không tạo ticket script để “làm trước”.

Production/dependency order nằm tại [Quest dependency map](05-quest-dependency-and-production.md); từng quest dùng [Quest Content Instance Template](../../80-templates/quest-content-instance-template.md).
