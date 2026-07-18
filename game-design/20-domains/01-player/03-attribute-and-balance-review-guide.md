# SYS-BALANCE-DISCOVERY — Tuyến đọc và bộ câu hỏi thuộc tính/cân bằng

> **DRI:** Systems Designer + Balance Designer
> **Approver:** Game Director
> **Reviewers:** Combat, Progression, Shadows, Enemy, UX, Economy, QA
> **Status:** `DISCOVERY`

## 1. Vì sao cần review lại từ nền

Các công thức hiện có trong Parameter Registry chỉ là candidate từ corpus cũ. Chưa khóa việc giữ `STR/AGI/VIT/INT/PER`, 5 điểm mỗi level, crit, armor, elemental multiplier, Potential 20/50/80 hoặc TTK. Không ticket nào được dùng chúng như luật đã duyệt trước `DB-042`.

Bạn không cần trả lời tất cả trong một lần. Đọc tuyến này rồi feedback nhóm nào bạn có hình dung rõ; Agent sẽ research, phản biện blast radius và đưa phần còn lại về đúng owner.

## 2. Tuyến đọc ngắn cho vòng feedback kế tiếp

1. File này — định nghĩa các quyết định thật sự cần bạn góp ý.
2. [Attributes, build và mastery](02-attributes-build-and-mastery.md) — candidate hiện tại.
3. [Balance framework](../../60-quality/01-balance-framework.md) — fairness, power curve và cách chứng minh.
4. [Vitals, Mana, Focus và HUD](../../30-shared-contracts/08-vitals-resource-and-hud-contract.md) — health truth, environmental damage và presentation.
5. [Resources, damage và death](../02-combat/03-resources-damage-and-death.md) — vai trò resource/damage pipeline.
6. [Combat Flask](../10-items-economy/03-combat-flask-and-quick-recovery.md) — heal trong combat, capacity/refill/interrupt.
7. Chỉ khi muốn xem số cũ: [Parameter Registry](../../60-quality/02-parameter-registry.md). Mọi số ở đó vẫn là hypothesis.

## 3. Vòng A — khóa fantasy và topology trước công thức

Đây là 12 câu có đòn bẩy lớn nhất; ưu tiên trả lời vòng tới.

1. Khi hai người cùng level nhưng build khác, bạn muốn **động từ/cách chơi** khác rõ hay chủ yếu khác hiệu quả con số?
2. Ở đầu, giữa và cuối game, sức mạnh nên nghiêng thế nào giữa bản thân player và tối đa bốn Hắc Ảnh đang triển khai? Không cần phần trăm; mô tả ai “kết liễu”, ai “kiểm soát”, ai “gánh sai lầm”, và khi chỉ mang 0/1/2 Shadow thì game bù bằng lựa chọn hay encounter ra sao.
3. Mọi build có phải tự solo được main progression, hay game được phép buộc đổi loadout/Shadow nhưng không buộc respec?
4. Năm fantasy `sức mạnh–nhanh nhẹn–sinh tồn–pháp/điều quân–nhận thức` có đúng không? Nếu đúng, tên/ranh giới nào đang trùng hoặc thiếu?
5. Attribute nên mở capability/milestone mới, hay chỉ tăng liên tục? Ví dụ STR mở phá posture, PER mở đọc weakness.
6. Có muốn người chơi tự cộng toàn bộ điểm từ level 1, hay có baseline tự tăng để một build “lỡ tay” vẫn sống được?
7. Bạn chấp nhận stat tác động trực tiếp tới attack speed, move speed, dodge timing/i-frame đến đâu? Những biến này rất dễ phá animation, PvP và muscle memory.
8. VIT/defense làm sao hữu ích mà không thành “thuế bắt buộc”; glass cannon có được tồn tại trong main journey không?
9. Potential là cam kết vĩnh viễn tạo identity, hay hệ có thể respec với giá/recovery? Bạn muốn cảm giác tự hào vì chọn hay tự do thử nghiệm mạnh hơn?
10. Counter nên là **soft counter có thể outplay** hay có một số hard gate buộc chuẩn bị đúng hệ/skill/Shadow?
11. Bạn thích damage scale nhỏ, đọc nhanh (hàng chục–nghìn) hay tăng rất lớn theo fantasy lâu năm? Điều này ảnh hưởng UI, cảm nhận và numerical stability.
12. Khi đánh bất lợi hệ/level, mastery giỏi có luôn có cửa thắng không; nếu có, bất lợi tối đa nên biểu hiện bằng thời gian, rủi ro hay thiếu khả năng xuyên cơ chế?

