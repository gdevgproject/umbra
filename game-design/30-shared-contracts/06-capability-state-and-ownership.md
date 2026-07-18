# CTR-CAPABILITY-OWNERSHIP — Feature availability, state owner và lifecycle policy

> **DRI:** Technical Designer + Platform Lead
> **Status:** `DISCOVERY`

Mỗi Feature Cell khai:

- capability ID/version/availability và dependencies;
- definition owner, persistent instance owner, derived/client view owner;
- subject/world/instance IDs; không dùng display name làm key;
- create/load/enable/disable/unload/delete/migrate/recover transitions;
- death/respawn/reconnect/dimension/creative policy;
- authoritative writer và read/sync visibility;
- idempotency/correlation/audit keys cho mutation;
- missing/disabled/old-version fallback;
- diagnostics và test fixture.

Disable feature không tự xóa state. Death không mặc định copy hoặc reset; policy canonical nằm tại `CTR-DEATH-RECOVERY`. Creative được phép grant/spawn/test theo author intent nhưng mọi mutation có provenance; challenge/ranked eligibility xét theo event thay vì “taint” cả save. Exact state vẫn cần State Ownership Matrix của domain.
