# CNT-ASSET-PIPELINE — Asset production, provenance và registry

> **DRI:** Art Producer + Technical Art Lead + Audio Producer
> **Reviewers:** Art/Audio Directors, Animation, VFX, Rendering, Legal/IP, Accessibility, QA
> **Status:** `PROPOSED`

## 1. Asset taxonomy

Asset registry quản lý concept/reference, model/rig, texture/material, animation, VFX/shader/particle, UI/icon/font, SFX/voice/music, environment kit, cinematic và source project. Runtime asset và source project là hai artifact khác nhau nhưng cùng stable Asset ID.

## 2. Manifest bắt buộc

Mỗi asset ghi:

- Asset ID, content/feature owner, type/family và player purpose;
- brief, art/audio direction, source project và export target;
- provenance/license/creator/generation history và originality review;
- Minecraft scale/grid/pivot, rig/material/channel/sample specs;
- camera/locale/accessibility/quality variants;
- LOD, texture/triangle/bone/particle/overdraw/voice/concurrency/memory budgets;
- dependencies, consumers, version/status và replacement/migration rule;
- missing/low-spec/reduced-effects fallback;
- screenshots/clips/listening test và integration acceptance.

File path có thể đổi; Asset ID/reference không đổi. Không tham chiếu asset bằng path rải rác trong gameplay definition nếu registry có thể sở hữu mapping.

## 3. Production flow

```text
Feature/content brief → reference + IP review → silhouette/motif exploration
→ graybox/placeholder → art-direction approval → technical authoring
→ export/validation → gameplay integration → two-camera/environment review
→ optimization + accessibility variants → release manifest
```

Không làm final hero asset trước khi graybox chứng minh mechanic/camera. Không ship placeholder không có status/fallback. Batch production chỉ mở sau một exemplar đi hết pipeline.

## 4. Nguồn tạo asset

Ưu tiên nguồn do dự án tự tạo: concept briefs, sketch/model/texture/animation procedural hoặc thủ công, recording/synthesis, field recording và licensed libraries có quyền thương mại rõ. Public-domain/CC asset chỉ dùng đúng điều khoản và lưu attribution. Asset từ franchise/game tham khảo chỉ để phân tích nguyên lý; không trace, rip, imitate character/skill/audio signature hoặc nhập file.

AI có thể hỗ trợ ideation, mood exploration, concept variants, texture/VFX/audio prototype và cleanup khi tool/license cho phép. Output AI không mặc định là final: phải lưu prompt/tool/model/date/input rights, kiểm IP/similarity, được Art/Audio Director chỉnh thành ngôn ngữ UMBRA, rồi qua technical/performance/in-game QA. Không yêu cầu AI “vẽ giống” franchise hoặc nghệ sĩ sống.

## 5. Scale và packaging

Asset chia first-party packs theo capability/content family nhưng được phát hành như UMBRA thống nhất. Pack khai `provides/requires/optional/conflicts`, content/schema/resource version và budget tier. Lazy loading/streaming chỉ áp dụng khi profiling chứng minh; không dùng pack boundary để che dependency vòng.

VFX/SFX có global budget arbitration: priority, maximum concurrent emitters/voices, distance/occlusion, degradation order và deterministic gameplay cue. Một skill hoành tráng không được chiếm toàn bộ frame/audio mix khi squad đông hoặc môi trường đang biến đổi.

## 6. Acceptance views

Mỗi asset player-visible được review ở first-person, default third-person, close/medium/far distance, day/night/interior, UI overlay, reduced effects và stress scene. Enemy/skill telegraph phải nhận ra không cần color duy nhất; audio cue kiểm trên speaker/headphone và mix combat đông.
