# SYS-WORLD-INTEGRATION — Tích hợp Minecraft

> **DRI:** World Designer + Technical Designer
> **Status:** `DISCOVERY`

Mỗi hệ UMBRA phải khai báo quan hệ với mining, building, biome/structure, village, mob, Nether, End, death, inventory và server lifecycle. Ba mode hợp lệ: coexist, extend hoặc override có context rõ.

Gate placement tránh vùng bảo vệ/công trình theo policy cấu hình; dungeon instance không thay đổi terrain tùy tiện. Reward phải quay lại hỗ trợ exploration/building/home ít nhất ở một lớp, tránh loop đóng kín chỉ nuôi Gate tiếp theo.

Vanilla combat coexistence cần combat context. Người chơi không vào stance vẫn tương tác dự đoán được; mob/gear vanilla có adapter/fallback thay vì vỡ schema.

## Vertical traversal

Free Climb biến solid voxel face thành route candidate; climbability dùng surface profile/tag + collision shape, không hard-code exception rải. Ladder, vine, scaffolding, water elevator, bridge và player-built route giữ lợi ích vì an toàn, không mặc định tiêu Vigor, vận chuyển companion/mob/item và hoạt động trước unlock.

Gate/structure/quest sau unlock không dùng một bức tường cao như hard lock duy nhất. Boundary thật cần fiction/geometry/ruleset có cue và sequence-break audit; không vá bằng invisible wall tùy tiện. Mining/placing bị tạm khóa khi cling baseline nhưng luôn có deliberate detach. Canonical movement/resource/fall contract tại [`CTR-TRAVERSAL`](../../30-shared-contracts/09-traversal-state-surface-and-vigor-contract.md).
