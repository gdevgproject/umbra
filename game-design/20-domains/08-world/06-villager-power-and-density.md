# FEAT-VILLAGE-POWER-DENSITY — Sức mạnh và mật độ NPC theo Village Hub

> **DRI:** World Designer + Progression Designer
> **Approver:** Game Director
> **Reviewers:** AI, Combat, Character Art, Data, Platform, Performance, QA
> **Status:** `DISCOVERY`

## 1. Contract một câu

Khi người chơi bước vào một Village Hub, silhouette/giáp/effect và raw HP/damage của NPC cho thấy Level tăng đơn điệu, trong khi resident roster tạo kim tự tháp theo `NPC-DENSITY-*` và các band thấp dần đông hơn.

## 2. Level bands và monotonic power

Band và quan hệ tăng đơn điệu canonical nằm tại `NPC-POWER-001`, `NPC-VISUAL-001` và `NPC-DENSITY-*` trong [Parameter Registry](../../60-quality/02-parameter-registry.md). Một NPC thuộc đúng một band; band cao không bị đếm lồng vào band thấp hơn.

Đây là strict monotonic base curve, không khẳng định linear multiplier. Gear/status/injury có thể làm current outcome khác nhưng không đổi displayed Level/base definition. Exact HP/damage curves phải giữ Minecraft numerical stability và một `LivingEntity` health truth; visual tier dùng silhouette trước particle spam.

## 3. Resident quota mỗi Village Hub

Ba hard cap upper-tier canonical là `NPC-DENSITY-070/080/090` tại [Parameter Registry](../../60-quality/02-parameter-registry.md). `0–N` nghĩa cap, không phải mỗi làng được bảo đảm đủ N. Bands rời nhau và rarity toàn world/content vẫn phải được kiểm; cap không phải target fill.

Đối với band dưới 70, phân bố tuân `NPC-DENSITY-LOW`: các band thấp chiếm đại đa số resident và weight không được đảo chiều khi Level tăng. Exact lower-band cap/weight phụ thuộc hub capacity và world simulation, còn `OPEN`; không được hard-code một làng nhỏ phải chứa số dân không phù hợp POI.

## 4. Village Hub và residency tương thích Minecraft

`VillageHub` là stable settlement identity bao quanh một cụm POI/residence đã resolve, không phải assumption “mỗi chunk/mỗi bell là một làng”. Hub record giữ stable ID, anchors/POI revision, capacity, resident IDs, band counts và reconcile reason.

- Spawn/grant/immigration chỉ commit resident nếu quota/capacity authoritative còn chỗ.
- NPC đi ngang/quest visitor không trở thành resident ngay; dwell/home assignment mới đổi residency qua transaction. Visitor không được dùng để lách permanent quota; long dwell phải reassign/relocate hoặc remain explicitly itinerant với cap riêng.
- POI add/remove, village merge/split, chunk unload, dimension transfer và save migration trigger reconcile. Reconcile **không xóa, clone, hạ Level hoặc đổi identity** NPC overflow; nó giữ actor, chuyển residency/relocation queue bằng visible reason và bounded processing.
- Unloaded/far resident vẫn được đếm từ roster record; không spawn thêm chỉ vì entity chưa hydrate.
- Vanilla villager profession/trade/bed/workstation/raid/iron-golem lifecycle giữ compatibility scenarios. UMBRA resident metadata không thay POI rule Minecraft bằng heuristic không kiểm chứng.

## 5. Visual contract

- Silhouette, armor mass/layer, weapon/equipment read và bounded effect intensity tăng theo visual tier; không chỉ đổi màu/particle.
- First/third-person readability, distance LOD, resource-pack missing asset và armor/skin compatibility có fallback.
- High-level rarity phải đọc được mà không che trade/quest icon, hit telegraph hoặc gây photosensitivity. Audio sting/title plate là cue phụ, có subtitle/reduced intensity.
- Visual tier không tự commit HP/damage; renderer đọc immutable actor definition/snapshot.

## 6. Authority, save, loader và performance

- Logical server sở hữu Hub/residency/Level/base stats/quota; client chỉ project. Spawn packet/client cache không quyết resident slot.
- Hub/resident schema versioned, backup/migration/restore/cross-loader-safe; no Fabric/NeoForge ID/type trong canonical save.
- Risk `PR-3`: settlement cardinality + entity/POI lifecycle. Allocation/reconcile event-driven/batched, spatial query cap, no full-world scan, hydrate/dehydrate không double-count.
- LOD giảm animation/effect/social cadence trước; Level, quota, HP/damage, identity và committed move không degrade.

## 7. Acceptance

- Spawn/reload/unload qua boundary sinh từ `NPC-DENSITY-070/080/090`, gồm dưới/đúng/vượt cap, giữ band rời nhau và không delete/demote.
- Hub merge/split/POI mutation/bed move/dimension/restore xử lý overflow idempotent, không duplicate resident hoặc fill slot từ unloaded actor.
- Lower-band distribution validator bắt weight inversion và upper-tier fill-as-target.
- For every supported Level sample, base HP/damage strict monotonic và visual tier nondecreasing; overflow/precision/cap boundary test.
- Vanilla profession/trade/raid/golem/POI behavior vẫn hoạt động hoặc unsupported case có diagnostic rõ.
- `PERF-S01` hub stress giữ tick/memory/save budget; no full-population scan/path storm.

## 8. Open decisions

- Exact Level→HP/damage curves và visual tier thresholds.
- Hub capacity/lower-band weights, visitor/itinerant cap và merge/split relocation UX.
- World-generation placement và content source nào tạo upper-tier NPC mà vẫn giữ rarity toàn save.
