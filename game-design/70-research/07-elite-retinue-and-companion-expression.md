# RES-RETINUE-EXPRESSION — Quy mô đội nhỏ và biểu cảm đồng đội

> **Researcher:** Systems Research + AI Research
> **Date observed:** 2026-07-19
> **Decision supported:** `PD-031`, `CTR-SHADOW-RETINUE`, `DB-044`, `DB-045`
> **Status:** `EVIDENCE_SEED`

## Question

UMBRA nên tách giới hạn bonded roster và active combat ở đâu để vừa có collection/rotation dài hạn, vừa giữ từng cá thể sâu, đội hình đọc được và AI phối hợp tốt; quỳ/cúi/biểu cảm nên vận hành thế nào để tạo attachment mà không spam hoặc cắt gameplay?

## Evidence và observations

### A. Bốn AI companion trong một combat party

- **Nguồn/context:** GDC 2022, Eidos Montréal, *Controlled Chaos: The Combat of Marvel's Guardians of the Galaxy*.
- **Quan sát:** talk mô tả một single-player party có bốn AI companion, nhiều enemy archetype, threat management, combat acting và contextual barks; mục tiêu là cảm giác “đang sống cùng” nhóm đồng đội, đồng thời thừa nhận combat dễ trở nên hỗn loạn.
- **Bằng chứng:** [GDC Vault](https://gdcvault.com/play/1027917/AI-Summit-Controlled-Chaos-The)
- **Giới hạn:** cấu trúc party, camera, IP, moveset và narrative của nguồn không giống Minecraft/UMBRA; con số bốn không tự động là quy luật phổ quát.

### B. Một companion phải hữu ích nhưng không làm lu mờ player

- **Nguồn/context:** GDC 2019, Santa Monica Studio, *Raising Atreus for Battle in God of War*.
- **Quan sát:** decision question của đội ngũ là làm companion quan trọng trong gameplay mà vẫn giữ combat identity của nhân vật chính.
- **Bằng chứng:** [GDC Vault](https://www.gdcvault.com/play/1025768/Raising-Atreus-for-Battle-in)
- **Giới hạn:** một companion authored sâu không chứng minh bốn companion dễ làm; nguồn hữu ích cho quan hệ `Self ↔ ally power`, không cho cap roster.

### C. Hành vi thư giãn dễ lộ lỗi và vẫn phải có budget

- **Nguồn/context:** GDC 2015, Ubisoft Montréal/Avalanche Studios, *Remember to Relax!*
- **Quan sát:** ambient behavior chậm, dễ nhìn và dễ lộ inconsistency hơn combat; talk đặt bài toán tích hợp hành vi cá nhân/nhóm vào gameplay trong production/memory budget.
- **Bằng chứng:** [GDC Vault](https://www.gdcvault.com/play/1022231/Remember-to-Relax-Realizing-Relaxed)
- **Giới hạn:** talk không quy định UMBRA phải dùng emotion model hay animation cụ thể.

### D. Emotion cần personality, relationship và debug—not chỉ emote clip

- **Nguồn/context:** GDC 2021, Square Enix Advanced Technology Division, *Driving Emotionally Expressive NPC Animations and Behaviors*.
- **Quan sát:** prototype tách emotion, mood, personality và liking/disliking; trạng thái cảm xúc ảnh hưởng cả animation lẫn decision, với designer control và debug tools.
- **Bằng chứng:** [GDC Vault](https://www.gdcvault.com/play/1027102/AI-Summit-Driving-Emotionally-Expressive)
- **Giới hạn:** UMBRA không cần mô phỏng tâm lý đầy đủ; chỉ state tạo khác biệt nhìn thấy mới đáng lưu.

### E. Contextual interaction cần reservation

- **Nguồn/context:** Epic Unreal Engine Smart Objects documentation, truy cập 2026-07-19.
- **Quan sát:** interaction slot được reserve để hai agent không chiếm cùng activity; behavior kết thúc/cắt phải nhả slot đúng lifecycle.
- **Bằng chứng:** [Epic Smart Objects Quick Start](https://dev.epicgames.com/documentation/unreal-engine/smart-objects-in-unreal-engine---quick-start)
- **Giới hạn:** UMBRA không dùng/chép Unreal Smart Object implementation; chỉ học nguyên lý reservation, tags và lifecycle.

### F. Where Winds Meet “tối đa bốn”

- **Nguồn/context:** user-observed reference lead; official material tìm được trong lượt này chưa chứng minh rõ mechanic “bốn nhân vật điều khiển đồng thời”.
- **Quan sát:** chưa đủ evidence để ghi thành fact.
- **Cách dùng:** giữ làm lens cho cảm giác party gọn; quyết định UMBRA dựa trên topology, readability và relationship cost của chính UMBRA, không dựa một con số chưa kiểm chứng.

## Synthesis: observation → principle → UMBRA choice

| Observation | Nguyên lý chuyển được | Lựa chọn UMBRA | Bằng chứng phải có |
|---|---|---|---|
| Bốn companion đã đủ tạo controlled chaos | thêm member tăng target, path, voice, VFX và cognitive coordination không tuyến tính | active combat cap 4 | command/readability/perf playtest 1/2/4 |
| Một companion có nguy cơ làm lu mờ protagonist | companion power phải có vai trò, cap và player agency | mọi reserve ngoài bốn active không đóng góp combat power | Self/Retinue balance simulation |
| Ambient behavior lộ lỗi rõ | social expression cần context, interruption và production budget | expression semantic + priority + fallback | repeated-event/interrupt/soak tests |
| Emotion không chỉ là animation | personality/relationship phải thay semantic hoặc intensity có quan sát | quỳ/cúi theo identity; không universal clip | recognition/attachment playtest |
| Interaction cần reservation | nhóm phải phối hợp attention, voice và vị trí | Retinue Expression Coordinator | simultaneous-event/slot tests |

## UMBRA decision/hypothesis

- **Đã khóa ở Product/ADR-0002:** roster tối đa tám; active combat tối đa bốn; slot 5–8 là chiều rộng dự bị/home/rotation, không tăng actor/power trận hiện tại.
- **Lý do:** active four giữ combat composition/command trong một nhóm nhỏ; tám bonded giảm áp lực full-roster sớm và mở role counter-pick, identity collection, home presence. Tám member tạo tới 28 cặp toán học nên relationship phải sparse/event-driven, không author mọi cặp.
- **Hypothesis cần prototype:** `UNRESOLVED_CLAIM` cap một bảo vệ rare capture khi roster đầy mà không tạo kho quân đoàn; slot 2–8 mở qua capability/mastery milestones có cadence; roster UI/rotation không thành chore; expression coordinator dùng group reservation/LOD để tám member không phản ứng đồng loạt.

## IP/originality guardrail

Không tái sử dụng tên nhóm/nhân vật, dialogue, animation quỳ/cúi, UI party, camera staging, skill, formation, combat bark, silhouette, VFX/SFX hoặc narrative beat của reference. UMBRA tự tạo semantic vocabulary, body variants, lore kết ước, slot progression, full-roster consequence và command grammar.

## Evidence quality

- **Confidence:** cao cho nguyên lý bounded active party, reservation/context và anti-spam; cap `8/4` là Product decision nhưng mức dễ dùng/attachment/production cost vẫn chỉ có evidence seed tới prototype UMBRA.
- **Missing comparison:** Minecraft first/third-person room, beast/flying Shadow topology, home scene tám member qua LOD/staging, roster rotation, full-roster rare boss scenario.
- **Staleness risk:** thấp cho GDC principles; cao cho chi tiết live-service/reference UI. Where Winds Meet cap vẫn là unverified user observation.
