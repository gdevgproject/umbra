# QLT-PARAMETERS — Parameter Registry

> **DRI:** Systems Designer + Balance Designer
> **Approver:** Game Director
> **Status:** `CANDIDATE`

Đây là canonical home duy nhất cho công thức và con số gameplay. `LOCKED` nghĩa Project Owner đã quyết và chỉ đổi qua feedback/CR mới; nó chưa tự làm Feature Cell `IMPLEMENTATION_READY`. `CANDIDATE` cần simulation/prototype/playtest. `OPEN` chưa có con số—code không được tự điền default rồi biến thành design.

Quy ước: `L` = Level · `⌊x⌋` = floor · `clamp(x,a,b)` = giới hạn trong `[a,b]` · logical server baseline 20 TPS.

## 1. Topology đã khóa

| ID | Parameter/rule | Status |
|---|---|---|
| `TOP-LEVEL-001` | Level bắt đầu 1, tiếp tục 100+; không Rank/Primary Attributes/Potential/Prestige | `LOCKED` |
| `TOP-VITALS-001` | UMBRA core meters = `HP + Vigor`; không Mana/Focus/Fatigue/Posture | `LOCKED` |
| `TOP-RETINUE-001` | roster tối đa 8, active combat tối đa 4 | `LOCKED` |
| `TOP-LOADER-001` | một gameplay/save semantics; Fabric current, NeoForge future parity gate | `LOCKED` |

## 2. Level và skill acquisition

| ID | Formula | Status |
|---|---|---|
| `SKL-START-001` | Level 1 có `1` active skill grant | `LOCKED` |
| `SKL-CADENCE-001` | `unlock_event_count(L) = ⌊L/5⌋`, với event tại 5,10,15,… | `LOCKED` |
| `SKL-GRANTS-001` | `total_grants_through_level(L) = 1 + ⌊L/5⌋` | `LOCKED` |
| `SKL-LOADOUT-001` | exact equipped active slot cap | `OPEN — DB-SKILL-PROGRESSION` |
| `LVL-EXP-001` | EXP curve/source mix và post-100 cadence | `OPEN — DB-LEVEL-PROGRESSION` |

Boundary samples: L1→4 =1 grant; L5=2; L10=3; L100=21. Một milestone event trao đúng một authored reward `NEW_SKILL / NODE / LOADOUT_SLOT`; formula không đồng nghĩa 21 equipped slots.

## 3. Vigor — base, cap, spend và recovery

| ID | Parameter | Base | Cap | Status |
|---|---|---:|---:|---|
| `VIG-MAX-001` | max Vigor | 100 | 240 | `LOCKED` |
| `VIG-REGEN-001` | regen | 25/s = 1,25/tick | 40/s = 2/tick | `LOCKED` |
| `VIG-DELAY-001` | recovery delay | 1,5s = 30 ticks | same | `LOCKED` |
| `VIG-DODGE-001` | Dodge/Sprint Burst activation | 18 | 18 | `LOCKED` |
| `VIG-CLIMB-001` | Climb Move | 4/s = 0,2/tick | 4/s | `LOCKED` |
| `VIG-CLIMB-JUMP-001` | Climb Jump | 25/action | 25 | `LOCKED` |
| `VIG-GROUNDING-001` | Hạ Kình | 0 | 0 | `LOCKED` |
| `VIG-LIGHTNESS-001` | Lightness launch/descent cost | — | — | `OPEN — DB-052` |
| `VIG-SPRINT-SUSTAIN-001` | ordinary sustained Sprint drain ngoài activation | — | — | `OPEN`; baseline chỉ `NO_REGEN` |

Recovery state:

```text
regen_allowed = delay_elapsed
                ∧ locomotion ∈ {IDLE, WALK, SNEAK}
                ∧ locomotion ∉ {SPRINT, CLINGING, AIRBORNE}
```

Delay restart ở spend gần nhất hoặc khi rời state cấm hồi. Regen/spend dùng server clock; reconnect/equip/max-change không refill.

### 3.1. Dodge arithmetic

```text
max_consecutive_dodges(V) = floor(V / 18)
remainder(V) = V - 18 · floor(V / 18)
```

| V | Số Dodge | Dư |
|---:|---:|---:|
| 100 | 5 | 10 |
| 240 | 13 | 6 |

### 3.2. Free Climb arithmetic

Tốc độ Climb Move tham chiếu `1,25 block/s`:

