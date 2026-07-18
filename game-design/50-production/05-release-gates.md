# PROD-RELEASE-GATES — Cổng capability và phát hành

> **DRI:** Producer
> **Status:** `APPROVED_FOR_DOCUMENTATION`

## Gate cho mỗi capability

1. **Intent:** outcome/pillar/scope/owner rõ.
2. **Design:** scenarios, dependencies, state, player communication và non-goals đầy đủ.
3. **Validation:** research/prototype/playtest/simulation đúng loại rủi ro.
4. **Implementation Ready:** contract/parameters/acceptance/data/migration/perf/debug review xong.
5. **Integrated:** automated proof xanh, human playtest đạt, docs/content đồng bộ.
6. **Release:** compatibility, accessibility, localization, performance, soak, migration và recovery đạt.

Mỗi capability integrated tạo playable snapshot manifest: commit/schema/baseline, automated results, lifecycle IDs, user Test Card result nếu có, known issues và backup/rollback note. Human playtest chỉ kiểm câu hỏi con người; không thay test logic/lifecycle.

Port/release đổi Minecraft phải kèm official/API diff, key baseline diff, adapter/mixin inventory, data/resource version check, clean restore + migration, dedicated/integrated và graphics-backend evidence. Content batch phải có dossier/asset provenance/interaction validation; số lượng không bù quality gate.

## Go/no-go core release

Core promise chơi được từ new save tới return loop; không blocker/crash/save loss; regression invariants xanh; p95/p99 trong budget; Việt/Anh complete theo scope và đổi locale runtime đúng; critical cues accessible; third-person default/first-person supported; install/verified backup-transfer/known issues rõ; content originality/license sạch; deferred không để lại dead-end trong UI/save.
