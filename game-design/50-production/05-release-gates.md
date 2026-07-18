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

## Go/no-go core release

Core promise chơi được từ new save tới return loop; không blocker/crash/save loss; regression invariants xanh; p95/p99 trong budget; Việt/Anh complete theo scope; critical cues accessible; install/backup/known issues rõ; content originality/license sạch; deferred không để lại dead-end trong UI/save.
