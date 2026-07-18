# ADR-0002 — Retinue tám kết ước, bốn triển khai

> **Status:** `APPROVED`
> **Date:** 2026-07-19
> **Decision owner:** Game Director
> **Affected IDs:** `PD-031`, `CTR-SHADOW-RETINUE`, `DOM-SHADOWS`, `DB-044`, `R05`, `R51`, `C7-RETINUE-MASTERY`
> **Supersedes / superseded by:** supersedes topology `5 bonded / 4 active` trước đây trong `PD-031`; chưa bị supersede

## Context

Cap năm giữ combat gọn nhưng chỉ cho một reserve, làm chiều rộng collection/role rotation và home presence quá hẹp so với fantasy xây Hắc Ảnh Cận Vệ dài hạn. Tăng actor chiến đấu lại làm xấu protagonist agency, camera, target/readability, AI coordination, encounter balance và performance. Cần tách rõ sức chứa danh tính khỏi cardinality trận đấu.

## Decision criteria

1. Giữ người chơi là chủ thể trực tiếp của combat và command.
2. Có đủ roster breadth để thu phục, gắn kết và luân chuyển role qua hành trình dài.
3. Bảo vệ identity depth, save safety, UI comprehension và performance.
4. Không tạo army archive, power tax hoặc quan hệ all-pairs không thể sản xuất.

## Options considered

### Option A — 5 bonded / 4 active

- Lợi ích: chỉ một reserve; relationship/UI scope nhỏ nhất.
- Chi phí/rủi ro: ít chỗ cho collection, role counter-pick và home/social roster; full-roster pressure xuất hiện sớm.
- Reversibility: tăng cap về sau cần migration/UI/progression change.

### Option B — 8 bonded / 4 active

- Lợi ích: bốn active giữ combat budget; tối đa bốn reserve mở rotation, collection có danh tính và home presence.
- Chi phí/rủi ro: 28 cặp quan hệ toán học, roster UI/save/migration và content depth nặng hơn; cần sparse relationship và management budget.
- Reversibility: cap có thể giảm/tăng chỉ với migration khó và nguy cơ mất identity, nên phải chứng minh trước implementation.

### Option C — 8 bonded / hơn 4 active

- Lợi ích: fantasy quân số trực tiếp mạnh hơn.
- Chi phí/rủi ro: phá quality bar camera/command/readability/encounter/performance và dễ để AI tự chơi thay player.
- Reversibility: rất đắt vì combat/AI/content balance phụ thuộc cardinality.

## Decision

Chọn **8 bonded / 4 active**. Roster mở từ một tới tối đa tám slot; không có roster phụ. Tối đa bốn member combat-deployed; các member còn lại chỉ là reserve/home/assignment hợp lệ và không đóng góp power budget trận hiện tại. Exact unlock cadence, safe swap, pending claim và full-roster flow vẫn ở `DB-044`/validation.

## Consequences

- Positive: roster breadth không buộc tăng combat clutter; nhiều role/build rotation và identity collection hơn.
- Negative: UI, authored content, save/migration, home staging và attachment proof phải xét tám member.
- New constraints/debt: relationship graph sparse/event-driven; không author 28 edge chỉ để lấp đủ; slot 5–8 không thành chore hoặc baseline DPS requirement.
- Follow-up/evidence cần thu: slot 1→8 progression/usability, full-roster claim, reserve rotation, home LOD/staging, attachment recognition và migration fixtures; combat vẫn test 0/1/2/4 active.

## Rollback/supersession trigger

Chỉ xem lại nếu prototype chứng minh tám identity làm giảm recognition/attachment, UI/production/save cost không thể bounded hoặc bốn active không đủ cho fantasy command. Mọi giảm cap phải có migration giữ nguyên identity; không được xóa member vượt cap.
