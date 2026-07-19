# Items/Economy — gói đọc của hai domain cộng tác

Folder này co-locate hai domain vì reward loop buộc Itemization và Economy review nhau thường xuyên; nó **không** nhập hai quyền sở hữu thành một domain. Đọc theo thứ tự:

1. [`DOM-ITEMS`](items-domain-charter.md) — item/equipment/crafting definition, instance và transformation.
2. [`DOM-ECONOMY`](economy-domain-charter.md) — source/sink/value/trade/reward allocation.
3. [Items, equipment và crafting](01-items-equipment-and-crafting.md).
4. [Currencies, sources, sinks và anti-exploit](02-economy.md).
5. [Combat Flask và quick recovery](03-combat-flask-and-quick-recovery.md) — Feature Cell cross-domain dùng cả hai owner.

Nếu economy mở settlement/faction market hoặc itemization mở nhiều pipeline độc lập, hai charter vẫn scale riêng mà không cần đổi stable ID. Physical folder chỉ được tách khi navigation thật sự có lợi; Git giữ path history.
