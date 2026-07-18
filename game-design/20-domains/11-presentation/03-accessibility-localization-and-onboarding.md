# SYS-ACCESS — Accessibility, localization và học game

> **DRI:** Accessibility Designer + Localization Lead
> **Status:** `DISCOVERY`

## Accessibility baseline

Cue quan trọng có ít nhất hai kênh khi khả thi: visual/audio/haptic-textual. Settings dự kiến gồm remap, toggle/hold, timing assist có giới hạn, camera shake/motion, FOV/sensitivity, subtitle/caption, color-independent markers, UI scale/contrast và combat readability. Assist không bị chế nhạo hoặc khóa progression.

## Localization runtime decision

UMBRA mặc định **theo locale đang chọn trong Minecraft**; không tạo setting ngôn ngữ mod riêng ở baseline. Asset index Mojang 26.2 đã xác minh locale tiếng Việt là `vi_vn`; khi Minecraft dùng locale này UMBRA dùng tiếng Việt, còn `en_us` dùng tiếng Anh. Locale khác dùng fallback `en_us` cho tới khi có pack tương ứng. Đổi language qua Minecraft Options phải cập nhật UMBRA trong cùng resource-reload lifecycle, không cần restart world hoặc đổi save.

Tiếng Việt và tiếng Anh luôn là hai locale bắt buộc từ capability đầu tiên có player-facing text. Mọi text dùng translatable component/stable key; logical server gửi key + typed arguments, không render sẵn câu tiếng Anh. Full contract nằm tại [Player Communication](../../30-shared-contracts/04-localization-accessibility-and-terminology.md).

Không có bản dịch không được biến thành string key thô trong release; CI kiểm key parity, placeholder type/order, JSON, glyph coverage và overflow ở screen trọng yếu.

## Onboarding

Progressive disclosure theo loop: vanilla coexistence → embodiment/camera → combat beat → dodge/defense → activity/Gate → progression → Arise → command. Training quest dạy bằng tình huống rồi cho thử lại; tooltip không thay practice. Mỗi mechanic có recall help trong codex/settings.
