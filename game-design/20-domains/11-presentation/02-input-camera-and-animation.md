# SYS-CONTROL-PRESENTATION — Input, camera và animation

> **DRI:** UX/Input + Camera + Animation Leads
> **Status:** `DISCOVERY`

## Input

Thiết kế dùng action names/context, không dùng phím cố định. Mọi action có default candidate, remap, conflict rule, press/hold/release semantics, buffer và accessibility alternative. Combat, vanilla, UI và command context có precedence hiển thị được.

## Camera

Third-person overhaul đã được khóa là core capability, không còn là optional presentation. Canonical contract, decomposition và test nằm tại [Camera System](camera/README.md). File này chỉ sở hữu ranh giới camera–input–animation.

First-person và third-person dùng cùng action/target authority. Input layer gửi action/aim intent; camera client trình bày/predict nhưng không tự quyết hit/interaction. Lock-on, aim, obstruction và context transition là các Feature Cell riêng.

## Animation

Animation biểu đạt phase/intent; gameplay marker được server xác nhận. Dodge cần clip/pose theo hướng hoặc blend grammar, nhưng hitbox/i-frame không suy ra từ frame hình. Root motion, cancel, foot sliding, weapon alignment, first/third-person parity và fallback khi asset thiếu đều cần contract.
