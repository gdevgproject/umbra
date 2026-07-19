# SYS-SAVE-PORTABILITY — Save ownership, backup và transfer

> **DRI:** Data Architect + Release/Support Engineer
> **Reviewers:** Security, QA, Every persistent domain
> **Status:** `PROPOSED`

## 1. Player promise

World UMBRA thuộc về người chơi. Copy đúng world/backup sang ổ khác hoặc máy khác phải mang theo toàn bộ progression, Shadow identity, quest, Gate, items và world consequences; mất config giao diện không được làm mất game state.

Minecraft Java đã có flow mở thư mục backup và backup có thể chuyển sang external drive/máy khác. UMBRA tương thích flow đó thay vì tạo save silo. [Minecraft Help — locating backups](https://help.minecraft.net/hc/en-us/articles/4409159214605-Locating-Minecraft-Java-Edition-Files-for-Backup-or-Transfer)

## 2. Ownership boundary

| Data | Owner/location policy |
|---|---|
| World/progression/quest/Shadow/economy identity | trong world save, logical server sở hữu |
| Per-player state | player data gắn world/UUID với offline/online migration policy rõ |
| Keybind/camera/UI/accessibility preferences | client config; export tùy chọn, không gameplay truth |
| Content definitions | mod/datapack; save giữ ID/version/reference, không duplicate toàn definition |
| Cache/index/render data | rebuild được; loại khỏi backup nếu an toàn |
| Secrets/account/server credentials | không nằm trong world backup |

## 3. Safe write và recovery

- Dùng Minecraft save lifecycle; commit state theo owner, idempotent và crash-aware.
- Không sửa nhiều truth copies. Derived index có thể rebuild từ authoritative records.
- Trước schema/content migration tạo world backup/copy có manifest và kiểm dung lượng/quyền ghi.
- Migration failure không mở world ở trạng thái half-applied; giữ original, report reason và recovery action.
- Missing/corrupt definition dùng placeholder/quarantine khi an toàn; không xóa object rồi save đè.
- Autosave/quit/crash/chunk unload/dimension/death đều có matrix và fault-injection test.

## 4. Backup bundle

Một backup được hỗ trợ gồm full world directory và manifest đọc được chứa: world ID/name, timestamp, Minecraft/UMBRA/loader/API versions, schema/content versions, enabled first-party packs/capabilities, checksum/size, migration source và known warnings. Preferences export là bundle riêng tùy chọn.

Không gọi backup “thành công” nếu chưa thử restore vào đường dẫn sạch và load–save–quit lại. Rotation mặc định giữ nhiều generation; không xóa backup duy nhất để tiết kiệm chỗ mà không hỏi.

## 5. Transfer workflow

```text
close world cleanly → create/verify backup → copy archive to USB/drive
→ verify checksum → install declared compatible UMBRA baseline
→ restore as a copy → preflight manifest → load/migrate → smoke test
```

Không mở save 26.2 bằng baseline cũ. Khi chuyển máy, đường dẫn tuyệt đối, username hệ điều hành và cache GPU không được nằm trong persistent references. UUID/player ownership mismatch phải có support flow rõ, không tự chuyển tài sản cho người khác.

Mỗi Minecraft successor phải chứng minh upgrade từ **final supported release gần nhất của previous line** bằng restore-as-copy; không hứa migrate trực tiếp từ mọi snapshot hoặc mọi build dev lịch sử. Release notes ghi exact `migration-from` matrix và chuỗi intermediate bắt buộc nếu có. Sau khi một copy đã save bằng successor, không mở ngược bằng dòng EOL; final artifact cũ được giữ để đọc/backup/export world cũ, không phải để downgrade world mới.

Chuyển Fabric ↔ NeoForge là một migration matrix riêng, không phải copy tùy ý. Chỉ support khi exact Minecraft/schema/content pair đã có cross-loader fixture; luôn restore-as-copy. Canonical state không serialize loader handle/class/runtime registry ordinal; quy tắc chi tiết do `SYS-LOADER-PORTABILITY` sở hữu.

## 6. Player-facing tools dự kiến

- `Backup before update` prompt và “Open Backup Folder”.
- `Export diagnostics/manifest` không chứa save hoặc dữ liệu riêng tư mặc định.
- Preflight screen: compatible / migration required / missing content / unsupported downgrade.
- Restore-as-copy mặc định; overwrite cần confirm rõ và verified backup.
- Support article Việt/Anh cho backup USB/cloud folder thủ công; cloud sync không phải foundation promise.
