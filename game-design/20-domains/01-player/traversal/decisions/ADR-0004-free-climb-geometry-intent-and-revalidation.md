# ADR-0004 — Free Climb geometry-first, intent-bounded và revalidate tại commit

> **Status:** `PROPOSED`
> **Date:** 2026-07-19
> **Decision owner:** Player Traversal Designer + Gameplay Technical Designer
> **Affected IDs:** `PD-046`, `FEAT-TRAVERSAL-FREE-CLIMB`, `CTR-TRAVERSAL`, `CTR-VITALS-HUD`, `SYS-INPUT`, `SYS-CAMERA-MOVEMENT`, `SYS-WORLD-INTEGRATION`, `DB-049`, `DB-050`, `R57`, `R63`
> **Supersedes / superseded by:** none

## Context

Minecraft không chỉ có full cube: cùng một block có thể đổi collision theo state/neighborhood; partial/thin/fluid/moving geometry tạo contact và landing footprint khác nhau. Một wall-climb dựa vào block ID hoặc một animation mantle cố định sẽ snap vào mặt không tồn tại, cướp input, xuyên block khi world đổi hoặc desync giữa client và logical server. Ngược lại, cho solver tự hút tới mọi collision gần nhất làm traversal mượt nhưng mất agency và phá mining/building.

Minecraft 26.2 đã dùng dày đặc keyboard/mouse; thêm dedicated Climb/Drop mặc định làm tăng finger conflict và chi phí học. Nhưng “explicit intent” không đồng nghĩa “phím riêng”: Jump chủ động hướng vào tường là bằng chứng mạnh, khác hẳn đi va tường, auto-jump, pillar-jump đang Place, passive fall hoặc bị knockback. UMBRA cần khóa hướng kiến trúc trước prototype để fixture, animation, input và authority cùng đo một mechanic; exact threshold/timing vẫn là hypothesis của `DB-050`.

## Decision criteria

1. Ý định người chơi dự đoán được trên keyboard, analog future và hai camera.
2. Slab/stair/thin/foliage/glass/fluid/piston/mod block dùng cùng một rule có thể mở rộng.
3. World mutation, hit và packet race không tạo teleport/no-clip/double cost.
4. Animation mượt nhưng không sở hữu gameplay truth.
5. Failure/correction quan sát được, test tự động được và nằm trong hot-path budget.
6. Giữ Minecraft building, hazard và route chuẩn bị có giá trị.

## Options considered

### Option A — Block whitelist + mantle clip cố định + client smoothing

- Lợi ích: dễ mô tả, prototype nhanh trên full cube.
- Chi phí/rủi ro: exception tăng theo state/mod block; partial shape sai; clip quyết displacement; stale candidate xuyên block; không giải input/mutation race.
- Reversibility: thấp sau khi tags, animation graph và tests đều dựa vào block list.

### Option B — Bám mọi collision + strong auto-steering/root motion

- Lợi ích: coverage rộng, thường nhìn mượt và ít reject.
- Chi phí/rủi ro: bám chain/technical/moving shape vô lý; hút sai route; auto-mantle cướp build/combat; correction khó phân biệt với teleport.
- Reversibility: trung bình nhưng feel/level design dễ phụ thuộc sticky behavior.

### Option C — Geometry + profile + revision; assist bounded; semantic adaptive mantle

- Lợi ích: shape là truth, profile biểu đạt nghĩa vật liệu; assist giữ agency; mantle thích nghi mà server vẫn commit; race có revalidation/idempotency; fixture scale sang mod block.
- Chi phí/rủi ro: cần local shape decomposition, revision/invalidation, scoring/hysteresis, nhiều semantic animation và instrumentation; parameter phải prototype.
- Reversibility: cao vì thresholds/profile/assist/mantle set là data/policy quanh stable contract.

## Decision

Đề xuất chọn **Option C**:

- eligibility đi qua `collision/support geometry → continuity/clearance → SurfaceProfile/dynamic/fluid modifier → region/activity rule`;
- contact mang `WorldRevision`; attach/mantle kiểm lại ở authoritative commit, không reserve/lock world geometry;
- `ContactStabilization` chỉ sửa sai số nhỏ; `RouteAssist` có intent cone, cap và hysteresis, không đi qua gap/hazard/hidden face;
- input buffer lưu Action Intent/sequence có expiry và consume-once, không lưu raw key/frame;
- default không cần dedicated Climb key: `Jump/Traverse Up` context-transform thành jump/mantle/hop-attach/air-grab/climb-leap, `Sneak/Traverse Down` thành deliberate Drop chỉ trên fresh edge sau latch; optional precision Climb vẫn remap được;
- đi/chạy/sprint chỉ va tường không attach; explicit player Jump lineage + approach + valid face có thể attach. Auto-jump/passive fall/external force/build-use/pre-held Sneak/grazing input là inhibitor; mỗi input edge có một lineage và một consumer;
- Jump khi attached chọn targeted `UP / DYNO / WALL_EJECT` từ surface-relative direction, reserve technique cost + post-contact guard và không fallback sai hướng; Sneak Drop luôn là đường thoát không action cost;
- mantle chọn semantic `STEP_UP / LOW_MANTLE / HIGH_PULL / CREST_TRANSFER` từ geometry/approach rồi animation warp trong envelope;
- Vigor Free Climb dùng hybrid base cling time + accepted actor-authored displacement + committed action cost; không charge raw blocked input, assist/correction hoặc external force, không double-charge action với tick drain, và chỉ recovery sau stable-support dwell;
- HUD giữ một contextual fixed meter với current/reserved/next-cost/recovery semantic; va tường không bật preview, còn attached luôn giữ meter visible đến full-fade grace;
- moving piston/fluid-only không là support; dynamic/fluid/world mutation dùng external influence + invalidation/recovery rõ;
- baseline không có global rain slip hoặc fall-damage grace ẩn; rủi ro môi trường cục bộ/tất định và explicit technique giữ quyền cứu;
- logical server giữ state/resource/collision/commit; client chỉ predict trong envelope và reconcile theo correction budget.

ADR ở `PROPOSED`: đây là recommendation của discovery, chưa được coi là accepted trước voxel-room evidence và approver record.

## Consequences

- Positive: một contract phủ block vanilla/modded theo shape; dùng Space/Shift quen thuộc mà vẫn không để va tường/knockback/build cướp input; climb leap đúng hướng và cost đọc được; entry, resource, HUD, feel và authority cùng oracle; adaptive animation không phá collision; race placement/piston/hit có luật.
- Negative: input lineage/inhibitor và context transform phức tạp hơn dedicated key; cần proof nghiêm cho pillar-jump, parkour graze, pre-held Sneak, screen/mode precedence và accessibility; surface probe, Vigor projection và mantle authoring vẫn có quality cost cao.
- New constraints/debt: collision/support/fluid/dynamic revision adapter phải được pin theo Minecraft 26.2/Fabric; profile schema không được sinh trước `DB-049/050`; every fallback giữ semantic timing/cost.
- Follow-up/evidence: full fixture matrix, probe/correction benchmark, paired auto-assist/mantle playtest, two-view comfort, integrated/dedicated parity và surface-profile comprehension.

## Rollback/supersession trigger

Xem lại nếu pinned 26.2 API không cho invalidation cục bộ đủ an toàn/nhanh, shape decomposition vượt budget ngay cả sau cache, hoặc playtest chứng minh bounded assist vẫn thường xuyên cướp route. Supersession có thể thu hẹp surface/mantle set nhưng phải giữ Action Intent idempotency, authoritative commit, no-clip guarantee và fixture provenance; không quay về block whitelist rải hoặc root-motion authority.
