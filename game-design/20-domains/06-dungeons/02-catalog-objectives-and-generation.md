# SYS-DUNGEON-COMPOSITION — Loại dungeon, objective và generation

> **DRI:** Dungeon Designer
> **Status:** `DISCOVERY`

## Sáu loại ứng viên

| Loại | Câu hỏi gameplay |
|---|---|
| Assault | người chơi kiểm soát nhịp tấn công tuyến tính ra sao? |
| Hunt | lần dấu và cô lập mục tiêu trong không gian biến đổi ra sao? |
| Rescue | ưu tiên tốc độ, an toàn hay reward như thế nào? |
| Defense | bố trí, command và địa hình chống nhiều wave ra sao? |
| Puzzle/Trial | quan sát và suy luận thay vì combat stat ra sao? |
| Hybrid | hai grammar kết hợp có tạo quyết định mới không? |

Tên có thể đổi; mỗi loại cần objective grammar thật, không chỉ label.

## Objective model

Objective là graph có điều kiện bắt đầu, progress event, completion, failure, optionality và recovery. Kill count chỉ là một primitive. Các primitive khác: reach, protect, interact, survive, escort, collect-in-instance, disable, discover và choose.

## Generation pipeline

```text
rank/type/theme/seed
→ select authored room grammar
→ assemble critical path + optional branches
→ validate connectivity, budget, objective placement, exit
→ decorate encounters/rewards
→ dry-run invariants
→ publish instance hoặc fail an toàn
```

Jigsaw/template pool cần socket semantics, spatial clearance, encounter budget và version. Generation không được chặn server tick; prebuild/cache policy thuộc Platform.

## Pacing

Mỗi dungeon có opening read, escalation, contrast/rest, teaching/check, climax và exit. Rare event là biến thể làm đổi quyết định, không phải loot chest đổi màu.
