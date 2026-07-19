# GOV-WORKSTATION — Workstation và toolchain readiness

> **DRI:** Technical Director
> **Approver:** Project Owner
> **Reviewers:** Technical Artist, Data/Tools Engineer, Audio Producer, Build/Release Engineer, QA Lead
> **Status:** `APPROVED_FOR_DOCUMENTATION`
> **Machine baseline:** `WORKSTATION_BASELINE_READY` — 2026-07-19

## 1. Contract cho Agent

Đây là canonical entry point để Agent chọn công cụ authoring/automation cho UMBRA. Nó hỗ trợ [CNT-ASSET-PIPELINE](../40-content/06-asset-production-and-registry.md), [GOV-ENGINEERING](06-engineering-and-git-workflow.md) và [QLT-AUTOMATION-BOUNDARY](../60-quality/09-automation-boundaries-and-escalation.md).

Baseline máy đã được audit và không còn thiếu standard tool. Agent **không inventory/cài lại/launch thử toàn bộ app ở mỗi task**. Chỉ chạy checker khi có trigger ở §4; sau đó dùng `Path` được trả về nếu sandbox không thấy user `PATH`.

```powershell
powershell -ExecutionPolicy Bypass -File tools/check-workstation.ps1
```

`WORKSTATION_BASELINE_READY` chỉ chứng minh tool được cài và lane kỹ thuật đã biết. Nó không thay Feature gate, project build, asset acceptance hay human art/audio review.

## 2. Router công cụ đã biết tốt

| Công việc | Dùng trước | Cách Agent dùng | Lưu ý bắt buộc |
|---|---|---|---|
| Java/Fabric build, test | JDK + Gradle Wrapper | `gradlew`/`gradlew.bat`; CLI là oracle | không cài global Gradle; JDK chỉ green cho runtime sau DB-019 pin baseline |
| Java debug/index | IntelliJ IDEA + Minecraft Development plugin | GUI khi cần debugger/run configuration; code/test thường vẫn qua CLI | IntelliJ không phải dependency để Codex sửa code |
| Python helper/validator | `uv`, rồi project-pinned Python | `uv run ...`; trước khi repo pin có thể dùng Codex bundled Python | không dựa vào global site-packages |
| JSON/tool helper | Node.js | `node`; trên PowerShell dùng `npm.cmd` nếu `npm.ps1` bị policy chặn | package/version phải được repo pin khi trở thành build dependency |
| Minecraft model/rig/keyframe | Blockbench | GUI + `.bbmodel`/plugin/file automation | không giả định stable headless exporter; first feature cần round-trip fixture |
| Rig/mesh/render nâng cao | Blender | `blender --background --python <script>` | `bpy` thuộc Python nhúng của Blender; script tải ngoài không được auto-run |
| Texture/raster batch | ImageMagick | `magick`/`identify`; Krita cho authoring bằng mắt | golden fixture cho transform được đưa vào production |
| Vector/UI/icon batch | Inkscape | dùng **`inkscape.com`** cho CLI/export; `inkscape.exe` cho GUI | Windows `.exe` không trả CLI/exit code ổn định như `.com` |
| Audio/video batch | FFmpeg/FFprobe | `ffmpeg` convert/generate, `ffprobe` validate | Audacity cho edit/listening; CLI không tự kết luận mix hay cảm xúc |
| Capture/playtest | OBS Studio | GUI capture theo Test Card | screenshot/video không thay human-only question |
| Binary asset history | Git LFS | chỉ dùng sau khi repo policy khai pattern | không tự chạy `git lfs track/migrate` hoặc đưa binary vào Git |

Nếu lệnh tên ngắn không resolve trong sandbox nhưng checker trả `Detected=True`, dùng absolute `Path`; **không cài lại**. GeckoLib/animation runtime, Fabric/NeoForge và Gradle là project dependency, không phải desktop app.

## 3. Baseline đã xác minh

