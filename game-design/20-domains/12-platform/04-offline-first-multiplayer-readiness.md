# SYS-MULTIPLAYER-READINESS — Offline-first và lộ trình multiplayer tương lai

> **DRI:** Technical Director + Security Reviewer
> **Approver:** Game Director
> **Reviewers:** Platform, Combat, Shadows, Quest, Data, Performance, QA
> **Status:** `PROPOSED`

## 1. Scope và target ladder

UMBRA hiện chỉ thiết kế/triển khai single-player offline. Multiplayer gameplay không chen vào current capability slices.

| Mốc | Target | Trạng thái |
|---|---|---|
| `M0` | offline/integrated server, một player | current |
| `M1` | co-op party 2–4 người trong cùng world/activity | future priority đầu tiên |
| `M2` | instanced đối kháng `1v1` và `3v3` | future |
| `M3` | matchmaking, ranking và event service | future, chỉ sau security/operations proof |

Không hứa persistent MMO society, world vô hạn người hoặc PvP open-world. Lộ trình này chỉ khóa những seam khó đảo ngược; nó không cấp quyền xây lobby, party, matchmaking hay anti-cheat ngay bây giờ.

## 2. Foundation invariants

- Integrated single-player và dedicated server đi cùng logical-server gameplay path; Fabric xác nhận single-player vẫn có server giao tiếp với client.
- Client chỉ gửi intent; server kiểm ownership, permission, state, range/line-of-sight, resource, cooldown, target và rate.
- Không dùng local player/global singleton làm owner của Gate, quest, Shadow, loot hoặc world effect.
- Persistent identity dùng stable player/world/party/instance IDs; display name không là key.
- Command/reward/world mutation có idempotency key, provenance và audit reason.
- Packet/payload có codec/version, size/range/cardinality cap, unknown-data handling và rate limit.
- Sync theo tracking/relevance/visibility; không broadcast toàn roster/world state vô điều kiện.
- Missing, stale hoặc malicious data phải bị reject/recover, không crash server hay tạo item/damage/reward.
- Offline path không serialize/network work không cần thiết; readiness không được làm single-player chậm hoặc phức tạp vô ích.

Nguồn kỹ thuật chính: [Fabric Networking](https://docs.fabricmc.net/develop/networking) — packet nối client/server và server tồn tại cả trong single-player.

## 3. Ownership model phải khai dù đang offline

Mỗi feature trả lời:

- actor owner và quyền chuyển/ủy quyền;
- world/party/activity/instance owner;
- shared state hay per-player state;
- reward claimant và exactly-once claim;
- visibility public/party/private;
- authority khi owner dead, offline, disconnect hoặc reconnect;
- abandon/cleanup/timeout/conflict rule;
- save location và merge/migration policy.

Player, party, world và activity là bốn scope khác nhau; không dùng boolean `isMultiplayer` thay ownership model.

## 4. Seam riêng cho co-op 2–4

Trước `M1`, discovery phải khóa:

- host/dedicated topology và save/world owner; không hứa host migration trước proof;
- party join/leave/reconnect và capability/version negotiation;
- quest/Gate shared progress so với personal objective/reward;
- Shadow ownership, summon cap, command collision và unique identity;
- revive/death/respawn khi đồng đội còn activity;
- pause/time behavior, friendly fire và difficulty scaling;
- loot/reward reservation, disconnect claim và duplicate prevention;
- relevance sync cho roster đông, VFX và world mutation;
- privacy, moderation và invite/session boundary tương xứng scope nhỏ.

Co-op không được biến solo thành bản “thiếu người”. Encounter scaling ưu tiên composition/AI/mechanic trước khi chỉ nhân HP.

## 5. Seam riêng cho PvP 1v1/3v3

- PvP dùng ruleset/parameter profile và status/cap riêng khi cần; mặc định không nerf fantasy PvE để cứu ranked balance.
- Match state tách khỏi persistent world mutation; loadout eligibility, version/build/ruleset ID được ghi cùng result.
- Server không tin aim/hit/damage/reward do client tự báo; rate, replay, impossible state và forged component có audit.
- Ranking chỉ tồn tại khi có identity/security, disconnect/forfeit, result signing, abuse/recovery và operations policy. Git/local save không phải leaderboard authority.
- Event service là layer sau matchmaking/ranking ổn định, không phải dependency của core game.

## 6. Prediction và determinism

Server authority không đồng nghĩa input/camera local chậm. Mỗi action khai phần client được predict, correction cue và state server quyết định. UMBRA không cần deterministic lockstep toàn game; chỉ cần stable ordering/idempotency và đủ event trace để tái hiện tranh chấp.

## 7. Security threat seeds

Packet spam/replay, impossible target/range, forged item/component, duplicate reward, command escalation, oversized payload, stale version, entity ID reuse, chunk-unload race, reconnect race, save tampering, ranked result forgery và denial-of-service theo cardinality.

Current foundation cần validation/cap/log/rejection/recovery hooks; full anti-cheat, account service và live operations chờ đúng milestone.

## 8. Performance và test gates

- Mỗi authority path có integrated + dedicated smoke khi capability thật xuất hiện.
- Future benchmark `PERF-S08` dùng dedicated server + 4 automated clients để thử serialization/relevance; không tuyên bố co-op playable từ benchmark đó.
- Ownership, reconnect, duplicate, malformed payload và version mismatch có automated tests trước human co-op playtest.
- Không tuyên bố multiplayer-ready nếu chưa có capability manifest chỉ rõ mốc `M0–M3` và evidence thực tế.

## 9. Điều bị cấm

- Không implement speculative netcode hoặc service cho feature chưa có consumer.
- Không thêm abstraction “phòng khi cần” nếu chưa chỉ ra blocker khó đảo ngược.
- Không lưu gameplay truth ở client để làm offline nhanh hơn.
- Không trộn PvE/PvP parameter vào một bảng nếu thay đổi một bên phá bên kia.
- Không dùng tham vọng tương lai để trì hoãn playable proof hiện tại.
