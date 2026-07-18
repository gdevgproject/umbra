# Design Discovery Queue

> **DRI:** Producer + Lead Game Designer
> **Status:** `ACTIVE`
> **Đây không phải code backlog.**

## Nguyên tắc ưu tiên

Ưu tiên theo `fan-out × cost of change × uncertainty`, không theo độ hấp dẫn của content. Một quyết định input/action/hit sai sẽ làm lại hàng chục feature; một boss cụ thể sai thường chỉ làm lại boss đó.

## Wave 0 — Product và vocabulary

1. Duyệt Product Charter và định nghĩa scope ladder.
2. Chốt thuật ngữ song ngữ nguồn: Focus, Fatigue/Thể Lực, Potential, Rank, Gate, Shadow.
3. Xác định platform baseline là release decision có ngày kiểm chứng, không là pillar.
4. Định nghĩa playtest profile: vanilla, builder, ARPG, accessibility, technical/server.

**Exit:** Product Charter `APPROVED`; terminology contract `PROPOSED`; prototype target rõ.

## Wave 1 — Combat foundation contracts

1. `CTR-INPUT-ACTION` và combat context.
2. `CTR-ACTION-TIMELINE`.
3. `CTR-COMBAT-HIT` với attack cadence/chống spam click.
4. `CTR-CAMERA-TARGET` cho góc 1/3.
5. `CTR-ANIMATION-EVENT`.
6. `CTR-ACTOR-AUTHORITY` ở mức single-player integrated server + latency-ready.
7. Paired `FEAT-COMBAT-LIGHT-ATTACK` + `FEAT-COMBAT-DODGE` prototype.

**Exit:** Combat Foundation Capability Slice có thể playtest, chưa cần progression/quest/Gate.

## Wave 2 — Player/resource/quest foundations

1. Resource philosophy HP/Mana/Focus/Fatigue.
2. Progression contract level/stat/rank/unlock; giải conflict auto/free.
3. Quest domain tách narrative/training/systemic contract.
4. Localization, UI state language và onboarding foundation.
5. Persistence taxonomy và debug observability.

**Exit:** một training loop không FOMO, có recovery/debug, không cần invent rule trong code.

## Wave 3 — Gate/encounter/content foundation

1. Gate lifecycle review từ candidate cũ.
2. Objective/quest ledger relationship.
3. Dungeon room/instance/cleanup contract.
4. Một faction, enemy role set và boss teaching content cell.
5. Performance scene/budget cùng prototype.

**Exit:** một Gate nhỏ có begin–objective–boss–loot–exit–return behavior hoàn chỉnh.

## Wave 4 — Shadow identity loop

1. corpse/Soul Echo lifecycle cùng Gate.
2. Arise attempt/capture contract.
3. roster identity/save/migration.
4. summon/revive/resource/authority.
5. một command và một relationship signal.

**Exit:** đánh bại → thu phục → đặt tên → gọi → chiến đấu cùng → trở về, có attachment test.

## Sau Wave 4

Chỉ lúc này mới đủ evidence để vẽ lại milestone/1.0 scope. Legion depth, city/family, economy breadth, strata, Tower và full narrative đi qua discovery theo dependency thực tế; không tự động thừa kế M3–M8 cũ.

