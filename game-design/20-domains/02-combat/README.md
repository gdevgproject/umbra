# DOM-COMBAT — Combat Domain Charter

> **DRI:** Combat Designer
> **Approver:** Lead Game Designer
> **Reviewers:** UX/Input, Animation, Gameplay Engineering, Encounter, QA, Accessibility
> **Status:** `DISCOVERY`

## Mission

Biến hành động chiến đấu trong Minecraft thành một hệ thống đọc được, có trọng lượng, tạo khoái cảm điều khiển và có không gian mastery, trong đó timing, vị trí, phản xạ, phối hợp skill–build, chuẩn bị và chỉ huy đều tạo quyết định; không làm mất agency xây dựng/khai phá của vanilla.

## Sở hữu

- combat context/stance ở cấp trải nghiệm;
- action timeline và tương tác attack–dodge–parry–skill;
- hit cadence, combo, posture và damage/status semantics;
- combat resources phối hợp với Systems/Balance;
- feel requirement cho camera/animation/VFX/SFX;
- death/combat recovery ở cấp luật.

## Không sở hữu

- key registration/runtime implementation (`DOM-PRESENTATION`/`DOM-PLATFORM`);
- enemy decision logic (`DOM-AI`);
- boss composition (`DOM-ENCOUNTERS`);
- progression unlock/economy cost (`DOM-PLAYER`, `DOM-ECONOMY`);
- asset production pipeline.

Combat vẫn là approver hoặc reviewer khi các domain đó thay đổi nhịp/đọc/counterplay.

## System decomposition

| System ID | Feature Cells dự kiến | Fan-out/risk |
|---|---|---|
| `SYS-COMBAT-CONTEXT` | enter/exit combat, vanilla action coexistence | high |
| `SYS-ACTION-RESOLUTION` | light attack, heavy attack, dodge, parry, skill activation, weapon swap | critical |
| `SYS-HIT-RESOLUTION` | hit cadence, hitbox/hurtbox, immunity, damage, multi-hit, friendly ownership | critical |
| `SYS-COMBAT-VITALS` | một health truth, environmental damage, fixed HUD, Mana/Focus semantics | critical |
| `SYS-COMBAT-RESOURCES` | Focus use/recovery, Mana cost, Fatigue contribution, Combat Flask touchpoints | high |
| `SYS-COMBAT-FLOW` | combo, posture, stagger, finisher, recovery/death | high |
| `SYS-WEAPON-RHYTHM` | dagger/sword/polearm/ranged/staff moveset grammar | medium after foundation |

## Thứ tự discovery hợp lý

1. Camera base/aim/occlusion và `CTR-CAMERA-TARGET` cùng vanilla interaction proof.
2. Combat context và `CTR-INPUT-ACTION`.
3. Action timeline + hit cadence/chống spam click + animation event contract.
4. Light attack và Dodge như một paired prototype; không đánh giá dodge trong chân không.
5. Parry/posture.
6. Skill activation/weapon swap.
7. Combo/resources/balance.
8. Weapon class/content scale.

## Feature catalog

| ID | Contract tóm tắt | Status |
|---|---|---|
| `FEAT-COMBAT-LIGHT-ATTACK` | click có chủ đích tạo một attack beat hợp lệ, không nhân damage theo click spam | `SEED` |
| `FEAT-COMBAT-HEAVY-ATTACK` | giữ/thả cam kết đòn nặng đổi rủi ro lấy posture/impact | `SEED` |
| `FEAT-COMBAT-DODGE` | input có hướng đổi vị trí và tạo cửa sổ phòng thủ có giới hạn | `DISCOVERY` |
| `FEAT-COMBAT-PARRY` | timing chủ động biến telegraph thành cơ hội phản công | `SEED` |
| `FEAT-COMBAT-COMBO` | chuỗi hành động tốt duy trì nhịp mà không ép spam | `SEED` |
| `FEAT-COMBAT-POSTURE` | áp lực đúng loại mở stagger/finisher, không chỉ HP thứ hai | `SEED` |
| `FEAT-COMBAT-DEATH-REVIEW` | thất bại giải thích được và dẫn tới lựa chọn học/retry | `SEED` |
| `FEAT-COMBAT-FLASK` | một press tạo recovery có commitment, charge và interrupt đọc được | `DISCOVERY` |

Feature Cell và system spec chi tiết:

- [Dodge](dodge/README.md)
- [Death, consequence và trở lại cuộc chơi](death/README.md)
- [Vitals, Mana, Focus và HUD](../../30-shared-contracts/08-vitals-resource-and-hud-contract.md)
- [Combat Flask và quick recovery](../10-items-economy/03-combat-flask-and-quick-recovery.md)

## Domain invariants đề xuất

- Một click không được tạo nhiều hit chỉ vì client gửi lặp.
- Gameplay hit do server xác nhận; animation/VFX không tự gây damage.
- Mọi hành động mạnh có anticipation, cost/commitment và recovery đọc được.
- Input→pose→movement/hit→feedback phải bảo toàn intent; responsive không xóa commitment và animation đẹp không được tự chơi thay người chơi.
- Độ khó chiến đấu phải tạo learning/adaptation/execution; stat, camera, AI hoặc clutter không được là nguồn khó chính không thể học.
- Không feature combat nào vô hiệu hóa toàn bộ category counterplay mà không có ngoại lệ hiển thị rõ.
- First-person và third-person có parity về rule, dù presentation khác.
- Mining/building/item vanilla không bị action layer chiếm input ngoài context rõ.

Các invariant này vẫn `PROPOSED` cho tới domain approval.
