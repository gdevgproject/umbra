# RES-INPUT-MC-26-2 — Vanilla key baseline

> **Owner:** UX/Input + Compatibility QA
> **Observed:** Minecraft Java 26.2, official client artifact, 2026-07-18
> **Status:** `VALIDATION`

## 1. Evidence

Official 26.2 client was resolved through Mojang version metadata and audited from `net.minecraft.client.Options` plus `assets/minecraft/lang/en_us.json`.

- client SHA-1: `2dc72797acbc1b63fc16a11c4ac393605f453754`
- official release note: [Minecraft Java Edition 26.2](https://www.minecraft.net/en-us/article/minecraft-java-edition-26-2)
- Fabric key mapping behavior: [Key Mappings](https://docs.fabricmc.net/develop/key-mappings)

“Free” below means no configurable standalone vanilla mapping in this exact artifact/default US-layout interpretation. Nó không nghĩa an toàn ở UI, OS, layout khác, mod khác hoặc version sau.

## 2. Toàn bộ 61 configurable mappings

| Category | Actions và default |
|---|---|
| Movement (7) | Forward `W`; Left `A`; Back `S`; Right `D`; Jump `Space`; Sneak `Left Shift`; Sprint `Left Ctrl` |
| Inventory (12) | Inventory `E`; Offhand `F`; Drop `Q`; Hotbar `1`–`9` |
| Gameplay (3) | Use/Place `Mouse 2`; Attack/Destroy `Mouse 1`; Pick Block `Mouse 3` |
| Multiplayer (5) | Chat `T`; Player List `Tab`; Command `/`; Friends `O`; Social Interactions `P` |
| Misc (8) | Screenshot `F2`; Perspective `F5`; Cinematic Camera `Unbound`; Fullscreen `F11`; Advancements `L`; Quick Actions `G`; Toggle GUI `F1`; Spectator Shader `F4` |
| Creative (2) | Save Hotbar Activator `C`; Load Hotbar Activator `X`—dùng cùng hotbar slot trong creative workflow |
| Spectator (2) | Highlight Players `Unbound`; Select on Hotbar `Mouse 3` |
| Debug base (2) | Debug Overlay `F3`; Debug Modifier `F3` |
| Debug chords (20) | `F3+C` Crash; `F3+A` Reload Chunks; `F3+B` Hitboxes; `F3+D` Clear Chat; `F3+G` Chunk Boundaries; `F3+H` Advanced Tooltips; `F3+I` Copy Data; `F3+N` Cycle Spectator; `F3+F4` Game Mode; `F3+F6` Debug Options; `F3+P` Lost-focus Pause; `F3+S` Dump Dynamic Textures; `F3+T` Reload Resources; `F3+L` Profiling; `F3+C` Copy Location; `F3+V` Version Info; `F3+1` Profiling Chart; `F3+2` FPS Charts; `F3+3` Network Charts; `F3+4` Lightmap |

`F3+C` có hai hành vi theo duration/context; đây không phải lỗi đếm. Ngoài mapping table còn có input UI/hard-coded như `Esc`, `Enter`, arrow navigation, scroll wheel, text entry và debug help; chúng vẫn được coi là reserved dù một bảng “keybind” có thể không hiển thị.

## 3. Các key còn lại trên ANSI 104-key/US

### Chưa có standalone mapping và có thể đưa vào ergonomic study

- letters: `B H I J K M N R U V Y Z`;
- number row: `0`;
- punctuation: `` ` - = [ ] \ ; ' , . ``;
- function: `F6 F7 F8 F9 F10 F12`;
- navigation/numpad: `Insert Delete Home End Page Up Page Down`, numpad `0–9`, decimal/divide/multiply/subtract/add/enter;
- modifiers/device-dependent: `Left/Right Alt`, `Right Shift`, `Right Ctrl`, `Caps Lock`, `Num Lock`, `Scroll Lock`, `Menu`, mouse buttons `4+`.

Đây là toàn bộ nhóm chưa có **standalone configurable default** trong phạm vi bàn phím ANSI tiêu chuẩn nêu trên sau khi loại nhóm đã dùng ở mục 2. Nó vẫn không phải danh sách “an toàn mặc định”.

### Không có mapping hoặc có vẻ trống nhưng phải coi là reserved/risky

- `Esc`, `Enter`, `Backspace`, arrow keys và navigation keys tham gia screen/text/focus behavior;
- mouse wheel dùng hotbar, scrolling và zoom/context UI;
- `F3` chords giữ `A B C D G H I L N P S T V 1–4 F4 F6`; standalone có thể khác nhưng conflict/debug discoverability vẫn phải báo;
- `C/X` đã là Creative hotbar activators dù thường không tạo hành vi khi bấm riêng;
- `Alt`, `Super/Windows`, lock keys, Print Screen/Pause và IME/layout keys có OS/stateful behavior;
- numpad/right modifiers/extra mouse buttons không tồn tại hoặc không dễ với mọi thiết bị.

Vì hard-coded UI/OS behavior không nằm hết trong `Options.keyMappings`, runtime audit phải test screen/game contexts chứ không chỉ diff registry. Fabric lưu ý mã GLFW được gọi theo US layout; ký tự vật lý trên AZERTY/QWERTZ có thể khác.

## 4. Upgrade rule

Mỗi Minecraft baseline mới phải chạy lại registry audit, diff `added/removed/default-changed/context-changed`, cập nhật conflict tests và chỉ sau đó mới duyệt default UMBRA. Không dùng file này làm chân lý cho 26.3+.
