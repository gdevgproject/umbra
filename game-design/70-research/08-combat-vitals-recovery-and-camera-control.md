# RES-VITALS-CAMERA — Combat vitals, quick recovery và camera controls

> **Decision Questions:** `DB-046`, `DB-047`, `DB-048`
> **Owner:** Combat Systems Research + Camera/UX
> **Status:** `EVIDENCE_SEED`
> **Baseline checked:** nguồn truy cập ngày 2026-07-19; exact Minecraft/Fabric 26.2 runtime vẫn cần capture khi `DB-019` pin build

## 1. Quan sát có nguồn

| Quan sát | Bằng chứng | Giới hạn |
|---|---|---|
| Minecraft biểu diễn base player health bằng 10 tim/20 health point và có nhiều nguồn mất máu ngoài combat; hunger cao có liên hệ hồi phục. | [Minecraft — Health](https://www.minecraft.net/en-us/article/health-minecraft) | bài giải thích player-facing, không phải API contract cho mọi edge case |
| Fabric expose entity attributes như max health; custom damage type/tags và server-side damage path cho phép giữ source semantics thay vì thay health bằng hệ song song. | [Fabric Entity Attributes](https://docs.fabricmc.net/develop/entities/attributes), [Fabric Damage Types](https://docs.fabricmc.net/develop/entities/damage-types) | API/version phải pin lại với baseline 26.2 |
| Fabric HUD API ghép các HUD element theo layer, phù hợp một presentation fixed-width riêng mà không làm client sở hữu gameplay truth. | [Fabric HUD Rendering](https://docs.fabricmc.net/develop/rendering/hud) | cần adapter/fallback và profile render thực tế |
| Food có use duration/properties; potion là item/effect path riêng. Một quick recovery action không nên âm thầm đổi mọi consumable vanilla. | [Fabric Food](https://docs.fabricmc.net/develop/items/food), [Fabric Potions](https://docs.fabricmc.net/develop/items/potions) | chưa chứng minh cadence tốt cho UMBRA combat |
| Minecraft client/server networking yêu cầu server validate payload; kể cả integrated play vẫn có logical server. | [Fabric Networking](https://docs.fabricmc.net/develop/networking) | không tự giải quyết prediction/feel |
| Action-game HUD chính thức của Monster Hunter Rise tách Health/Stamina và item bar; evade/dash dùng stamina, potion là item hồi health. | [Capcom MH Rise — Game Screen](https://game.capcom.com/manual/MHRISE/en/switch/page/4/1), [Capcom MH Rise — Items](https://game.capcom.com/manual/MHRISE/en/switch/page/7/1) | đây là comparison principle, không phải blueprint; UMBRA không dùng shared traversal stamina |
| Camera control phải xác định reference frame; đổi đột ngột giữa camera-relative và character-relative có thể đảo/đổi ý nghĩa input. | [GDC — Fundamentals of Real-Time Camera Design](https://media.gdcvault.com/gdc05/slides/GD_Haigh-Hutchinson_FundamentalsReal-TimeCameraDesign2.pdf) | tài liệu cũ nhưng nguyên lý reference frame vẫn cần prototype với Minecraft |

Genshin Impact được người dùng đưa làm reference cho thanh né/hồi nhanh, healing và cảm giác góc ba. Lượt research này **chưa có capture trực tiếp từ một build được pin hoặc tài liệu chính thức đủ chi tiết**, nên không ghi ký ức về số charge, stamina hoặc auto-switch camera thành sự thật.

## 2. Nguyên lý chưng cất

1. **Presentation có thể thay mạnh mà không cần nhân đôi state:** fixed-width bar là projection; health/death/save vẫn có một authoritative substrate.
2. **Hazard là một taxonomy, không là phần dư:** fall, fire, lava, oxygen, hunger, status và void cần profile/attribution/test riêng để stat growth không phá survival.
3. **Mỗi resource cần một quyết định riêng:** Mana là power allocation; Focus là short-horizon defensive rhythm; Hunger là survival; Fatigue là long-horizon pressure.
4. **Quick không đồng nghĩa instant/free:** dedicated one-press heal vẫn cần startup/commit/recovery, charge transaction và interrupt readability.
5. **Input direction là contract:** `ViewForward`, `MoveBasis`, `AimIntent` và `ActorFacing` tách state; đổi mode phải giữ ý định world-space của held input.
6. **Third-person ranged cần giải parallax:** ép first-person chỉ né bài toán, không đạt fantasy camera cốt lõi.

## 3. Lựa chọn UMBRA hiện tại

- Giữ `LivingEntity` health/`MAX_HEALTH` và damage source/tag làm substrate tương thích; UMBRA sở hữu semantic pipeline, formula/mapping và fixed-width HUD. Không có parallel RPG HP.
- Mana và Focus custom server-authoritative; Focus hồi nhanh cho Dodge/parry/burst phòng thủ, không drain do locomotion thường.
- Combat Flask dùng một dedicated slot/action, vessel + charge count. Khởi đầu một charge là direction; max 10 chỉ là hypothesis cho `DB-047`.
- Third-person exploration/combat tự do dùng camera-relative horizontal movement và actor quay theo movement/action; lock-on và precision aim dùng basis tường minh khác.
- Ranged không mặc định ép first-person. Shoulder aim là capability core; first-person là manual/context suggestion/allowed-auto setting sau evidence.

## 4. Bằng chứng còn thiếu

- capture exact Minecraft 26.2 health/damage/key/F5/movement/aim/food/potion behavior trên pinned build;
- environmental magnitude simulation ở nhiều Max HP/difficulty/mode;
- HUD wireframe/screenshot cho Health/Mana/Focus/absorption/flask và dense combat;
- Flask prototype so flat/%/hybrid potency, charge/refill economy, hit/cancel timings;
- camera room trace: orbit ±180°, held input, lock acquire/break, shoulder parallax, first↔third;
- paired human test cho readability, muscle memory, heal risk và motion comfort.

## 5. Rủi ro IP/originality

UMBRA chỉ lấy nguyên lý `fixed meter`, `readable charge`, `commitment heal`, `camera-relative control` và `reference-frame stability`. Không sao chép tên bình, icon, HUD layout, màu, animation uống, moveset, âm thanh, camera curve hoặc exact parameter của game tham khảo. Asset/presentation đi qua Asset Registry và originality review.
