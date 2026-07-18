# CTR-PLAYER-COMMUNICATION — Thuật ngữ, localization và accessibility

> **DRI:** Localization Lead + Accessibility Designer
> **Status:** `PROPOSED`

## Locale contract

- `en_us` là source/fallback locale kỹ thuật; `vi_vn` là locale đồng hạng bắt buộc.
- UMBRA đọc locale hiện hành của Minecraft và tham gia resource reload; không lưu language override trong world/player state.
- Unsupported locale fallback về `en_us`; resource pack dịch ngoài có thể bổ sung cùng stable keys.
- Server/gameplay state chứa meaning/IDs/arguments, không chứa câu đã render theo ngôn ngữ client.

String key ổn định theo meaning, không theo câu tiếng Anh, ví dụ `umbra.action.dodge` và `umbra.quest.state.suspended`. Entry có source locale, context, speaker/tone, variables/types, plural policy, max-space hint và fallback. Thuật ngữ gameplay dùng [Canonical Glossary](../10-direction/06-canonical-glossary.md); rank/state/resource không được dịch tự phát giữa file.

Không ghép câu từ fragment, không nối plural bằng code và không dùng literal player-facing text trừ user content/debug. Placeholder dùng vị trí/type rõ để tiếng Việt/Anh đảo trật tự an toàn. Font/UI phải phủ dấu tiếng Việt, combining behavior và line breaking.

## Quality gate

Static check yêu cầu key parity Việt/Anh, không orphan/missing/duplicate key, placeholder tương thích và file JSON hợp lệ. Client tests đổi locale trong runtime, mở lại screen/HUD/tooltip/subtitle/keybind category, chụp baseline ở GUI scale nhỏ/lớn và kiểm fallback. Linguistic QA kiểm meaning, tone, terminology, clipping và context—not chỉ chính tả.

Thông tin ảnh hưởng quyết định phải có cue redundancy và bản text/codex khi phù hợp. Color không là kênh duy nhất. Reduced motion, UI scale, remap/toggle và subtitle context được xét từ discovery, không thêm sau content complete.
