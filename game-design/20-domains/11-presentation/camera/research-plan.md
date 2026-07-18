# SYS-CAMERA — Research và Prototype Plan

> **Owner:** Camera Designer
> **Status:** `DISCOVERY`

## Decision questions

1. Context-adaptive baseline phối hợp centered exploration, combat framing và over-shoulder precision theo transition rule nào?
2. Mouse/gamepad-like input sở hữu camera yaw hay character facing ở từng context?
3. Aim ray bắt đầu camera, mắt, actor hay muzzle; parallax được trình bày/validate ra sao?
4. Occlusion dùng retract, fade actor/block, shoulder swap hay tổ hợp nào trong block geometry?
5. Soft target và lock-on có cần cùng một target lifecycle không?
6. Weapon/action nào cần reticle, soft target, lock-on hoặc first-person option; có auto-switch nào thật sự tốt hơn player choice?

## Reference lenses

- Where Winds Meet/Black Myth: combat framing, martial animation và boss readability.
- Genshin Impact: exploration→combat transition, mobile/PC readability và party spectacle.
- GTA V/ARK: traversal, vehicle/mount, living-world interaction và camera context breadth.
- Minecraft vanilla first/F5: baseline block interaction, mod compatibility và player expectation.

Không chép distance/FOV/lock rule. Mỗi quan sát cần clip/timecode/version/platform và transfer constraint sang block geometry.

## Prototype sequence

1. Camera harness room: corridor, wall, stair, foliage, fluid, flying target, large actor.
2. Centered/shoulder/context-adaptive rigs sau config; record obstruction, aim error, transition surprise và motion comfort.
3. Mining/place/interact parity before combat.
4. Light attack + Dodge basis; projectile parallax.
5. Soft target/lock prototype; boss/squad stress.
6. First/third switch, death/portal/reload and client GameTest screenshot baselines.
7. Mỗi reference claim về Genshin/Where Winds/Black Myth phải có capture/version/platform; không dùng ký ức “game đó chắc có/không có reticle” làm fact.

## Evidence

Automated: camera state trace, ray/target overlay, obstruction counters, screenshot baselines at fixed seeds/poses. Human: comfort, predictability, target comprehension và “fighting the camera” incidents. User chỉ cần test hardware/feel sau automated set xanh.
