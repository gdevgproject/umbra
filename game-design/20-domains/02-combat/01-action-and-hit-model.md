# SYS-ACTION-RESOLUTION — Mô hình hành động và hit

> **DRI:** Combat Designer
> **Reviewers:** Gameplay Engineering, Animation, UX/Input, QA
> **Status:** `DISCOVERY`

## Kết quả người chơi

Mỗi input hợp lệ tạo đúng một ý định có thể đọc, bị ràng buộc bởi nhịp của hành động thay vì tốc độ click. Người chơi hiểu vì sao đòn trúng, trượt, bị hủy hoặc chưa được phép bắt đầu.

## Timeline chung

Mọi hành động chiến đấu dùng cùng vocabulary:

```text
REQUESTED → VALIDATED → ANTICIPATION → ACTIVE → RECOVERY → COMPLETE
                         ↘ CANCELLED / INTERRUPTED
```

- Client gửi intent; server kiểm tra context, resource, cooldown và state.
- Một `action_instance_id` chỉ được commit một lần.
- Hit chỉ có thể phát sinh trong cửa sổ `ACTIVE`, từ gameplay marker đã được server công nhận.
- Animation, VFX và packet lặp không tự gây damage.
- Input đến sớm có thể vào buffer hữu hạn; không biến thành chuỗi tự chạy dài.
- Cancel window là dữ liệu của từng action, không phải ngoại lệ rải trong code.

## Hit cadence và chống spam

Một hit mang `attack_instance_id`, `hit_index`, nguồn, chủ sở hữu, target và damage profile. Target lưu cửa sổ miễn lặp theo attack instance. Multi-hit phải khai báo số nhịp/cadence; quét hitbox nhiều tick không được mặc nhiên tính nhiều lần.

Click liên tục chỉ có thể:

1. tạo intent mới nếu action hiện tại cho phép queue/cancel;
2. bị bỏ qua với feedback nhẹ nếu buffer đầy;
3. tuyệt đối không nhân damage của action đang active.

## Ma trận cancel cấp cao

| Từ | Attack | Dodge | Parry | Skill | Item/vanilla |
|---|---|---|---|---|---|
| Anticipation | theo action | chỉ khi marker cho phép | chỉ khi marker cho phép | không mặc định | không |
| Active | không | ngoại lệ có giá | không | không | không |
| Recovery | queue | late-cancel ứng với build | queue | queue | khi thoát combat context |

Chi tiết thuộc từng Feature Cell. Bảng này là định hướng, chưa phải thông số khóa.

## Rule không thương lượng

- Gameplay authority ở server; client prediction không được thay đổi kết quả cuối.
- Một target không nhận cùng hit hai lần do lag/retry.
- Friendly ownership phải đi xuyên suốt player → skill/projectile/shadow để tránh self-hit và attribution sai.
- Thời gian gameplay dùng tick/server clock; presentation có thể nội suy nhưng không sở hữu luật.
- Mọi failure phải phân biệt được qua debug trace: invalid context, insufficient resource, cooldown, state conflict, target invalid hay duplicate.

## Cần đóng trước implementation

- độ dài buffer và semantics “latest wins” hay FIFO;
- bảng cancel cụ thể cho light/heavy/dodge/parry/skill;
- lag policy, prediction và reconciliation;
- hitbox source theo từng camera/animation mode;
- rule cho projectile, AoE, damage-over-time và cleave.
