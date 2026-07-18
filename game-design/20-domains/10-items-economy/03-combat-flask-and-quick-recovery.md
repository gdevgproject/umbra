# FEAT-COMBAT-FLASK — Bình Hồi Phục chiến đấu và quick-use

> **DRI:** Combat Designer + Itemization Designer
> **Approver:** Lead Game Designer
> **Reviewers:** Balance, Input, Animation, UI, Economy, Platform, Accessibility, Localization, QA
> **Status:** `DISCOVERY`

## 1. Contract một câu

Khi người chơi bấm action Quick Recovery trong context hợp lệ, nhân vật bắt đầu một hành động uống/hồi phục ngắn có commitment, charge và feedback rõ, giúp họ tự cứu dưới áp lực mà không mở inventory hoặc giữ phím ăn—nhưng vẫn có thể bị địch trừng phạt vì chọn sai thời điểm.

## 2. Topology đề xuất

- Một `Combat Flask` nằm trong **một dedicated Quick Recovery Slot**; HUD hiện icon + charge, không chiếm nhiều hotbar slot.
- Flask là vessel/capability có identity và charge; reagent/refill/upgrade có thể craft, tìm hoặc mua. Không stack nhiều chai giống item thường để lách capacity.
- Bắt đầu một charge và tăng dần là direction từ feedback. `max 10` được giữ như **user hypothesis**, chưa approved; capacity, potency và refill cadence phải cùng qua `DB-047`.
- Capacity, potency và utility là ba trục khác nhau; không tăng cả ba vô hạn. Slot cuối/upgrade cao phải đổi preparation, không biến boss thành attrition miễn phí.
- Baseline có một healing profile. Cleanse/regeneration/team-heal/alternative flask chỉ mở như content/Feature Cell riêng khi không overload một nút.

Food và vanilla potion không tự vào Quick Recovery Slot; quan hệ canonical nằm tại [`CTR-VITALS-HUD`](../../30-shared-contracts/08-vitals-resource-and-hud-contract.md).

## 3. Action lifecycle

```text
AVAILABLE
  --press + eligible + charge reserved--> STARTUP
STARTUP
  --commit marker--> COMMITTED (charge spent + heal event)
COMMITTED
  --recovery end--> AVAILABLE
STARTUP/COMMITTED
  --legal interrupt/cancel--> INTERRUPTED → recovery policy
```

- Một press tạo tối đa một `QuickRecoveryIntent`; key repeat/packet retry không dùng hai charge.
- Charge được reserve khi action accepted, chỉ spend/heal tại commit marker; server reject hoặc cancel hợp lệ trước commit hoàn reservation.
- Sau commit, heal và charge không được rollback chỉ vì animation bị cắt; retry/reload không heal lần hai.
- Không instant zero-frame. Input là một chạm, nhưng nhân vật phải có startup/commit/recovery đủ để enemy pressure có nghĩa.
- Camera vẫn điều khiển được; movement/turn-rate/weapon state trong action cần prototype. Không root player dài nếu không có lý do encounter.

## 4. Interruption và cancel matrix cần khóa

| Tình huống | Direction đề xuất | Rủi ro phải test |
|---|---|---|
| Dodge trước commit | cancel flask, không heal/không mất charge | spam reserve/cancel, animation flicker |
| Dodge sau commit | chỉ late-recovery cancel nếu action data cho phép | biến recovery thành miễn phí |
| Light hit trước commit | theo hit-reaction severity; có thể tiếp tục hoặc interrupt | heal quá an toàn hoặc quá bực |
| Heavy/stagger/grab trước commit | interrupt, hoàn reservation theo marker | enemy chain khiến không bao giờ dùng được |
| Hit sau commit | heal giữ nguyên; reaction theo combat | rollback/desync/double heal |
| Jump/fall/water/ladder/mount | deny hoặc variant explicit | animation/collision exploit |
| Death/dimension/reload | transaction cleanup/idempotency | charge mất/nhân, hồi sinh heal miễn phí |

