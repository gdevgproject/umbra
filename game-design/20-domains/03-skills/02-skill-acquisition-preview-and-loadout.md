# FEAT-SKILL-ACQUISITION — Skill acquisition, preview và loadout

> **DRI:** Skill Designer
> **Approver:** Lead Game Designer
> **Reviewers:** Progression, UI/UX, Combat, Animation, Localization, Platform, QA, Performance
> **Status:** `DISCOVERY`

## 1. Contract một câu

Từ Level 1, người chơi thấy toàn bộ library tương lai và có một active skill; mỗi mốc 5 Level trao đúng một authored unlock event, còn loadout giới hạn số skill đang trang bị để build có lựa chọn mà không quá tải input.

## 2. Acquisition

Exact cadence/formula/samples canonical là `SKL-START/CADENCE/GRANTS-001` tại [Parameter Registry](../../60-quality/02-parameter-registry.md). `SkillUnlockEvent(level, line_id, reward_id, operation_id)` là idempotent. Multi-level reward phát từng milestone theo thứ tự; reload/retry không duplicate.

Một event trao **một** reward authored: `NEW_SKILL`, `NODE` hoặc `LOADOUT_SLOT`. Nó không tự mở cả ba và không mặc định tăng slot. Loadout cap, reslot rule và line topology cần prototype input/UI; không được suy từ số grant.

## 3. Full-future preview

Mỗi skill card từ Level 1 phải có:

- tên/localized description, stable ID, line và unlock condition;
- active/passive/signature, role tối đa hai, input context và locomotion profile;
- target/shape/range, cost/cooldown/charge, startup/commit/recovery;
- damage/effect value hoặc approved range, scaling/cap, conditions và counterplay;
- weapon/Retinue/world interaction, friendly/occlusion rule;
- animation preview theo weapon/body family hoặc rõ fallback khi asset chưa tồn tại;
- accessibility cue, first/third-person behavior và changed/version marker.

UI không bịa số từ client hoặc duplicate formula. Preview đọc cùng versioned Skill Definition dùng bởi authority. Nội dung chưa production-ready có thể mang nhãn `DESIGN_PREVIEW`, nhưng không được giả là exact final. Nếu một field ảnh hưởng build chưa được quyết, card nói rõ `Đang cân bằng` thay vì giấu.

## 4. Runtime và save

- Progression sở hữu Level; Skills sở hữu known/unlocked/equipped state và skill-definition version.
- Unlock grant, equip swap, cooldown/charge và effect commit là transaction riêng có reason/operation ID.
- Mana/Focus/Fatigue/Posture không tồn tại. Skill không có Vigor cost trừ khi nó thật sự là movement capability và được Vigor owner chấp thuận; baseline combat skill dùng cooldown/charge/condition hoặc commitment riêng, không tự sinh resource bar.
- Missing/removed definition không xóa save: quarantine slot, show diagnostic và cho reselection/compensation theo migration policy.
- Creative/debug có grant/all-unlock/test loadout với provenance; không đổi Survival truth.

## 5. Input, camera, animation và performance

- Loadout UI phải giữ vanilla inventory/chat/movement context và remap; exact layout thuộc Input owner.
- Preview animation chạy trong bounded scene/model, reduced-motion có static key poses/timeline và không tải world asset vô hạn.
- Library search/filter không scan/rebuild toàn definition graph mỗi frame; validation phát hiện missing ref/cycle/conflict trước runtime.
- Active execution luôn qua action/hit/resource/effect owner; animation preview không thể commit damage.

## 6. Acceptance

- Level 1/5/10/100, multi-level grant, retry/reload/migration cho đúng formula và một event mỗi milestone.
- Mọi skill future nhìn thấy đủ contract ở `vi_vn/en_us`, GUI scale và keyboard-only; animation missing/reduced-motion có fallback.
- Preview value/version khớp authoritative definition; changed skill không âm thầm giữ text cũ.
- Loadout full, duplicate/conflict, removed skill và missing content recover mà không mất unlock ledger.
- 100+ skill-card stress không tạo frame spike/GC churn ngoài budget; content validation bắt cycle/missing dependency.

## 7. Open decisions

- Exact loadout cap và slot reward cadence nào giữ input đọc được?
- Hai exemplar skill line nào chứng minh runtime đủ rộng mà không abstract quá mức?
- Damage/cooldown range và preview animation production pipeline thuộc child discovery; không block formula grant/save contract.
