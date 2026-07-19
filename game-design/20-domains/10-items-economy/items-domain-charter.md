# DOM-ITEMS — Vật phẩm, trang bị và chế tạo

> **DRI:** Itemization Designer
> **Approver:** Lead Game Designer
> **Reviewers:** Combat, Progression, Economy, Content, UX, Platform, QA
> **Status:** `DISCOVERY`

## Mission

Biến loot, equipment và crafting thành lựa chọn về build, preparation và identity; mỗi item có definition/instance/lifecycle đọc được và không dùng rarity hoặc item level để giả chiều sâu.

## Sở hữu

- item/equipment definition, persistent instance và equip/use context;
- slot/loadout, rarity/affix/set/growth-weapon semantics;
- craft/reforge/salvage transformation và preview của thay đổi khó đảo;
- item validity, missing-definition fallback, migration và presentation requirement;
- vessel/reagent/upgrade identity của Combat Flask, không sở hữu giá/cadence nguồn–hút.

## Không sở hữu

- currency, price, faucet/sink, shop/service và reward allocation (`DOM-ECONOMY`);
- combat action/hit/heal outcome (`DOM-COMBAT`);
- progression unlock/power budget (`DOM-PLAYER`, Quality/Balance);
- content/asset production pipeline.

## Invariants

- Trang bị mạnh đổi cách chuẩn bị/build với trade-off đọc được, không chỉ tăng item level.
- Junk có bulk/favorite/protection flow nhưng không biến chuyến đi thành inventory chores.
- Item từ loot/craft/Creative/command có cùng validity contract và provenance phù hợp.
- Không tạo state item song song ngoài world save hoặc để loader/runtime handle thành canonical identity.
- Food giữ vai trò hunger/survival; Quick Recovery chỉ nhận item đã opt-in contract.

## Systems

- [`SYS-ITEMIZATION`](01-items-equipment-and-crafting.md)
- [`FEAT-COMBAT-FLASK`](03-combat-flask-and-quick-recovery.md), đồng sở hữu với Combat và tiêu thụ Economy contract
