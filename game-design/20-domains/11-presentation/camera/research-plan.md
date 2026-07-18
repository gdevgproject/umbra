# SYS-CAMERA — Research và Prototype Plan

> **Owner:** Camera Designer
> **Status:** `DISCOVERY`

## Decision questions

1. Baseline third-person là centered, over-shoulder hay context-adaptive?
2. Mouse/gamepad-like input sở hữu camera yaw hay character facing ở từng context?
3. Aim ray bắt đầu camera, mắt, actor hay muzzle; parallax được trình bày/validate ra sao?
4. Occlusion dùng retract, fade actor/block, shoulder swap hay tổ hợp nào trong block geometry?
5. Soft target và lock-on có cần cùng một target lifecycle không?

## Reference lenses

- Where Winds Meet/Black Myth: combat framing, martial animation và boss readability.
- Genshin Impact: exploration→combat transition, mobile/PC readability và party spectacle.
- GTA V/ARK: traversal, vehicle/mount, living-world interaction và camera context breadth.
- Minecraft vanilla first/F5: baseline block interaction, mod compatibility và player expectation.

Không chép distance/FOV/lock rule. Mỗi quan sát cần clip/timecode/version/platform và transfer constraint sang block geometry.

## Prototype sequence

1. Camera harness room: corridor, wall, stair, foliage, fluid, flying target, large actor.
2. Three base rigs behind config; record obstruction, aim error, motion comfort.
3. Mining/place/interact parity before combat.
4. Light attack + Dodge basis; projectile parallax.
5. Soft target/lock prototype; boss/squad stress.
6. First/third switch, death/portal/reload and client GameTest screenshot baselines.

## Evidence

Automated: camera state trace, ray/target overlay, obstruction counters, screenshot baselines at fixed seeds/poses. Human: comfort, predictability, target comprehension và “fighting the camera” incidents. User chỉ cần test hardware/feel sau automated set xanh.
