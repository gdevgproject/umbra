# SYS-COMBAT-VITALS — HP, Vigor, damage và death

> **DRI:** Combat Systems Designer
> **Status:** `DISCOVERY`

Combat không sở hữu nhiều thanh resource. `HP` là health truth Minecraft-compatible; `Vigor` là custom action resource duy nhất, được Dodge tiêu qua shared transaction nhưng topology/recovery do [`CTR-VITALS-HUD`](../../30-shared-contracts/08-vitals-resource-and-hud-contract.md) và [`CTR-TRAVERSAL`](../../30-shared-contracts/09-traversal-state-surface-and-vigor-contract.md) sở hữu.

Mana, Focus, Fatigue và Posture meter đã bị xóa. Combat skill dùng cooldown/charge/condition/commitment theo Feature Contract; stagger/stun/launch là typed result, không hidden pool. Food/hunger, oxygen, potion/status, absorption và damage source vẫn giữ lifecycle Minecraft qua mapping tập trung.

## Damage direction

- Một final health commit trên logical server, stable action/hit/source/operation ID và retry idempotent.
- Damage/defense/gear/counter curve không dựa Primary Attributes hoặc Rank.
- Environmental family giữ attribution/hazard; Hạ Kình chỉ convert fall component tại valid impact.
- Exact formula/rounding/crit/armor/resistance/status chưa được approve; Parameter Registry không chứa lại công thức legacy.

## Death

Death/recovery canonical ở [Death policy](death/README.md). Current HP/Vigor/runtime action reset theo mode profile; permanent Level/skill/mastery/Shadow identity giữ theo approved persistence matrix. Reconnect/death không refill exploit hoặc để reservation/action ma.