### Vòng A.5 — Vitals và hồi phục vừa mở

Có thể trả lời sau Vòng A hoặc cùng lúc nếu bạn đang có hình dung rõ:

1. Bạn muốn cảm giác tăng Max HP là “chịu thêm mấy sai lầm”, chống burst, hay phục hồi bền hơn? Không cần chọn số.
2. Mana chủ yếu đại diện cho phép/kỹ năng cá nhân, quyền lực triệu hồi đặc biệt, hay một pool chung có trade-off giữa hai fantasy?
3. Một thanh Focus đầy nên cho phép khoảng bao nhiêu Dodge cơ bản trước khi phải tạo nhịp hồi; progression nên tăng capacity, hồi, hiệu suất hay mở động từ?
4. Combat Flask nên mạnh nhờ số charge, potency, tốc độ dùng hay utility; lớp nào bạn muốn tránh để không thành nâng cấp bắt buộc?
5. Refill bình nên gắn rest/checkpoint, craft, shop, loot/Gate hay kết hợp; điều gì tạo chuẩn bị thú vị thay vì chore?
6. Fall/lửa/lava/ngạt/đói/status nên giữ độ nguy hiểm theo Max HP bằng flat, phần trăm, hybrid hay luật riêng theo từng family?

### Vòng A.6 — Traversal progression

Mechanic core đã có direction; feedback của bạn nên tập trung vào progression/quest thay vì phải tự thiết kế physics:

1. Bạn muốn Free Climb xuất hiện ngay sau Awakening, sau lần dựng shelter đầu tiên hay qua một training quest có nhân vật dạy?
2. Hạ Kình nên được dạy bằng một tình huống rơi bắt buộc an toàn hay người chơi tự khám phá rồi System giải thích?
3. Khinh Công nên là reward của level milestone, first Gate/trial hay một quest thân pháp riêng—miễn vẫn rất sớm và không miss?
4. Upgrade traversal về sau nên ưu tiên route dài hơn, hồi nhanh hơn hay thêm expression/move mới; loại nào dễ làm mất giá trị building nhất với bạn?

## 4. Vòng B — damage, phòng thủ và hiển thị

13. Damage nên gần deterministic hay có variance; nếu có variance, nó tạo thích nghi gì ngoài may rủi?
14. Crit là build identity, bonus phổ quát hay chỉ xuất hiện khi đánh đúng weakness/timing?
15. Armor nên giảm phần trăm, trừ phẳng, theo posture/penetration hay kết hợp theo layer?
16. Có bao nhiêu họ damage thật sự cần gameplay khác nhau: physical, elemental, status, true/environmental? Không đếm chỉ vì cần màu khác.
17. “Hệ” là vòng khắc chế cố định, quan hệ ngữ nghĩa theo tình huống, hay cả hai? Enemy có một weakness hay profile nhiều lớp?
18. Guard, posture, stagger, poise và crowd-control là một hay nhiều resource/state? Ai nhìn thấy chúng và bằng cue nào?
19. Resistance chống damage, chống buildup hay giảm duration/control? Có cap và diminishing return không?
20. Multi-hit/AoE/Retinue + hostile đông nên hiện từng số, gộp theo cửa sổ, chỉ số tổng, hay adaptive theo density?
21. Damage number mặc định bật hay contextual/optional? Người chơi cần thấy HP exact, bar, màu, icon hệ, crit, absorbed, blocked và overkill tới đâu?
22. Damage recap cần đủ sâu cho buildcraft nhưng không biến combat thành bảng tính như thế nào?

## 5. Vòng C — enemy, counterplay và difficulty