| Capability | Version / evidence | Trạng thái |
|---|---|---|
| Git / Git LFS | Git `2.52.0.windows.1`; Git LFS `3.7.1` | ready |
| JDK/Javac | Oracle JDK `25.0.3` | installed; runtime compatibility conditional tới DB-019 |
| Node/npm | Node `24.14.0`; npm `11.9.0` qua `npm.cmd` | ready |
| Python/uv | Codex Python `3.12.13`; uv `0.11.29` | ready cho Agent tooling; project Python chưa pin |
| Blockbench | `5.1.5`; Windows launch verified | ready để author; feature-specific round-trip còn theo §5 |
| Blender | `5.2.0 LTS`; background Python smoke xanh | automation ready |
| Krita | `5.3.2.1` | authoring ready |
| ImageMagick | `7.1.2-27 Q16-HDRI`; PNG generate/identify smoke xanh | automation ready |
| Inkscape | `1.4.4`; `inkscape.com` SVG→PNG và `identify` smoke xanh | automation ready |
| FFmpeg/FFprobe | `8.1.2 essentials`; verified release digest; WAV generate/probe smoke xanh | automation ready |
| Audacity | `3.7.8` qua MuseHub; standalone executable detected | authoring ready; listening/macro proof theo feature |
| IntelliJ | `2026.2`; Minecraft Development plugin present | debug/index ready |
| OBS Studio | `32.1.1` | capture ready; scenario proof theo Test Card |
| GPU | NVIDIA RTX 3050, 6 GiB VRAM | đủ cho authoring hiện tại; không phải performance baseline của game |

REAPER là optional paid DAW, không thuộc standard baseline và không được coi là thiếu. System `python`/`py` không cần tồn tại trên `PATH` khi `uv` hoặc exact bundled interpreter đáp ứng task.

## 4. Khi nào mới re-audit

Chỉ chạy checker/smoke lại khi có ít nhất một trigger:

- checker/path báo missing hoặc executable không chạy;
- app/JDK/driver/Codex runtime vừa đổi version hoặc máy/workspace đổi;
- first use của một export format/plugin/codec chưa có fixture;
- DB-019 pin toolchain hoặc ticket yêu cầu release/CI reproducibility;
- output, color/audio metadata, exit code hoặc performance khác baseline.

Không có trigger thì dùng baseline §3. Không browse “latest tool” và không update chỉ vì có version mới trong một task asset/gameplay không liên quan.

## 5. Checklist first-use theo capability

- [ ] Chọn tool/lane từ §2; dùng checker path nếu command không resolve.
- [ ] Source fixture nhỏ tạo → lưu → mở lại → export; validator đọc output độc lập.
- [ ] Blockbench fixture giữ scale/grid/pivot/bone/keyframe/event; texture giữ size/alpha/color space.
- [ ] Blender/Inkscape/ImageMagick/FFmpeg automation trả exit code hữu ích và output deterministic trong tolerance.
- [ ] Asset player-visible đi qua first/third-person, distance, lighting, reduced-effects và stress views của `CNT-ASSET-PIPELINE`.
- [ ] Mắt/tai/feel chỉ kết luận bằng một Test Card tiếng Việt sau automated proof; UI click sequence không là oracle duy nhất.
- [ ] Ghi tool/version, exact command, source/export Asset ID và evidence vào ticket/asset manifest—không sửa bảng baseline cho mỗi asset.

## 6. Safety và ownership

- Không commit absolute user path, installer, cache, license key, token hoặc generated temp file. Checker được phép discover path cục bộ.
- Chỉ chạy script/plugin do repo sở hữu hoặc source đã review; Blender auto-run cho file tải ngoài giữ tắt.
- Tool cài sẵn không tự trở thành dependency. Version/schema/runtime được owner Feature/Platform/Build pin tại canonical home tương ứng.
- Git LFS pattern/migration, IDE setting toàn cục, PATH và cài/gỡ app là workstation mutation; chỉ thực hiện trong task setup được Project Owner cho phép.

## 7. Nguồn kỹ thuật

- [Blockbench API/file operations](https://www.blockbench.net/wiki/docs/blockbench/) và [export formats](https://www.blockbench.net/wiki/guides/export-formats/)
- [Blender command line](https://docs.blender.org/manual/en/latest/advanced/command_line/arguments.html) và [scripting security](https://docs.blender.org/manual/en/latest/advanced/scripting/security.html)
- [Audacity Macros](https://support.audacityteam.org/audio-editing/macros/manage-macros)
- [FFmpeg downloads](https://ffmpeg.org/download.html), [Inkscape CLI](https://inkscape.org/doc/inkscape-man.html), [uv Python management](https://docs.astral.sh/uv/guides/install-python/)
