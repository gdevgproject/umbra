# DOM-AI — Actor Intelligence

> **DRI:** AI Designer
> **Approver:** Lead Game Designer
> **Reviewers:** Combat, Encounter, Shadows, Narrative, Performance, QA
> **Status:** `DISCOVERY`

AI tạo đối thủ có thể học, đồng đội đáng tin và thế giới có phản ứng, nhưng không đọc input bí mật hoặc tiêu thụ ngân sách vô hạn.

## Invariants

- AI chỉ dùng perception/state mà actor hợp lệ có thể biết.
- Ý định nguy hiểm có telegraph và counterplay.
- Difficulty tăng bằng phối hợp, pressure và pattern composition trước khi tăng stat.
- AI difficulty phải giữ một mô hình học được: cue→intent→action→recovery/counter. Tăng phản xạ, feint, phối hợp hoặc mix pattern phải theo mastery band và không làm mất cửa sổ con người có thể đọc/thực hiện.
- Quyết định quan trọng có reason code/debug trace.
- Tần suất suy nghĩ và representation giảm theo relevance, không theo cách làm đổi luật bí mật.
- Shadow AI phục vụ command/identity; enemy AI phục vụ encounter teaching. Không ép chung một policy khổng lồ.
- Biểu cảm là semantic có arbitration/priority/fallback; không để emote tự phát cắt combat hoặc mọi Shadow phản ứng đồng loạt.

## Tài liệu

1. [Kiến trúc và công bằng](01-architecture-and-fairness.md)
2. [Địch, squad, morale và director](02-enemy-squad-morale-and-director.md)
3. [Shadow, xã hội, gia đình và LOD](03-shadow-social-family-and-lod.md)
4. [Biểu cảm, nghi lễ và hiện diện xã hội của Shadow](04-shadow-expression-and-ritual-coordination.md)
