# PROD-RELEASE-GATES — Cổng capability và phát hành

> **DRI:** Producer
> **Status:** `APPROVED_FOR_DOCUMENTATION`

## Gate cho mỗi capability

1. **Intent:** outcome/pillar/scope/owner rõ.
2. **Design:** scenarios, dependencies, state, player communication và non-goals đầy đủ.
3. **Validation:** research/prototype/playtest/simulation đúng loại rủi ro.
4. **Implementation Ready:** contract/parameters/acceptance/data/migration/performance risk/budget/debug/loader-boundary review xong; runtime feature có public surface/state-thread-transaction owner/failure/consumer map và architecture conformance proof.
5. **Integrated:** automated proof xanh, human playtest đạt, docs/content đồng bộ.
6. **Release:** compatibility, accessibility, localization, performance, soak, migration và recovery đạt.

Mỗi capability integrated tạo playable snapshot manifest: commit/schema/baseline, automated results, lifecycle IDs, user Test Card result nếu có, known issues và backup/rollback note. Human playtest chỉ kiểm câu hỏi con người; không thay test logic/lifecycle.

Port/release đổi Minecraft phải kèm official/API diff, key baseline diff, adapter/patch inventory, data/resource version check, clean restore + migration, dedicated/integrated và graphics-backend evidence. Port loader phải giữ cùng Minecraft baseline khi khả thi và thêm adapter conformance, artifact manifest, cross-loader save fixture, parity/performance matrix. Content batch phải có dossier/asset provenance/interaction validation; số lượng không bù quality gate.

Promote Minecraft successor chỉ khi current line vẫn có final green build, successor qua `PR-3` port matrix và README/manifest/release/issue-support projection đồng bộ. EOL gate yêu cầu immutable final tag/assets/checksum, migration-to successor, EOL date/reason, branch freeze và downgrade warning; upstream release date một mình không được đóng support.

## Go/no-go core release

Core promise chơi được từ new save tới return loop; không blocker/crash/save loss; regression invariants xanh; p95/p99 trong budget; Việt/Anh complete theo scope và đổi locale runtime đúng; critical cues accessible; third-person default/first-person supported; install/verified backup-transfer/known issues rõ; content originality/license sạch; deferred không để lại dead-end trong UI/save. Mỗi loader chỉ được ghi `SUPPORTED` bằng artifact/test/performance manifest riêng; Fabric pass không tự cấp NeoForge support.