```text
continuous_seconds(V) = V / 4
continuous_height(V) = 1.25 · V / 4
move_vigor_per_block = 4 / 1.25 = 3.2
```

| V | Thời gian | Độ cao lý thuyết |
|---:|---:|---:|
| 100 | 25s | 31,25 block ≈31 |
| 240 | 60s | 75 block |

Climb Jump tham chiếu khoảng `2 block/action`:

```text
jump_count(V) = floor(V / 25)
jump_height(V) = 2 · floor(V / 25)
jump_vigor_per_block = 25 / 2 = 12.5
relative_inefficiency = 12.5 / 3.2 = 3.90625×
```

| V | Số jump | Độ cao | Dư |
|---:|---:|---:|---:|
| 100 | 4 | ≈8 block | 0 |
| 240 | 9 | ≈18 block | 15 |

Đây sửa lỗi cũ `24 × 4`; đúng là `25 × 4 = 100`.

### 3.3. Full-recovery wall time

`active_regen_time = Vmax / regen`; từ lúc ngừng action đến full còn cộng delay 1,5s:

| Vmax | Regen | Active regen | Tổng có delay |
|---:|---:|---:|---:|
| 100 | 25/s | 4,0s | 5,5s |
| 240 | 25/s | 9,6s | 11,1s |
| 100 | 40/s | 2,5s | 4,0s |
| 200 | 40/s | 5,0s | 6,5s |
| 240 | 40/s | 6,0s | 7,5s |

Vì vậy “200 điểm hồi khoảng 5 giây” chỉ đúng cho **active regen**, không gồm delay.

### 3.4. Long-term mastery

| ID | Rule | Status |
|---|---|---|
| `VIG-MASTERY-TIME-001` | đạt cả hai cap không sớm hơn tương đương 480 giờ active play hợp lệ (60 ngày ×8h), không daily quota/streak | `LOCKED TARGET` |
| `VIG-MASTERY-CLIMB-001` | Max tăng bằng valid attached/accepted climb distance/milestone | `LOCKED DIRECTION`; exact steps `OPEN` |
| `VIG-MASTERY-GROUND-001` | Regen tăng bằng valid ground locomotion; milestone nền đầu `30.000 block` | `LOCKED`; later steps `OPEN` |

Teleport, vehicle, Elytra, knockback, current, piston, AFK conveyor, duplicate event và movement không do player-authored locomotion không được tính. Exact anti-cheese thresholds cần QA/Platform evidence.

## 4. Hạ Kình

| ID | Parameter | Value | Status |
|---|---|---:|---|
| `GRD-WINDOW-001` | predicted vertical window | từ 1 tới 100+ loaded block; không design max | `LOCKED` |
| `GRD-ARREST-001` | Arrest & Orient | 3 logical ticks ≈0,15s ở 20 TPS | `LOCKED` |
| `GRD-DESCENT-001` | target descent speed | 35 block/s = 1,75 block/tick | `LOCKED` |
| `GRD-FALL-001` | valid-impact fall damage | 0 = triệt tiêu 100% fall component | `LOCKED` |
| `GRD-HITSTOP-001` | presentation hit-stop | 2–3 tick; không dừng logical server/world | `LOCKED RANGE` |
| `GRD-RADIUS-001` | entity AoE radius | formula dưới; cap 8 | `LOCKED` |
| `GRD-DAMAGE-001` | damage/stagger/launch/target cap/recovery theo weapon | — | `OPEN — DB-051` |

`h` là vertical loss từ stable support gần nhất trong airborne lineage tới impact, kể cả phần rơi trước khi bấm:

```text
h_radius = clamp(h, 1, 70)
radius_blocks(h) = min(8, 1 + h_radius / 10)
```

Samples: 1→1,1; 10→2; 40→5; 50→6; 60→7; ≥70→8. Height trên 70 không tăng radius/damage vô hạn. AoE chỉ hit eligible entities theo relation/occlusion/vertical/target cap; không mutate block/crop/redstone/container.

## 5. NPC Level, power, density và traits

Level bands rời nhau: `1–9`, `10–19`, …, `70–79`, `80–89`, `90+`.

