# Archive policy

Nội dung trong `90-archive/` là hồ sơ lịch sử để bảo toàn ý tưởng và provenance. Nó **không phải nguồn chân lý**, không được dùng để chứng minh một feature đã `APPROVED` hoặc `IMPLEMENTATION_READY`.

## Corpus v4

`v4-monoliths/` giữ nguyên các tài liệu nguyên khối đã tồn tại trước cuộc cải tổ 2026-07-18. Khi migrate một đoạn:

1. Đọc toàn section và dependency được trích.
2. Gắn nhãn `DECIDED/CANDIDATE/ASSUMPTION/OPEN` theo protocol.
3. Đưa rule về đúng Feature Cell/Shared Contract.
4. Ghi provenance bằng đường dẫn archive trong phần `Migration notes`.
5. Không copy mục “Bổ sung vN” hoặc version log vào canonical.

Bốn file cũ `26`, `27`, `28`, `30` có thể còn ở root `game-design/` do quyền filesystem tại thời điểm migration. Chúng vẫn là **legacy** theo chính sách này; `game-design/README.md` và `AGENTS.md` có quyền điều hướng cao hơn đối với quy trình làm việc mới.

Không xóa archive cho tới khi mọi statement hữu ích đã có provenance hoặc được ghi là intentionally rejected.