23. Enemy archetype nên khắc chế **hành vi** nào trước (spam attack, đứng xa, tụ quân, dodge sớm), rồi mới tới hệ nào?
24. Weakness được học bằng quan sát, PER/scan, item lore, thử nghiệm hay UI công khai?
25. Level gap có tăng số, mở move/AI mới, hoặc chỉ báo vùng nguy hiểm? Có hard miss/zero-damage không?
26. World có scale theo player, có vùng authored band, hay hybrid? Làm sao giữ zombie đầu đáng sợ nhưng sau này thể hiện tăng trưởng?
27. Regular/elite/boss cần sống đủ lâu để thể hiện bao nhiêu pattern/phase; bạn ghét sponge ở ngưỡng nào?
28. Difficulty mode đổi số hay đổi AI, telegraph, resource pressure và consequence? Setting nào được đổi giữa world?
29. Future co-op thêm người nên scale HP, composition, mechanics, AI target hoặc reward ra sao? Không khóa số trước khi co-op discovery.
30. PvE và future ranked PvP có dùng profile/cap/công thức riêng không? Hướng mặc định đề xuất: tách ruleset để PvP không nerf fantasy PvE.

## 6. Vòng D — progression, economy và longevity

31. Power đến từ level, attribute, gear, skill, mastery, Potential và Shadow; lớp nào là nền, lớp nào là sidegrade, lớp nào mở động từ?
32. Respec nhằm sửa sai, thử build hay đổi chiến thuật endgame? Cost/cooldown không được biến thành grind ép buộc.
33. Farm lâu nên tăng power chắc chắn, tăng lựa chọn, hay tăng mastery/expression? Trần nào chống infinite inflation?
34. Người chơi quay lại sau nghỉ dài có bị content cũ vô hiệu hóa không; catch-up là kiến thức, item hay power floor?
35. Creative/debug grant cần preview/test toàn build ra sao; provenance nào không làm phiền solo nhưng bảo vệ challenge/ranked eligibility?
36. Khi thêm hệ/enemy/stat mới sau nhiều năm, migration/respec/compatibility nào khiến save cũ không thành build chết?

## 7. Cách gửi nghiên cứu Where Winds Meet/Genshin

Với mỗi quan sát, chỉ cần gửi:

`game/version/context → điều bạn thấy → cảm xúc/quyết định nó tạo → điều muốn UMBRA học → điều không muốn copy`.

Video/screenshot hoặc tên menu giúp định vị; con số không rõ nguồn được ghi là observation candidate. Agent sẽ tách `quan sát → nguyên lý → lựa chọn UMBRA → bằng chứng → rủi ro IP`, kiểm tra nguồn chính thức khi có và không sao chép tên, asset, moveset hoặc biểu đạt.

## 8. Output của discovery

`DB-042` chỉ đóng khi có: Attribute Topology, Power Budget Map, Damage/Defense Contract, Counterplay Taxonomy, UI Readability Contract, mode/ruleset separation, simulation plan và migration strategy. Sau đó Parameter Registry mới được sửa từ candidate thành con số approved qua prototype evidence.

## 9. Bản đồ đọc cho hệ quái, hệ tộc và từng đối tượng

- **Thuộc tính/Potential/build:** [Attributes, build và mastery](02-attributes-build-and-mastery.md).
- **Máu/Mana/Focus/damage/hệ khắc chế:** file này → [Balance Framework](../../60-quality/01-balance-framework.md) → [`CTR-VITALS-HUD`](../../30-shared-contracts/08-vitals-resource-and-hud-contract.md); con số candidate ở Parameter Registry.
- **Tộc/faction là gì, văn hóa và silhouette:** [Faction Bible Standard](../../40-content/03-faction-bible-standard.md).
- **Enemy suy nghĩ, phối hợp, morale/director:** [Enemy, squad, morale và director](../05-ai/02-enemy-squad-morale-and-director.md).
- **Encounter dùng enemy nào để dạy/kiểm tra:** [Encounter Domain](../07-encounters/README.md).
- **Từng quái/tướng/item/skill có dossier riêng và variant ra sao:** [Content Instance Architecture](../../40-content/07-content-instance-architecture.md).
- **Leo/Hạ Kình/Khinh Công và Khí Lực:** [Traversal System](traversal/README.md) → [`CTR-TRAVERSAL`](../../30-shared-contracts/09-traversal-state-surface-and-vigor-contract.md).

Vì vậy không có một file “hệ quái” khổng lồ: faction sở hữu identity, AI sở hữu hành vi, Encounter sở hữu composition/teaching, Balance sở hữu counter/number và Content Instance sở hữu từng cá thể cụ thể.
