# GOV-ROUTING — Agent tự định tuyến feedback và sửa tài liệu

> **Owner:** Design Operations
> **Status:** `APPROVED_FOR_DOCUMENTATION`

Người dùng chỉ cần mô tả điều muốn đổi bằng ngôn ngữ tự nhiên. Agent chịu trách nhiệm phân loại, đọc đúng set, lập impact map, sửa tất cả canonical homes và báo câu hỏi thật sự cần quyết.

## Phân loại yêu cầu

| Loại | Dấu hiệu | Hành động |
|---|---|---|
| Clarification | làm rõ câu, không đổi outcome/rule | sửa owner file + links |
| Local rule | đổi một Feature Cell, dependency hữu hạn | đọc feature/contracts/quality, cập nhật scenarios |
| Cross-system | chạm resource/state/input/save hoặc ≥2 domain | tạo Impact Map, cập nhật mọi owner + ADR |
| New feature | player intent/outcome mới | tạo seed, tìm domain/system, discovery backlog |
| Product expansion | audience, core loop, release promise hoặc domain mới | Product/scope ADR, roadmap re-evaluation |
| Balance tuning | chỉ đổi parameter trong rule đã approved | registry + simulation/evidence; không sửa rải rác |
| Bug/report | implementation trái contract | route QA/code khi feature đã triển khai; không viết lại rule để hợp bug |

Quy mô không được suy từ số chữ feedback. “Thêm lock-on” ngắn nhưng là Feature Cell cross-system; sửa một đoạn lore dài có thể chỉ là local content.

## Thuật toán định tuyến

1. Rút ra desired player outcome và constraints.
2. Tìm stable ID/thuật ngữ trong `game-design/`; đọc owner file hoàn chỉnh.
3. Từ domain map/catalog, liệt kê producers, consumers, shared contracts và quality proof.
4. Gắn nhãn từng mệnh đề `FACT/DECIDED/CANDIDATE/ASSUMPTION/OPEN`.
5. Chọn loại thay đổi ở bảng trên; nếu cross-system, lập impact table trước khi edit.
6. Sửa luật tại đúng owner; nơi khác chỉ cập nhật link/dependency/acceptance.
7. Cập nhật status/lifecycle, backlog và traceability nếu scope/readiness đổi.
8. Chạy validator, đọc lại tuyến ảnh hưởng và báo người dùng: đã hiểu gì, đổi gì, còn quyết gì.

## Khi feedback mơ hồ

Agent tiếp tục bằng assumption đảo ngược được và ghi rõ. Chỉ hỏi người dùng khi lựa chọn làm đổi fantasy, irreversible rule, release scope hoặc chi phí lớn. Câu hỏi phải nêu option/trade-off và canonical file sẽ bị ảnh hưởng.

## Điều Agent không đẩy cho người dùng

Không yêu cầu người dùng chỉ file, tự format Markdown, tự tìm trùng lặp, tự cập nhật link/status/backlog hoặc tự nhớ tác động kỹ thuật. Người dùng quyết outcome/trade-off; Agent quản trị hệ tài liệu.
