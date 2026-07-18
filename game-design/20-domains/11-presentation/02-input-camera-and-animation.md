# SYS-CONTROL-PRESENTATION — Input, camera và animation

> **DRI:** UX/Input + Camera + Animation Leads
> **Status:** `DISCOVERY`

## Input

Thiết kế dùng action names/context, không dùng phím cố định. Mọi action có default candidate, remap, conflict rule, press/hold/release semantics, buffer và accessibility alternative. Combat, vanilla, UI và command context có precedence hiển thị được.

## Camera

First-person giữ cảm giác Minecraft gốc; third-person cải tổ là mode ứng viên trọng yếu cho combat/squad spectacle. Hai mode cùng gameplay rule và target state. Camera contract gồm facing, crosshair/soft target/lock-on, obstruction, recenter, sensitivity, FOV, shake và motion reduction.

Lock-on là Feature Cell riêng, không phải một cờ trong Dodge. Không chốt third-person kiểu Genshin bằng cảm giác tham chiếu; cần prototype khoảng cách, yaw ownership, target switch, verticality và block-space obstruction.

## Animation

Animation biểu đạt phase/intent; gameplay marker được server xác nhận. Dodge cần clip/pose theo hướng hoặc blend grammar, nhưng hitbox/i-frame không suy ra từ frame hình. Root motion, cancel, foot sliding, weapon alignment, first/third-person parity và fallback khi asset thiếu đều cần contract.
