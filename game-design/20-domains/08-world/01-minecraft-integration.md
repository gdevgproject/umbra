# SYS-WORLD-INTEGRATION — Tích hợp Minecraft

> **DRI:** World Designer + Technical Designer
> **Status:** `DISCOVERY`

Mỗi hệ UMBRA phải khai báo quan hệ với mining, building, biome/structure, village, mob, Nether, End, death, inventory và server lifecycle. Ba mode hợp lệ: coexist, extend hoặc override có context rõ.

Gate placement tránh vùng bảo vệ/công trình theo policy cấu hình; dungeon instance không thay đổi terrain tùy tiện. Reward phải quay lại hỗ trợ exploration/building/home ít nhất ở một lớp, tránh loop đóng kín chỉ nuôi Gate tiếp theo.

Vanilla combat coexistence cần combat context. Người chơi không vào stance vẫn tương tác dự đoán được; mob/gear vanilla có adapter/fallback thay vì vỡ schema.
