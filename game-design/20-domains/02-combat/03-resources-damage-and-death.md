# SYS-COMBAT-RESOURCES — Tài nguyên, damage và thất bại

> **DRI:** Systems Designer + Combat Designer
> **Status:** `DISCOVERY`

## Bốn tài nguyên có nhiệm vụ khác nhau

| Tài nguyên | Quyết định nó tạo | Không được biến thành |
|---|---|---|
| HP | còn chịu được bao nhiêu sai lầm | damage sponge không feedback |
| Mana | phân bổ sức mạnh skill/phép/triệu hồi đặc biệt | phí duy trì làm fantasy Hắc Ảnh Cận Vệ khó chịu |
| Focus | nhịp phòng thủ chủ động như dodge/parry | stamina chung trừng phạt mọi di chuyển |
| Fatigue | áp lực dài hạn giữa các cuộc chinh phục | timer ép đăng nhập hay nghỉ chơi |

Focus riêng cho hành động phòng thủ là phương án dẫn đầu nhưng chưa khóa. Fatigue tác động hồi phục/chuẩn bị theo nhịp dài, không drain theo giây trong combat.

## Damage pipeline khái niệm

```text
legal hit → base profile → attacker modifiers → target mitigation
→ resistance/status interaction → guard/posture → HP result
→ reaction, attribution, telemetry
```

Thứ tự và rounding chỉ có một canonical home trong Parameter Registry. Crit, armor penetration, elemental resistance, level scaling và damage variance đều là candidate cho tới khi prototype có dữ liệu.

## Time-to-kill

TTK là budget theo archetype và mastery band, không phải một con số toàn game. Regular enemy phải đủ lâu để biểu lộ một pattern; elite đủ lâu để tạo adaptation; boss đủ lâu để dạy rồi kiểm tra nhưng không lặp phase vô ích. Balance review đo median, p10/p90 và số lỗi được dung thứ.

## Death và recovery

Damage pipeline kết thúc ở một death intent hợp lệ; toàn bộ consequence, game-mode composition, Shadow recall, activity transition và recovery do [Death, consequence và trở lại cuộc chơi](death/README.md) sở hữu. File này không lặp policy đó.

Death review vẫn tiêu thụ attribution từ damage pipeline: nguồn damage, action/hit ID, cue phòng thủ liên quan và status quan trọng. Nó không được suy đoán nguyên nhân khi telemetry không đủ.
