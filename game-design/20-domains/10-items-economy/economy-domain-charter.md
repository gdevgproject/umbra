# DOM-ECONOMY — Nguồn, hút, giao dịch và phân bổ phần thưởng

> **DRI:** Economy Designer
> **Approver:** Lead Game Designer
> **Reviewers:** Progression, Items, Quest, World, Balance, UX, Platform, QA
> **Status:** `DISCOVERY`

## Mission

Làm công sức và phần thưởng giữ giá trị qua world dài: mỗi source, sink, price và service phải tạo lựa chọn có fantasy, chống exploit/FOMO và không ép một farm hoặc currency thành đường chơi duy nhất.

## Sở hữu

- currency identity, source/sink/cap/inflation và conversion policy;
- shop/service/catalog/price semantics và transaction/provenance;
- reward allocation theo activity/faction/world layer;
- economy simulation, exploit response, migration và source–sink evidence;
- cadence/cost của Combat Flask refill/upgrade, không sở hữu vessel/action/heal rule.

## Không sở hữu

- item definition/affix/equip/crafting transformation (`DOM-ITEMS`);
- XP/rank/build unlock (`DOM-PLAYER`);
- quest state hoặc world/faction truth (`DOM-NARRATIVE`, `DOM-WORLD`);
- balance parameter final không có simulation/evidence owner.

## Invariants

- Không FOMO, daily streak, time-exclusive power hoặc diminishing return bí mật theo tài khoản.
- Mỗi currency phải chứng minh một quyết định không thể dùng currency hiện có thay thế.
- Source/sink có cadence, exploit vector, telemetry và recovery/migration rõ.
- Economy không tự chạy ở fidelity cao ngoài tầm nhìn nếu outcome không tạo quyết định quan sát được.
- Sửa exploit công khai nguyên nhân và giữ save/value hợp lý; không nerf âm thầm chỉ vì một route phổ biến.

## Systems

- [`SYS-ECONOMY`](02-economy.md)
- [`FEAT-COMBAT-FLASK`](03-combat-flask-and-quick-recovery.md), đồng review với Items/Combat
