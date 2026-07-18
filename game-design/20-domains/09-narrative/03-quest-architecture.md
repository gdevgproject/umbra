# SYS-QUEST — Kiến trúc quest có thể mở rộng

> **DRI:** Quest Designer + Technical Designer
> **Status:** `DISCOVERY`

Quest không phải danh sách `kill N`. Nó là state machine điều phối mục tiêu, lựa chọn, world mutation, dialogue và reward theo cách save/reload an toàn.

## Quest families

| Family | Vai trò |
|---|---|
| Main | campaign/reveal và thay đổi world lâu dài |
| Character | bond, identity và arc |
| Training | dạy rồi kiểm tra một mechanic |
| Guild/Contract | mục tiêu chọn lọc, economy/faction |
| World/Systemic | phản ứng với Gate, Break, faction, event |
| Discovery | observation/exploration, không marker hóa mọi bí mật |

## Lifecycle

```text
LOCKED → AVAILABLE → OFFERED → ACTIVE → RESOLVING → COMPLETED
                         ↘ FAILED / ABANDONED / SUSPENDED
```

Quest definition có stable ID/version, prerequisites, offer policy, objective graph, branches, dialogue refs, world effects, rewards, failure/abandon/recovery, localization keys và debug hooks. Quest instance lưu branch choices, objective progress, claimed effects/rewards và timestamps; không lưu derived display.

## Objective grammar

Event-driven primitives: reach, talk, inspect, interact, defeat, survive, protect, escort, acquire/submit, craft, discover, choose, wait-for-world-state và composite all/any/sequence. Polling tick chỉ dùng khi không có event hợp lệ.

## Safety rules

- Transition/reward/world effect idempotent.
- Save/load/reconnect không replay cutscene hoặc claim.
- Objective target mất/không tồn tại có recovery path hoặc trạng thái suspended giải thích được.
- Branch không bị ghi đè bởi content update; migration rõ.
- Quest text không chứa logic machine-readable duy nhất.
- Marker, journal và accessibility có policy theo quest, không mặc định một kiểu.

## Quest Definition of Ready

Intent, prior state, state graph, objective oracle, branch/consequence, fail/recovery, reward contract, world ownership, localization, debug command và test matrix đều có owner. Thiếu một mục thì quest còn `DISCOVERY`.