Exact timings, movement multiplier và hit severity không được khóa trước paired combat prototype. Flask không tự cấp i-frame, cleanse stagger hoặc miễn DoT.

## 5. Healing semantics

- Heal phát event có source/flask instance/action transaction; clamp theo Max HP và overheal policy.
- Candidate potency phải so sánh `flat`, `% Max HP`, `hybrid flat + %` và tiered profile. Không dùng bốn tim cố định khi Max HP tăng, cũng không chọn pure percent làm VIT/attrition vô nghĩa.
- Damage/heal cùng tick có ordering canonical; health bar preview/lag layer phải thể hiện đúng actual commit.
- Flask không dùng Hunger/Saturation và không xóa giá trị food. Refill không mặc nhiên xảy ra khi level-up/death trừ khi activity/death contract ghi explicit.
- Difficulty/activity có thể đổi refill access hoặc consequence, nhưng UI phải preview và không silently consume nhiều charge.

## 6. Acquisition, crafting và economy

- Early vessel được dạy bằng quest/crafting path không miss; first charge không phụ thuộc rare drop.
- Refill sources candidate: rest/home checkpoint, crafted dose, shop/service, Gate supply hoặc loot hiếm. Mỗi source khai cadence, cost, exploit và world-fiction.
- Upgrade capacity/potency cần recipe/service/milestone có preview; không dùng lịch thực, gacha hoặc stock FOMO.
- Crafting/shop không bán raw power vượt progression gate; bulk refill UI giảm chore.
- Creative/debug có grant/refill command và provenance; invalid/missing flask definition fallback không corrupt save.

## 7. Input và HUD

- Stable action candidate: `umbra.action.quick_recovery`; semantics `PRESS`, remappable, conflict/context-aware. Exact default key thuộc Input research.
- HUD luôn cho thấy charge, eligible/cooldown/interrupted/refill-needed; reject reason không spam.
- Khi hết charge, press cho feedback ngắn và không mở inventory tự động.
- Quick slot có compare/equip flow ở safe UI; không cycle qua mọi đồ ăn bằng combat key.
- `vi_vn/en_us`, reduced motion, subtitle/audio cue, one-handed alternative và hold/toggle không áp dụng sai cho press action.

## 8. Authority, save và compatibility

- Logical server kiểm ownership, equipped flask, charge, context, action state, cooldown và heal commit.
- Flask instance/upgrade/current charge là persistent versioned state; quick selection/animation phase là derived/ephemeral.
- Inventory move/drop/death/Creative/command/reconnect không clone vessel/charge; future co-op không cho client heal actor khác bằng forged payload.
- Vanilla food/potion, other mod consumable và missing data có support tier rõ; arbitrary consumable không được hưởng quick-use path nếu chưa opt-in contract.

## 9. Acceptance hypotheses

- Spam input/packet chỉ dùng đúng một charge và tạo một heal per action ID.
- Người mới nhận ra charge, commit và lý do bị interrupt không cần mở menu.
- Flask tạo cửa sổ rủi ro thật nhưng không khiến heal gần như bất khả thi trong enemy mix chuẩn.
- Food vẫn được dùng tự nguyện cho survival/preparation; flask không trở thành giải pháp hunger.
- Capacity/potency progression không tạo death spiral, attrition vô nghĩa hoặc một upgrade bắt buộc cho mọi build.
- Save/reload/death/dimension/Creative/migration giữ charge/identity đúng; first/third camera cùng rule.

## 10. Open decisions

- `DB-047`: initial/max charge, potency model, refill economy, commit/cancel/hit matrix, dedicated key/default layout và HUD prototype.
- `DB-046/042`: HP numerical topology, healing formula, damage/defense và difficulty profiles.
- Content/Economy: vessel/reagent names, recipes, shop/service và upgrade milestones sau exemplar.

