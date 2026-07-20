# SYS-LIVING-SOCIETY — Kiến trúc xã hội sống và thứ tự phát triển

> **DRI:** World Designer + AI Designer
> **Approver:** Game Director + Technical Director
> **Reviewers:** Narrative, Quest, Economy, Performance, Data, QA
> **Status:** `PROPOSED`

## 1. Trải nghiệm đích

Người chơi phải cảm thấy NPC, settlement và faction tiếp tục sống, nhớ và phản ứng; không cần mọi NPC chạy một “bộ não hoàn chỉnh” ngoài tầm nhìn. Chiều sâu chỉ có giá trị khi tạo hành vi người chơi có thể quan sát, dự đoán hoặc tác động.

## 2. Các lớp state không được trộn

| Lớp | Ví dụ | Nhịp thay đổi |
|---|---|---|
| Identity | stable ID, Level cố định, personality archetype, vai trò, affiliation, năng lực nền | rất hiếm |
| Disposition | traits, values, long-term preference | chậm |
| Relationship memory | trust, debt, fear, witnessed facts | theo event, có compaction |
| Current condition | need, mood, injury, location intent | ngắn/trung hạn |
| Schedule/service | ca làm, nhà, dịch vụ, quest availability | theo lịch/event |
| Settlement aggregate | food, safety, service capacity, pressure | batch |
| Faction/world state | diplomacy, territory, policy, crisis | theo event/quest |

Dialogue không sở hữu truth; nó đọc các facts trên. AI runtime không ghi tùy tiện vào permanent history; mọi mutation có typed event, owner và bounded retention.

## 3. Thứ tự kỹ thuật đã chọn

1. **Identity + event ledger:** stable NPC/settlement/faction ID, provenance, save/migration và debug trace.
2. **Observable hub slice:** role, schedule, location intent, service, Level/density read và một phản ứng rõ theo player/world fact.
3. **Relationship/quest memory:** witness, trust/debt/fear, dialogue/quest condition và recovery.
4. **Settlement simulation:** safety, service/economy capacity và event pressure ở dạng aggregate.
5. **Faction/world state:** diplomacy, territory, policy và cross-settlement consequence.
6. **Deep individual expression:** personality-driven choice, family/social behavior và exceptional NPC reasoning tại nơi người chơi thật sự quan sát.

Lý do: identity/ledger là phần khó đảo ngược; một hub slice chứng minh schema bằng hành vi nhìn thấy; settlement/faction chỉ mở sau khi facts và services có consumer. Không xây social graph khổng lồ trước một phản ứng NPC có ý nghĩa.

## 4. Simulation tiers

`FOCUS → HYDRATED → SCHEDULED → AGGREGATED → DORMANT`

- `FOCUS`: NPC đang đối thoại, chiến đấu hoặc trong scene quan trọng; đầy đủ cue và choice cần thiết.
- `HYDRATED`: NPC gần player; entity, schedule và reactions có fidelity cao.
- `SCHEDULED`: vị trí/role/next event được giải theo mốc, không tick “suy nghĩ”.
- `AGGREGATED`: settlement/faction cập nhật nhóm theo batch.
- `DORMANT`: chỉ facts persistent, không runtime work.

Hydrate/dehydrate phải giữ identity và outcome; không mô phỏng lại quá khứ ngẫu nhiên khác với facts đã thấy. Tier/cadence tuân `QLT-PERFORMANCE`.

## 5. Content scalability

- Grammar dùng chung định nghĩa trait, need, relationship event và service; mỗi NPC đáng kể vẫn có dossier/exceptions riêng.
- Personality là tổ hợp nhỏ của trait + value + memory + current condition, không là hàng trăm script copy.
- Event ledger được compact thành facts/summaries khi raw history không còn giá trị gameplay; irreversible quest/world facts không bị compact mất.
- Authored scene có quyền khóa presentation tạm thời nhưng phải commit kết quả về cùng state owners.

## 6. Rủi ro cần chống từ đầu

- NPC schedule làm dịch vụ biến mất khó chịu: UI phải dự báo và có fallback hợp lý.
- Far simulation sinh hậu quả người chơi không thể hiểu: consequence lớn cần signal và causal trace.
- Economy tự chạy phá progression: settlement aggregate chỉ tác động qua contract/source-sink đã khóa.
- Social memory phình save: schema bounded, compaction và migration benchmark.
- “Smart AI” gian lận thông tin: NPC chỉ phản ứng fact họ biết theo source/witness policy.
- Content viết đè logic: definition validation và data-driven tags, không script đặc biệt vô chủ.

## 7. Feature Cells cần tách khi discovery sâu hơn

`FEAT-NPC-IDENTITY`, `FEAT-VILLAGE-POWER-DENSITY`, `FEAT-NPC-LEVEL-TRAITS`, `FEAT-NPC-SCHEDULE`, `FEAT-NPC-SERVICE`, `FEAT-RELATIONSHIP-MEMORY`, `FEAT-SETTLEMENT-STATE`, `FEAT-FACTION-WORLD-STATE`, `FEAT-NPC-PERSONALITY-CHOICE`.

Mỗi cell chỉ mở khi có một player-visible exemplar, performance tier và save/recovery oracle. `DB-041` sở hữu discovery package; implementation nằm sau nền Quest/World/Content phù hợp, không chen vào foundation kernel.
