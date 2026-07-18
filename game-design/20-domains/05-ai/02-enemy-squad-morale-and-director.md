# SYS-ENEMY-AI — Địch, squad, morale và encounter director

> **DRI:** AI Designer + Encounter Designer
> **Status:** `DISCOVERY`

Enemy archetype được định nghĩa bởi combat role, preferred range, pressure tool, vulnerability, retreat/reposition rule và readable tells. Mỗi moveset còn phải khai `question asked`, defensive answer(s), punish/recovery window, variation/anti-repeat, synergy và escalation band; “nhiều chiêu” không tạo depth nếu mọi chiêu hỏi cùng một phản xạ. Faction thêm doctrine/coordination; không chỉ đổi skin.

Squad brain phân công engager, flanker, ranged pressure, support và reserve; reservation ngăn cả bầy chọn cùng một slot/skill. Morale có thể dẫn tới hesitation, retreat, surrender hoặc berserk nếu encounter cho phép, nhưng phải có cue và không phá objective.

Director quản lý pressure budget, reinforcement window, pacing và anti-stall. Nó không spawn phía sau camera tùy tiện, buff bí mật khi người chơi thắng hoặc vô hiệu hóa build. Nemesis là content layer dùng memory có giới hạn, không cho mọi mob một simulation vĩnh viễn.

Difficulty trước hết tăng bằng thứ tự/nhịp pattern, pressure lane, phối hợp vai trò, không gian buộc reposition và yêu cầu chuyển công cụ. Reaction latency, tracking, feint, cancel và prediction là biến cực nhạy: mỗi band phải có cue/counter, cap và test theo người học–competent–expert; AI không được rút ngắn window dưới khả năng presentation/input thực sự của build.
