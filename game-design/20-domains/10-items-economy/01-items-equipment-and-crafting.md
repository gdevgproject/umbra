# SYS-ITEMIZATION — Vật phẩm, trang bị và chế tạo

> **DRI:** Itemization Designer
> **Status:** `DISCOVERY`

Item definition gồm identity, category, equip slot/use context, base profile, requirements, affix pool, tags, acquisition, salvage/sell rules, presentation và version. Instance chỉ lưu roll/upgrade/durability/binding cần thiết.

## Các lớp thiết kế được bảo tồn

- rarity tiers và affix, nhưng rarity không tự bảo đảm thú vị;
- full equipment loadout và set bonus;
- growth weapon có milestone/evolution thay vì nâng số vô hạn;
- forge/crafting/salvage để chuyển loot thành lựa chọn;
- shadow gear là layer riêng chỉ khi tạo role/build, không làm inventory gấp đôi vô ích.

## Contract

Preview mọi thay đổi khó đảo ngược. Affix có vocabulary/tier/compatibility rõ. Set bonus không ép một bộ duy nhất ở mọi content. Crafting recipe gắn source/sink và discovery; không duplicate vanilla recipe nếu không thêm quyết định.

Combat recovery không được suy ra từ consumable category chung. Vessel/charge/refill/capacity/quick-slot có contract riêng tại [Combat Flask và quick recovery](03-combat-flask-and-quick-recovery.md); item/reagent chỉ cung cấp definition và acquisition cho contract đó.
