# SYS-COMPAT — Compatibility và baseline phát hành

> **DRI:** Release Engineer
> **Status:** `DISCOVERY`

Corpus cũ nhắm Minecraft `26.2.x`, Java `25` và Fabric ecosystem. Đây chỉ là candidate lịch sử chưa được coi là baseline hiện hành cho tới khi release discovery xác minh toolchain/API/mod dependencies.

Mỗi release record khóa: Minecraft/Fabric Loader/Fabric API/Java/mappings/build tool versions; client/server requirement; dedicated server; mod conflicts đã test; world upgrade/downgrade policy; config/datapack compatibility; OS/JVM matrix và known limitations.

Không hứa mọi loader/version. Nâng baseline cần compatibility ADR, save migration test, content reload test và rollback guidance. Optional integration dùng adapter/detection, không hard dependency nếu sản phẩm không yêu cầu.
