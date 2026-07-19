# ADR-0003 — Một active Minecraft line với immutable final releases

> **Status:** `PROPOSED`
> **Date:** 2026-07-19
> **Decision owner:** Build/Release Engineer + Platform/Compatibility Engineer + Project Owner
> **Affected IDs:** `PD-013`, `PD-043`, `SYS-COMPAT`, `SYS-SAVE-PORTABILITY`, `CTR-DEBUG-OBSERVABILITY`, `QLT-TEST`, `PROD-RELEASE-GATES`, `DB-019`, `R35`
> **Supersedes / superseded by:** none

## Context

Minecraft phát hành nhanh và không hứa semantic compatibility cho mod. UMBRA can thiệp registration, input, render, persistence và tương lai world generation; cùng lúc người chơi cần biết chính xác artifact nào dùng được và phải giữ bản cuối của world cũ. Repo đã có port/adapters nhưng chưa khóa support-line lifecycle, Git branch/tag/release model hoặc EOL communication.

## Decision criteria

1. Không bỏ current line trước khi successor thực sự load/save/migrate được.
2. User nhìn README/Release là biết exact Minecraft/loader và tải được final old-line artifact.
3. `main` luôn playable; port failures cô lập và bisect được.
4. Không nhân chi phí feature/backport trên nhiều Minecraft line vô hạn.
5. Tag, binary, checksum và migration claim có provenance không bị viết lại.

## Options considered

### Option A — `main` chạy theo snapshot/latest upstream

- Lợi ích: thấy break sớm, version badge mới nhanh.
- Chi phí/rủi ro: toolchain/API đổi liên tục; world và mainline không ổn định; support truth mơ hồ.
- Reversibility: thấp khi save/artifact snapshot lan tới user.

### Option B — duy trì đồng thời nhiều Minecraft line có feature parity

- Lợi ích: user không cần nâng Minecraft sớm.
- Chi phí/rủi ro: một studio người+Agent phải backport/test/render/save trên nhiều graph; feature và bug semantics dễ phân kỳ.
- Reversibility: trung bình nhưng nợ matrix tăng theo mỗi release.

### Option C — một current line, gated successor, final immutable old line

- Lợi ích: current vẫn ổn trong khi port; support truth đơn giản; old artifact/world không biến mất; chi phí dài hạn bounded.
- Chi phí/rủi ro: có khoảng trễ sau Mojang release; EOL user không nhận feature/fix thường lệ.
- Reversibility: cao vì exact manifests/tags/branches và migration fixtures giữ provenance.

## Decision

Đề xuất Option C. `PD-043` khóa outcome: một Minecraft release baseline chính; snapshot chỉ research; successor không thay current cho tới gate. Khi promote, UMBRA cắt final immutable old-line release, giữ download, ghi EOL/successor/migration và đóng branch. Version UMBRA tách khỏi compatibility coordinates; manifest exact là source of support truth, README/GitHub Release/CI là projections.

Chi tiết state, naming, branch và evidence do [`SYS-COMPAT`](../03-compatibility-and-release-baseline.md) sở hữu. ADR chưa `ACCEPTED` cho tới khi Project Owner duyệt exact model và `DB-019` tạo manifest schema/first 26.2 record.

## Consequences

- Positive: không chạy theo snapshot, không đánh mất 26.2, port/debug có blast radius và last-known-good rõ.
- Negative: UMBRA có thể không hỗ trợ Minecraft mới ngày đầu; maintenance exception cần cherry-pick/test riêng.
- New constraints/debt: release manifest generator/checker, GitHub ruleset audit, exact issue form, final-line migration fixture và artifact provenance.
- Follow-up/evidence cần thu: `DB-019` pin manifest; C1 tạo CI/diagnostic contribution; lần port đầu chứng minh branch/promote/EOL drill trước public claim.

## Rollback/supersession trigger

Xem lại nếu release cadence/capacity thực tế chứng minh hai current lines bền vững, hoặc upstream cung cấp compatibility layer đủ để cùng artifact/test matrix không tăng rủi ro. Supersession không được xóa final assets/tags/manifests hoặc làm world downgrade; mọi line chuyển theo release record mới.
