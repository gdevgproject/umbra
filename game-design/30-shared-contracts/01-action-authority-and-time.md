# CTR-ACTION-AUTHORITY — Intent, authority và thời gian

> **DRI:** Technical Designer
> **Status:** `DISCOVERY`

Mọi actor dùng cùng envelope khái niệm: `intent_id`, actor, action ID, context, target/direction, client observation time và optional payload đã validate. Server xác thực ownership, state, resource, cooldown, target và rate; sau đó tạo action instance authoritative.

Một intent retry không tạo hai action. Gameplay time dùng server tick/monotonic instance clock; pause/unload/deadline phải khai báo clock nào chạy. Presentation event mang correlation ID nhưng không gây mutation. Prediction chỉ hiển thị outcome có thể rollback và phải có correction policy.

Consumers đầu: combat, skill, shadow command, quest interaction, item use và Gate enter/exit.