| ID | Formula/rule | Status |
|---|---|---|
| `NPC-POWER-001` | `L2>L1 ⇒ baseHP(L2)>baseHP(L1) ∧ baseRawDamage(L2)>baseRawDamage(L1)` trong cùng family/profile | `LOCKED`; curve `OPEN` |
| `NPC-VISUAL-001` | `L2>L1 ⇒ visualTier(L2)≥visualTier(L1)` | `LOCKED`; thresholds `OPEN` |
| `NPC-DENSITY-090` | resident `90+` per Hub ≤1 | `LOCKED` |
| `NPC-DENSITY-080` | resident `80–89` per Hub ≤2 | `LOCKED` |
| `NPC-DENSITY-070` | resident `70–79` per Hub ≤5 | `LOCKED` |
| `NPC-DENSITY-LOW` | `weight(1–9)≥...≥weight(60–69)`; lower bands are majority | `LOCKED DIRECTION`; values `OPEN` |
| `NPC-FLEE-001` | `HPcurrent/HPmax ≤ flee_threshold(profile)` | threshold `OPEN`; retreat invariant `LOCKED` |
| `NPC-BULLY-001` | `warningDamageFinal=min(profileDamage,max(0,playerHPcurrent−1 HP))` | clamp `LOCKED`; profile/cooldown `OPEN` |
| `NPC-TRAIT-001` | high-level rare archetype incidence + personality variety per band | rarity/coverage `LOCKED`; percentage `OPEN` |

Quotas là maxima `0–N`, không target spawn. Upper bands không lồng nhau; nếu đầy, total upper-tier residents =8. Hub merge/split/reconcile không xóa/demote NPC để chữa overflow.

## 6. Retinue topology

```text
bonded_slots: 1 → ... → 8
active_combat_count ≤ 4
reserve_slots 5–8 contribute 0 direct current-combat actor budget
```

Exact unlock cadence/cost vẫn `OPEN`; không dùng Rank/Mana/Primary Attribute.

## 7. Các candidate độc lập còn giữ

### 7.1. Adaptive difficulty

```text
adaptive = clamp(1 + 0.10·tanh((expected_performance-actual_performance)/σ), 0.90, 1.10)
```

`CANDIDATE`: chỉ telegraph cadence/add composition, không HP/damage bí mật; ethics/accessibility review bắt buộc.

### 7.2. “Rác ra Vàng”

```text
sell_price(item,k) = tier_price(item) · max(0.2, 1-0.15·(k-4)) · cycle_bonus(item)
```

`CANDIDATE`: `k` là số stack cùng tier trong active farm chain; cycle không reset theo ngày thật. Exact tier prices bị rút vì cần economy rebaseline không dựa Rank.

### 7.3. Gate lifecycle và Soul Echo

```text
objectives_complete = all required objectives COMPLETE
gate_close_allowed = objectives_complete ∧ valid_participant_count_inside=0 ∧ exit_event_after_clear
FreshCorpse_ttl = 120s
SoulEcho_expiry = Gate.CLOSED or Gate.BROKEN
SoulEcho_cap_per_gate = 128 eligible targets; boss/elite/unique protected first
```

Các số này vẫn `CANDIDATE`; Gate owner phải revalidate trước implementation.

### 7.4. Combat Flask

```text
initial_charges = 1                         [LOCKED DIRECTION]
max_charges = 10                            [USER HYPOTHESIS — NOT APPROVED]
potency ∈ {FLAT, PERCENT_MAX, HYBRID, TIERED}
```

## 8. Parameter keys còn mở

```text
Vigor.low_band / critical_band / rounding_resolution / full_fade_grace
Vigor.mastery_capacity_steps / mastery_regen_steps / valid_distance_filters
FreeClimb.attach_distance / collision_profile / leap_impulse / mantle_semantics
Lightness.charge / launch / steering / descent / Vigor cost
Dodge.direction_curve / defensive_category_windows / cancel_matrix
Grounding.damage / stagger / launch / target_cap / recovery / occlusion_vertical_band
NPC.level_HP_curve / level_damage_curve / visual_tiers / lower_band_weights
NPC.bully_incidence / guardian_incidence / warning_damage / cooldown / flee_threshold
```

Mọi key `OPEN` cần candidate range + property/simulation + voxel/hub prototype + human-only feel/comprehension evidence trước approve. Không parameter nào scale theo FPS, loader callback order hoặc field Rank/Primary Attribute đã xóa.

## 9. Quy trình thay đổi

1. Ghi requirement/CR và affected stable IDs.
2. Nếu `LOCKED`, chỉ Project Owner feedback mới đổi; update canonical rule trước code.
3. Chạy simulation/property/boundary proof và prototype đúng risk lane.
4. Review owner liên domain, migration/save/HUD/AI/performance impact.
5. Cập nhật registry + exact evidence; Git giữ lịch sử, không thêm “bổ sung vN”.
