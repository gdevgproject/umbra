# Báo Cáo Nghiên Cứu Thiết Kế Game Và Tư Duy Cân Bằng Trong Genshin Impact

## 1. Hệ thống chỉ số nhân vật và cơ chế quy đổi thuộc tính

Hệ thống chỉ số nhân vật (Character stats system) trong *Genshin Impact* được thiết kế dựa trên một kiến trúc toán học đa phân lớp nhằm tạo ra sự tối ưu hóa trong việc xây dựng đội hình (build), đồng thời tạo ra rào cản tài nguyên thúc đẩy hành vi cày cuốc lâu dài. Mỗi thuộc tính chiến đấu của nhân vật đều chịu sự chi phối chặt chẽ bởi cấp độ, độ hiếm của trang bị, và cơ chế cộng dồn thuộc tính.

### Công thức tính toán chỉ số thuộc tính cơ bản và tổng thể

Toàn bộ các chỉ số cốt lõi bao gồm HP (Máu), ATK (Tấn công), và DEF (Phòng thủ) của một nhân vật khi tham gia chiến đấu được phân tách thành hai giá trị hiển thị rõ ràng trên giao diện thuộc tính: Chỉ số cơ bản (Base Stat - hiển thị bằng màu trắng) và Chỉ số cộng thêm (Bonus Stat - hiển thị bằng màu xanh lá cây).

Công thức tổng quát để xác định giá trị cuối cùng của một thuộc tính thuộc nhóm HP hoặc DEF như sau:

$$\text{Chỉ số tổng (HP/DEF)} = \text{Chỉ số cơ bản}_{\text{Nhân vật}} \times \left(1 + \sum \% \text{Bonus}\right) + \text{Chỉ số phẳng cộng thêm}$$
[cite: 1, 7]

Đối với chỉ số ATK, cơ chế tính toán có sự khác biệt mang tính chiến lược khi tích hợp trực tiếp sức mạnh của vũ khí vào chỉ số cơ bản của nhân vật:

$$\text{Base ATK}_{\text{Tổng}} = \text{Base ATK}_{\text{Nhân vật}} + \text{Base ATK}_{\text{Vũ khí}}$$
[cite: 4, 5, 7]

$$\text{Total ATK} = \text{Base ATK}_{\text{Tổng}} \times \left(1 + \sum \% \text{ATK Bonus}\right) + \text{Flat ATK Bonus}$$
[cite: 1, 7]

Trong đó:

- $\sum \% \text{Bonus}$: Tổng các phần trăm thuộc tính gia tăng từ các dòng chính/phụ của thánh di vật (artifacts), nội tại vũ khí, thiên phú nhân vật, cộng hưởng nguyên tố, và hiệu ứng thức ăn bổ trợ.
- $\text{Flat Bonus}$ (Chỉ số phẳng): Các giá trị số cộng thẳng trực tiếp, ví dụ như dòng chính của lông vũ (+311 ATK ở phẩm chất 5 sao cấp +20) hay các dòng phụ phẳng (+19 ATK, +298 HP). Các chỉ số phẳng này hoàn toàn không chịu tác động nhân cấp từ dòng phần trăm (% Bonus).

### Phân bổ chỉ số chí mạng và nạp năng lượng

Bên cạnh các thuộc tính sinh tồn và tấn công cơ bản, hệ thống chiến đấu được vận hành thông qua các chỉ số điều tiết tần suất và hiệu quả sát thương:

- **CRIT Rate (Tỷ lệ chí mạng)** và **CRIT DMG (Sát thương chí mạng)**: Theo mặc định thiết kế, mọi nhân vật đều xuất phát với mốc cơ bản là $5\%$ CRIT Rate và $50\%$ CRIT DMG. Tỷ lệ phân bổ tối ưu hóa sát thương trung bình được xác định là $1:2$ (CRIT Rate : CRIT DMG). Sự phân bổ này tương thích với trọng số điểm dòng phụ trên trang bị khi 1 điểm CRIT Rate luôn có giá trị tương đương 2 điểm CRIT DMG.
- **Energy Recharge (Hiệu quả nạp nguyên tố)**: Chỉ số điều tiết tần suất kích hoạt kỹ năng Nộ (Elemental Burst), bắt đầu ở mốc mặc định $100\%$ và tăng dần qua đột phá hoặc trang bị.
- **Elemental Mastery (Tinh thông nguyên tố)**: Chỉ số không có mốc khởi điểm tự nhiên ($0$ điểm), trực tiếp khuếch đại sát thương hoặc hiệu quả của tất cả các phản ứng nguyên tố.

| **Loại thuộc tính** | **Giá trị cơ bản ban đầu** | **Cơ chế tăng trưởng tự nhiên** | **Tác động của độ hiếm trang bị** | 
| --- | --- | --- | --- | 
| **HP (Máu)** | Khác nhau theo nhân vật | Tăng theo cấp độ và đột phá | Tăng mạnh qua dòng chính Hoa của thánh di vật | 
| **ATK (Tấn công)** | Khác nhau theo nhân vật | Tăng theo cấp độ và đột phá | Tăng qua dòng chính Lông và Base ATK vũ khí | 
| **DEF (Phòng thủ)** | Khác nhau theo nhân vật | Tăng theo cấp độ và đột phá | Tăng qua dòng chính/phụ của thánh di vật | 
| **CRIT Rate** | $5.0\%$ [cite: 1] | Chỉ tăng qua đột phá của một số nhân vật | Xuất hiện ở nón dòng chính và dòng phụ trang bị | 
| **CRIT DMG** | $50.0\%$ [cite: 1] | Chỉ tăng qua đột phá của một số nhân vật | Xuất hiện ở nón dòng chính và dòng phụ trang bị | 

### Ví dụ tính toán số liệu thực tế cho thuộc tính ATK

Xét một nhân vật tấn công có chỉ số Base ATK ở cấp độ 90 là $300$. Nhân vật được trang bị một vũ khí 5 sao cấp độ 90 có Base ATK là $600$. Bộ thánh di vật đang đeo cung cấp các chỉ số sau: dòng chính đồng hồ cát $+46.6\%$ ATK, dòng phụ tích lũy đạt $+30\%$ ATK, thánh di vật lông vũ dòng chính $+311$ ATK phẳng, và dòng phụ phẳng tích lũy đạt $+100$ ATK phẳng.

$$\text{Base ATK}_{\text{Tổng}} = 300 + 600 = 900 \text{ ATK}$$
[cite: 4]

$$\sum \% \text{ATK Bonus} = 46.6\% + 30\% = 76.6\% = 0.766$$$$\text{Flat ATK Bonus} = 311 + 100 = 411 \text{ ATK}$$
[cite: 1]

Áp dụng công thức tổng thể:

$$\text{Total ATK} = 900 \times (1 + 0.766) + 411 = 900 \times 1.766 + 411 = 1589.4 + 411 \approx 2000 \text{ ATK}$$
[cite: 1]

Sự phân tách này chỉ ra rằng mọi dòng tăng $\%$ ATK từ thánh di vật chỉ khai thác giá trị từ mốc $900$ Base ATK, trong khi lượng $411$ ATK cộng thẳng hoàn toàn đứng ngoài phép nhân này, tránh hiện tượng lạm phát chỉ số không kiểm soát.

## 2. Hệ nguyên tố và cơ chế phản ứng sâu

Trọng tâm của hệ thống chiến đấu là sự tương tác giữa 7 nguyên tố: Phong (Anemo), Nham (Geo), Lôi (Electro), Thủy (Hydro), Hỏa (Pyro), Băng (Cryo), và Thảo (Dendro). Sự phối hợp này tạo ra các phản ứng nguyên tố (elemental reactions) có cơ chế vận hành phức tạp.

### Phân loại các nhóm phản ứng nguyên tố và công thức sát thương

Hệ thống phản ứng được chia làm bốn nhóm lớn, mỗi nhóm sở hữu cách thức tính toán sát thương riêng biệt:

#### 1. Phản ứng Tăng cường (Amplifying Reactions)

Gồm Bốc Hơi (Vaporize) và Tan Chảy (Melt). Nhóm phản ứng này không tạo ra nguồn sát thương độc lập mà nhân trực tiếp sát thương của đòn đánh kích hoạt phản ứng. Sát thương này có khả năng chí mạng (CRIT), chịu ảnh hưởng bởi chỉ số phòng thủ (DEF) và kháng (RES) của kẻ địch.

- **Vaporize**: Thủy đánh lên Hỏa (Bốc Hơi Xuôi) nhân sát thương $\times 2.0$; Hỏa đánh lên Thủy (Bốc Hơi Ngược) nhân sát thương $\times 1.5$.
- **Melt**: Hỏa đánh lên Băng (Tan Chảy Xuôi) nhân sát thương $\times 2.0$; Băng đánh lên Hỏa (Tan Chảy Ngược) nhân sát thương $\times 1.5$.

Công thức tính sát thương Tăng cường:

$$\text{Sát thương cuối} = \text{Sát thương đòn đánh gốc} \times \text{Hệ số phản ứng (1.5 hoặc 2.0)} \times (1 + \% \text{EM Bonus} + \% \text{Reaction Bonus})$$
[cite: 21, 24, 25]

Với phần trăm gia tăng từ Tinh thông nguyên tố (% EM Bonus) được tính là:

$$\% \text{EM Bonus (Amplifying)} = \frac{2.78 \times \text{EM}}{\text{EM} + 1400}$$
[cite: 26]

#### 2. Phản ứng Biến đổi (Transformative Reactions)

Gồm Quá Tải (Overloaded), Siêu Dẫn (Superconduct), Điện Cảm (Electro-Charged), Khuếch Tán (Swirl), Sum Suê (Bloom), Nở Rộ (Hyperbloom), Bung Tỏa (Burgeon), Phá Băng (Shatter), và Thiêu Đốt (Burning).

Nhóm phản ứng này tạo ra một nguồn sát thương độc lập, hoàn toàn bỏ qua chỉ số phòng thủ (DEF) của quái vật, không thể chí mạng (trừ một số thiên phú đặc biệt của nhân vật hỗ trợ) và chỉ phụ thuộc vào cấp độ của nhân vật kích hoạt phản ứng cùng chỉ số kháng (RES) của mục tiêu.

Công thức tính sát thương Biến đổi:

$$\text{Sát thương phản ứng} = \text{Hệ số phản ứng} \times \text{Level Multiplier} \times (1 + \% \text{EM Bonus} + \% \text{Reaction Bonus}) \times \text{Enemy RES Multiplier}$$
[cite: 13, 14, 28]

Với phần trăm gia tăng từ Tinh thông nguyên tố (% EM Bonus) được tính là:

$$\% \text{EM Bonus (Transformative)} = \frac{16 \times \text{EM}}{\text{EM} + 2000}$$
[cite: 29]

Và giá trị Level Multiplier của nhân vật tăng trưởng phi tuyến tính theo cấp độ: tại cấp 80 là $1077.44$, cấp 90 là $1446.85$, và cấp 100 là $2030.07$.

#### 3. Phản ứng Tăng cường Thêm (Additive Reactions)

Gồm Tăng Cường (Aggravate) và Lan Truyền (Spread) phát sinh khi Lôi hoặc Thảo tác động lên kẻ địch đang chịu trạng thái Sinh Trưởng (Quicken). Phản ứng cộng thêm một lượng sát thương phẳng trực tiếp vào sát thương gốc của đòn đánh trước khi tính toán các hệ số nhân % sát thương và chí mạng.

$$\text{Sát thương cộng thêm} = \text{Hệ số phản ứng (1.15 hoặc 1.25)} \times \text{Level Multiplier} \times \left(1 + \frac{5 \times \text{EM}}{\text{EM} + 1200}\right)$$
[cite: 6, 23, 24]

#### 4. Phản ứng Mặt Trăng (Lunar Reactions) - Cập nhật phiên bản 6.0/6.1+

Xuất hiện tại vùng đất mới Nod-Krai, các phản ứng Lunar-Charged, Lunar-Crystallize, và Lunar-Bloom mang đặc tính biến đổi nhưng có khả năng chí mạng và được khuếch đại trực tiếp từ chỉ số cơ bản của nhân vật:

| **Loại phản ứng** | **Các nguyên tố tham gia** | **Cơ chế tính toán sát thương bổ sung** | **Hiệu ứng phụ đi kèm** | 
| --- | --- | --- | --- | 
| **Lunar-Bloom** | Thủy + Thảo + Sức mạnh Mặt Trăng | Cộng thêm $+0.8\%$ sát thương cho mỗi 1000 HP tối đa. | Tạo hạt nhân Mặt Trăng phát nổ gây sát thương diện rộng. | 
| **Lunar-Charged** | Lôi + Mặt Trăng | Cộng thêm $+1.2\%$ sát thương cho mỗi 100 ATK của nhân vật. | Gây sát thương Lôi diện rộng và giảm phòng thủ kẻ địch. | 
| **Lunar-Crystallize** | Nham + Mặt Trăng | Cộng thêm $+1.2\%$ sát thương cho mỗi 100 DEF của nhân vật. | Tạo khiên hấp thụ sát thương cực mạnh và tăng $30\%$ DEF đồng đội. | 

### Lý thuyết Gauge Nguyên Tố (Elemental Gauge Theory)

Lý thuyết Gauge Nguyên Tố là một cơ chế ẩn quy định cách thức các hạt nguyên tố tương tác và triệt tiêu nhau trên mục tiêu. Lượng nguyên tố áp dụng lên kẻ địch được đo bằng đơn vị Gauge Unit (GU).

Khi một đòn tấn công nguyên tố chạm vào mục tiêu chưa có ấn, nó sẽ áp dụng một lượng ấn nguyên tố nền (Aura). Hệ thống ngay lập tức trừ đi $20\%$ làm "Thuế phủ ấn" (Aura Tax):

$$\text{Ấn Aura thực tế} = \text{Gauge của đòn đánh (1U / 2U / 4U)} \times 0.8$$
[cite: 21, 40]

- Ví dụ: Kaeya thi triển kỹ năng nguyên tố ($2\text{U}$) lên mục tiêu chưa có ấn $\Rightarrow$ lượng ấn Băng tích lũy thực tế là $2\text{U} \times 0.8 = 1.6\text{U}$.

Tốc độ phân rã ấn tự nhiên (Decay Rate) phụ thuộc hoàn toàn vào đòn đánh đầu tiên tạo ra Aura. Một ấn $1\text{U}$ thực tế tồn tại trong $9.5$ giây (phân rã $0.105\text{ U/s}$), trong khi ấn $2\text{U}$ tồn tại trong $12$ giây (phân rã $0.167\text{ U/s}$).

Khi một nguyên tố thứ hai được áp dụng để kích hoạt phản ứng (Trigger), lượng nguyên tố Aura hiện tại sẽ bị tiêu trừ dựa trên hệ số tiêu thụ nguyên tố tương khắc:

- **Phản ứng mạnh (Forward)**: Tiêu thụ với tỷ lệ $2.0 \times \text{Trigger GU}$.
- **Phản ứng yếu (Reverse)**: Tiêu thụ với tỷ lệ $0.5 \times \text{Trigger GU}$. Do tiêu hao rất ít ấn Aura nền, người chơi có thể kích hoạt liên tục nhiều phản ứng liên tiếp trên cùng một mục tiêu.

### Cơ chế thời gian hồi chiêu ẩn (Internal Cooldown - ICD)

Nhằm ngăn chặn việc người chơi liên tục kích hoạt phản ứng nguyên tố trong thời gian cực ngắn, hệ thống áp đặt cơ chế thời gian hồi chiêu ẩn (ICD). ICD mặc định hoạt động theo quy tắc kép **"2.5 giây hoặc 3 đòn đánh"**:

1. **Mốc thời gian**: Khi một đòn đánh áp dụng nguyên tố thành công, một đồng hồ đếm ngược 2.5 giây sẽ bắt đầu chạy. Bất kỳ đòn đánh nào cùng loại trong khoảng thời gian này sẽ không thể áp dụng ấn nguyên tố mới.
2. **Mốc số đòn đánh (Hit Count)**: Cứ mỗi đòn đánh thứ 3 tính từ đòn áp dụng ấn gần nhất sẽ tự động bỏ qua thời gian hồi 2.5 giây để áp dụng ấn nguyên tố ngay lập tức (Đòn thứ 1 áp dụng ấn $\Rightarrow$ đòn 2 và 3 bị hồi chiêu $\Rightarrow$ đòn thứ 4 áp dụng ấn thành công).

Một số kỹ năng của nhân vật được thiết kế **không có ICD (No ICD)** để tạo ra lợi thế chiến thuật rõ rệt:

- **Kỹ năng Nộ của Xiangling (Pyronado)**: Mọi đòn quét của bánh xe lửa đều áp dụng ấn Hỏa và kích hoạt phản ứng.
- **Kỹ năng Nguyên tố của Kokomi (Bake-Kurage)**: Nhịp phun nước của sứa biển luôn kích hoạt Điện Cảm hoặc Đóng Băng trên mỗi chu kỳ tấn công.

## 3. Vũ khí và trang bị thánh di vật

Sức mạnh thực tế của một nhân vật được định hình chủ yếu thông qua việc phối hợp thuộc tính giữa vũ khí và các bộ thánh di vật.

### Thiết kế vũ khí và quy luật bù trừ thuộc tính (Stat Trade-off)

Vũ khí được phân cấp từ 1 đến 5 sao. Nhằm bảo toàn tính cân bằng và đa dạng hóa trang bị, các nhà thiết kế áp dụng một quy luật toán học nghiêm ngặt: **Base ATK của vũ khí luôn tỷ lệ nghịch với giá trị của dòng phụ thuộc tính (Substat)**.

Các mốc phân bổ thuộc tính chuẩn của vũ khí 4 sao và 5 sao ở cấp độ tối đa (Cấp 90):

| **Phân cấp vũ khí** | **Base ATK tối đa** | **Giá trị dòng phụ: CRIT Rate** | **Giá trị dòng phụ: CRIT DMG** | **Giá trị dòng phụ: %ATK** | 
| --- | --- | --- | --- | --- | 
| **5 Sao (Tối đa ATK)** | $674$ | $22.1\%$ | $44.1\%$ | $33.1\%$ | 
| **5 Sao (Cân bằng)** | $608$ | $33.1\%$ | $66.2\%$ | $49.6\%$ | 
| **5 Sao (Tối đa Dòng phụ)** | $542$ | $44.1\%$ | $88.2\%$ | $66.2\%$ | 
| **4 Sao (Tối đa ATK)** | $565$ | $18.4\%$ | $36.8\%$ | $27.6\%$ | 
| **4 Sao (Cân bằng)** | $510$ [cite: 51] | $27.6\%$ | $55.1\%$ | $41.3\%$ | 
| **4 Sao (Tối đa Dòng phụ)** | $454$ | $36.8\%$ | $73.6\%$ | $55.1\%$ | 

Ý đồ thiết kế đằng sau cơ chế này:

- Các nhân vật truyền thống scale sát thương hoàn toàn theo ATK sẽ ưu tiên các vũ khí có Base ATK cao ($674$ hoặc $565$) để tối ưu hóa phép nhân phần trăm từ thánh di vật.
- Các nhân vật thế hệ mới scale sát thương theo HP hoặc DEF (như Furina, Linnea) hoàn toàn bỏ qua chỉ số Base ATK. Do đó, họ sẽ lựa chọn các vũ khí có Base ATK thấp nhất ($542$ hoặc $454$) để thu về lượng dòng phụ khổng lồ như $88.2\%$ CRIT DMG hoặc $55.1\%$ %DEF nhằm tối đa hóa hiệu suất sát thương của mình.

### Hệ thống thánh di vật (Artifacts) và cơ chế cày cuốc

Thánh di vật gồm 5 vị trí bắt buộc: Hoa (Flower), Lông (Plume), Đồng hồ (Sands), Ly (Goblet), và Nón (Circlet).

#### Cơ chế khởi tạo dòng phụ và quy luật nâng cấp ngẫu nhiên

Mỗi thánh di vật 5 sao khi rơi ra sẽ có ngẫu nhiên 3 hoặc 4 dòng phụ ban đầu. Cứ mỗi 4 cấp độ cường hóa (+4, +8, +12, +16, +20), hệ thống sẽ ngẫu nhiên thêm một dòng phụ mới (nếu ban đầu chỉ có 3 dòng) hoặc tăng ngẫu nhiên giá trị của một trong 4 dòng phụ hiện có.

Xác suất xuất hiện ban đầu của các dòng phụ bị phân bổ lệch (weighted) cực kỳ nặng nề hướng về các dòng chỉ số phẳng ít giá trị (như flat HP, flat ATK, flat DEF) nhằm kéo dài thời gian cày cuốc của người chơi:

- Tỷ lệ xuất hiện dòng phụ flat HP/ATK/DEF luôn ở mức cao ($15\%$).
- Tỷ lệ xuất hiện dòng phụ CRIT Rate hoặc CRIT DMG chỉ ở mức tối thiểu ($7.8\%$).

Tuy nhiên, **một khi 4 dòng phụ đã được xác định hoàn chỉnh, tỷ lệ ngẫu nhiên chọn dòng nào để tăng cấp ở mỗi mốc +4 là đồng đều tuyệt đối ($25\%$ cơ hội cho mỗi dòng)**. Điều này đồng nghĩa với việc người chơi có cơ hội nâng cấp thành công một thánh di vật "hoàn hảo" (tất cả 5 lần nâng cấp đều rơi vào dòng bạo kích) với xác suất cực thấp:

$$P_{\text{hoàn hảo}} = 0.25^5 = 0.0976\% = 1/1024$$
[cite: 54]

Sự phân bổ này ảnh hưởng trực tiếp đến việc phân chia các hướng xây dựng nhân vật (build archetypes):

- **Xây dựng kiểu ADC (ATK / DMG Bonus / CRIT)**: Phù hợp cho các nhân vật gây sát thương trực tiếp truyền thống, sử dụng cát ATK%, ly Sát thương nguyên tố, và nón Chí mạng.
- **Xây dựng kiểu EDC (EM / DMG Bonus / CRIT)**: Áp dụng cho các nhân vật tập trung kích hoạt phản ứng nguyên tố mạnh mẽ.

## 4. Cơ chế rơi đồ, tối ưu hóa tài nguyên và mô hình Gacha

Hệ thống điều tiết tiến trình chơi (player progression) của game được vận hành thông qua tài nguyên Nhựa Nguyên Bản (Resin) - hồi phục tự động với tốc độ 1 điểm mỗi 8 phút, tối đa 180 điểm một ngày.

### Tối ưu hóa hiệu suất tiêu hao Resin theo Adventure Rank (AR)

Nhà phát triển thiết kế hệ thống phần thưởng tăng trưởng khóa chặt theo Cấp độ mạo hiểm (AR) của tài khoản để kích thích tiến trình khám phá của người chơi:

- **Trước mốc AR40**: Bí cảnh thánh di vật chỉ rơi trang bị phẩm chất tối đa là 4 sao. Tuyệt đối không nên tiêu hao tài nguyên Nhựa Dễ Vỡ (Fragile Resin) tại giai đoạn này.
- **AR40 - AR44**: Bí cảnh cấp III mở khóa cơ hội rơi thánh di vật 5 sao với tỷ lệ chỉ đạt khoảng $35\%$. Hiệu suất sử dụng nhựa rất kém.
- **AR45+**: Bí cảnh cấp tối đa được mở khóa, **đảm bảo $100\%$ rơi ít nhất một thánh di vật 5 sao cho mỗi 20 Resin tiêu tốn**, kèm theo $6.5\%$ đến $10\%$ cơ hội nhận thêm một thánh di vật 5 sao thứ hai. Đây là thời điểm hiệu quả sử dụng nhựa đạt mức tối đa ($71\%$ cao hơn so với giai đoạn trước đó).

### Cơ chế bảo hiểm Gacha nâng cao (Pity System)

Hệ thống Gacha của trò chơi được thiết kế dựa trên một mô hình xác suất biến đổi thông minh nhằm cân bằng giữa trải nghiệm của người chơi miễn phí (F2P) và động lực nạp tiền của người chơi trả phí (whales).

#### Quy trình tính toán xác suất tăng dần (Soft Pity)

Xác suất cơ bản để nhận một vật phẩm 5 sao trên banner nhân vật giới hạn là cực thấp, chỉ $0.6\%$ cho mỗi lượt cầu nguyện lẻ. Tuy nhiên, để tránh việc người chơi rơi vào chuỗi thất bại quá dài gây ức chế tinh thần, một thuật toán ẩn bắt đầu kích hoạt tại lượt quay thứ 74:

- **Từ lượt quay thứ 1 đến 73**: Xác suất cố định ở mốc $0.6\%$.
- **Từ lượt quay thứ 74 trở đi (Soft Pity)**: Xác suất tăng vọt thêm khoảng $6\%$ cho mỗi lượt quay tiếp theo (Lượt thứ 74 đạt $6.6\%$, lượt 75 đạt $12.6\%$, v.v.).
- **Lượt quay thứ 90 (Hard Pity)**: Đảm bảo $100\%$ chắc chắn nhận vật phẩm 5 sao.

Tính toán trung bình trên quy mô dữ liệu lớn cho thấy người chơi sẽ nhận được vật phẩm 5 sao ở lượt quay thứ **62**.

#### Cơ chế tích lũy "Tia Sáng Đột Phá" (Capturing Radiance) - Phiên bản 5.0+

Nhằm tối ưu hóa tỷ lệ thắng của người chơi khi đối mặt với cơ chế tung đồng xu $50/50$ (quy định cơ hội nhận nhân vật giới hạn hoặc nhân vật thường của banner), hệ thống tích hợp thêm cơ chế Capturing Radiance từ phiên bản 5.0.

Cơ chế này hoạt động dựa trên một bộ đếm ẩn theo dõi chuỗi thất bại liên tiếp khi người chơi ở trạng thái $50/50$:

$$\text{Xác suất kích nổ Capturing Radiance} = \begin{cases} 0\% & \text{khi có } 0 \text{ hoặc } 1 \text{ lần lệch liên tiếp trước đó} \\ 33.333\% & \text{khi có } 1 \text{ lần lệch } 50/50 \text{ và không kích hoạt ở đợt tiếp theo} [cite: 66, 67] \\ 66.667\% & \text{khi có } 2 \text{ lần lệch } 50/50 \text{ liên tiếp} [cite: 66, 67] \\ 100\% & \text{khi có } 3 \text{ lần lệch } 50/50 \text{ liên tiếp} [cite: 65, 66, 67] \end{cases}$$
Khi Capturing Radiance được kích hoạt thành công, trò chơi sẽ hiển thị một hiệu ứng chuyển cảnh ánh sáng màu hồng kim độc quyền, chủ động chuyển đổi nhân vật thường bị lệch thành nhân vật giới hạn của banner đó. Thuật toán này đã nâng tỷ lệ thắng thực tế trên quy mô toàn máy chủ từ $50\%$ lên **$55\%$**.

## 5. Đột phá thế giới và thăng tiến giới hạn nhân vật

Trò chơi sử dụng cơ chế Cấp độ thế giới (World Level - WL) để liên tục đồng bộ độ khó của quái vật với sự gia tăng chỉ số của nhân vật.

### Cơ chế Đột phá Cấp độ thế giới 9 (World Level 9)

Mở khóa tự động khi tài khoản đạt Cấp độ mạo hiểm 58 (AR58+). WL9 mang lại thay đổi lớn trong việc tối ưu hóa chuỗi thăng tiến sức mạnh của người chơi cuối game (end-game players):

- **Gia tăng thử thách**: Cấp độ của quái vật thường và quái tinh anh ngoài thế giới mở được nâng thêm khoảng 10 cấp. Kẻ địch thông thường có thể vượt mốc cấp độ 100 (lên đến cấp 103), khiến chỉ số máu và khả năng phòng thủ của chúng tăng mạnh.
- **Standard hóa phần thưởng**: Khi tiêu diệt Boss thế giới (Normal Bosses), hệ thống đảm bảo **rơi ra ít nhất 3 nguyên liệu đột phá** và có tối đa cơ hội nhận 4 nguyên liệu cho mỗi lần tiêu hao 40 Nhựa (so với tỷ lệ rơi ngẫu nhiên 2 hoặc 3 nguyên liệu cực kỳ mất cân bằng ở các cấp thế giới trước đó). Điều này giúp giảm đáng kể thời gian và lượng nhựa cần thiết để đột phá một nhân vật lên mốc cấp độ tối đa.

### Đột phá giới hạn cấp độ 100 (Level 100 Breakthrough) - Phiên bản 6.0+

Tại phiên bản 6.0, trò chơi giới thiệu tính năng đột phá giới hạn cấp độ nhân vật từ 90 lên cấp 100 thông qua một cơ chế vật phẩm đặc thù:

- **Vật phẩm Chòm Sao Vô Chủ (Masterless Stella Fortuna)**: Nguyên liệu duy nhất dùng để tăng giới hạn cấp độ. Vật phẩm này chỉ được tạo ra khi người chơi nhận được một bản sao của nhân vật 5 sao đã đạt tối đa Cung mệnh 6 (C6) từ tính năng gacha, hoặc thông qua các sự kiện tri ân lớn.
- **Yêu cầu tài nguyên thăng cấp**:

  - *Nâng giới hạn lên cấp 95*: Tiêu hao 1 Masterless Stella Fortuna.
  - *Nâng giới hạn lên cấp 100*: Tiêu hao thêm 2 Masterless Stella Fortuna.
  - *Lợi thế tài nguyên*: Sau khi đột phá giới hạn bằng vật phẩm này, người chơi có thể nâng cấp nhân vật lên cấp độ tiếp theo mà không cần tiêu tốn thêm bất kỳ Sách kinh nghiệm nhân vật hay Mora nào.

#### Đánh giá hiệu quả nâng cấp cấp độ 100

Việc thăng tiến từ cấp 90 lên cấp 100 được thiết kế để mang lại hiệu suất gia tăng sức mạnh có sự phân hóa rõ rệt giữa các nhóm nhân vật:

1. **Nhóm nhân vật gây sát thương trực tiếp (ATK-based)**: Nhận được ít giá trị cải thiện nhất. Thuộc tính cơ bản chỉ tăng nhẹ từ $7\%$ đến $8\%$, dẫn đến hiệu suất sát thương đầu ra thực tế chỉ tăng khoảng $3\% - 4\%$ do lượng ATK từ các hỗ trợ đồng đội đã bão hòa.
2. **Nhóm nhân vật kích hoạt phản ứng Biến đổi và phản ứng Lunar (Bloom, Swirl, v.v.)**: Nhận được lợi ích khổng lồ. Do sát thương phản ứng phụ thuộc hoàn toàn vào hệ số nhân cấp độ, việc nâng cấp từ 90 lên 100 giúp sát thương phản ứng tăng thẳng đứng thêm **$40.31\%$** (so với mốc tăng trưởng $34.28\%$ khi nâng từ cấp 80 lên 90).

## 6. Kỹ năng nhân vật và cơ chế tương tác chiến đấu

Mỗi nhân vật sở hữu một bộ kỹ năng (talents) chủ động gồm Tấn công thường (Normal/Charged/Plunging Attack), Kỹ năng Nguyên tố (Elemental Skill - nút E trên PC) và Kỹ năng Nộ (Elemental Burst - nút Q trên PC, tiêu hao năng lượng nguyên tố và có thời gian hồi chiêu dài).

### Các mô hình scale sát thương kỹ năng

Nhà phát triển phân tách kỹ năng nhân vật thành ba nhóm scale chính để định hình lối chơi chiến thuật:

1. **Scale theo chỉ số ATK truyền thống**: Đa số các nhân vật đời đầu sử dụng mô hình này. Sức mạnh đòn đánh tỷ lệ thuận với lượng ATK tổng. Nhóm này cực kỳ nhạy cảm với các nguồn buff ATK phẳng khổng lồ từ bên ngoài (như sân nộ của Bennett).
2. **Scale theo HP hoặc DEF tự thân**: Nhóm nhân vật này hoàn toàn bỏ qua chỉ số Base ATK và các hỗ trợ gia tăng ATK. Sát thương kỹ năng của họ được tính bằng một tỷ lệ phần trăm trực tiếp dựa trên HP tối đa (như Neuvillette, Furina) hoặc DEF tối đa của chính họ (như Linnea, Albedo).
3. **Scale lưỡng tính và tích hợp chỉ số đặc biệt**: Một số nhân vật được thiết kế để tự quy đổi thuộc tính này sang thuộc tính khác nhằm tạo ra lối build dị biệt.

### Ví dụ về các thiết kế kỹ năng phức tạp trong game

#### 1. Kỹ năng Nộ "Sóng Nước Ảo Ảnh" (Stellaris Phantasm) của Mona

Đây là một ví dụ điển hình về thiết kế kỹ năng chứa đựng nhiều tầng tương tác cơ học ẩn:

- **Cơ chế Bong Bóng Hư Vô (Illusory Bubble)**: Khi kích hoạt, Mona áp dụng trạng thái Bong Bóng lên kẻ địch, khóa chặt các mục tiêu có trọng lượng nhẹ trong trạng thái giam cầm (Struggle state).
- **Hiệu ứng Tinh Thần Omen (Omen)**: Kẻ địch chịu trạng thái Bong Bóng sẽ bị dính debuff Omen, tăng mạnh sát thương nhận vào từ mọi nguồn từ $42\%$ đến $60\%$.
- **Cơ chế kích nổ Bong Bóng**: Bong Bóng sẽ tự động vỡ và gây một lượng sát thương Thủy cực lớn ($442\% - 940\%$) khi kẻ địch phải nhận một đòn tấn công có Sát thương Phá thế (Poise Damage) lớn hơn 0.
- **Tương tác kéo dài Omen bằng phản ứng Đóng Băng**: Đây là đỉnh cao của việc tận dụng kẽ hở thiết kế để tạo chiến thuật. Kẻ địch bị đóng băng (Frozen) sẽ trở nên hoàn toàn miễn nhiễm với Poise Damage. Do đó, nếu người chơi áp dụng trạng thái Đóng Băng lên kẻ địch trước khi Mona dùng kỹ năng Nộ, các đòn tấn công tiếp theo sẽ gây sát thương xuyên qua quái vật mà không làm vỡ Bong Bóng. Thời gian đếm ngược của hiệu ứng tăng sát thương Omen sẽ bị hoãn lại cho đến khi quái vật tan băng và nổ bóng, kéo dài thời gian nhận buff sát thương thực tế lên tới 13 giây.

#### 2. Kỹ năng Nguyên tố "Điệp Hướng Vãng Sinh" (Guide to Afterlife) của Hu Tao

Kỹ năng này thể hiện rõ tư duy thiết kế giới hạn trần thuộc tính để tránh hiện tượng lạm phát chỉ số:

- Khi kích hoạt, Hu Tao tiêu hao một phần lượng HP hiện tại của bản thân để bước vào trạng thái Paramita Papilio.
- Trong trạng thái này, toàn bộ đòn đánh của cô chuyển thành sát thương nguyên tố Hỏa không thể bị ghi đè. Đồng thời, cô nhận được một lượng ATK cộng thêm cực lớn tương đương với tỷ lệ % dựa trên HP tối đa của bản thân ở thời điểm kích hoạt.
- **Giới hạn trần thiết kế (ATK Cap)**: Lượng ATK nhận được từ HP tối đa này **không được phép vượt quá mốc $400\%$ chỉ số Base ATK của chính Hu Tao** (gồm Base ATK nhân vật cộng với Base ATK của vũ khí đang trang bị). Cơ chế này ngăn chặn việc người chơi xây dựng một nhân vật có lượng HP quá khổng lồ (ví dụ trên 60,000 HP) để thu về lượng ATK vượt ngoài tầm kiểm soát của hệ thống cân bằng game.

## 7. Thiết kế kẻ địch và cơ chế kháng phòng ngự

Sự tương tác sát thương giữa người chơi và kẻ địch trong game được kiểm soát thông qua một hệ thống giảm trừ sát thương đa lớp.

### Công thức tính toán sát thương thực tế lên quái vật

Khi đòn tấn công của nhân vật chạm vào quái vật, lượng sát thương gốc (Base DMG) sẽ bị suy giảm thông qua các hệ số nhân sau:

$$\text{Sát thương thực tế} = \text{Base DMG} \times \text{Hệ số phòng thủ (DEF Multiplier)} \times \text{Hệ số kháng nguyên tố (RES Multiplier)}$$
[cite: 19, 34]

#### 1. Phân tích công thức Phòng thủ kẻ địch (DEF Multiplier)

Mọi kẻ địch trong trò chơi đều sở hữu một lượng phòng thủ tự nhiên tỉ lệ thuận với cấp độ của chúng:

$$\text{DEF}_{\text{Quái}} = 5 \times \text{Cấp độ quái} + 500$$
[cite: 83]

Hệ số phòng thủ thực tế làm giảm sát thương nhận vào của quái vật được tính toán chi tiết bằng công thức:

$$\text{DEF Multiplier} = \frac{\text{Cấp nhân vật} + 100}{(1 - \text{DEF}_{\text{ign}}) \times (1 - \text{DEF}_{\text{shred}}) \times (\text{Cấp quái} + 100) + (\text{Cấp nhân vật} + 100)}$$
[cite: 83]

- Nếu cấp độ của nhân vật và quái vật bằng nhau (ví dụ cùng cấp 90) và không có bất kỳ hiệu ứng giảm giáp nào áp dụng, hệ số DEF Multiplier sẽ luôn bằng đúng **$0.5$**. Nghĩa là, chỉ số phòng thủ tự nhiên của quái vật đã triệt tiêu trực tiếp $50\%$ sát thương đầu ra của người chơi.

#### 2. Phân tích công thức Kháng nguyên tố (RES Multiplier)

Mỗi loài quái vật được thiết kế với một lượng kháng nguyên tố và kháng vật lý mặc định khác nhau. Tùy thuộc vào giá trị kháng cuối cùng sau khi bị trừ đi bởi các kỹ năng giảm kháng (RES Shred), hệ số kháng được tính như sau:

- Nếu $\text{RES} < 0$: $\text{RES Multiplier} = 1 - \frac{\text{RES}}{2}$.
- Nếu $0 \le \text{RES} < 0.75$: $\text{RES Multiplier} = 1 - \text{RES}$.
- Nếu $\text{RES} \ge 0.75$: $\text{RES Multiplier} = \frac{1}{4 \times \text{RES} + 1}$.

### Bảng kháng nguyên tố mặc định của các nhóm quái vật tiêu biểu

Các nhóm quái vật được thiết kế với đặc trưng kháng nguyên tố rõ rệt để định hình chiến thuật chọn đội hình của người chơi:

| **Nhóm quái vật** | **Kháng vật lý** | **Kháng nguyên tố mặc định** | **Kháng nguyên tố đặc thù** | **Cơ chế giảm kháng đặc biệt** | 
| --- | --- | --- | --- | --- | 
| **Ruin Guard (Thủ vệ di tích)** [cite: 28] | $70\%$ [cite: 28] | $10\%$ [cite: 28] | Không có | Không có | 
| **Fatui Skirmisher (Binh sĩ Fatui)** [cite: 28] | $-20\%$ [cite: 28] | $10\%$ [cite: 28] | Không có | Tăng $+100\%$ kháng tất cả khi kích hoạt giáp nguyên tố | 
| **Treasure Hoarders (Trộm kho báu)** [cite: 28] | $-20\%$ [cite: 28] | $10\%$ [cite: 28] | Không có | Không có | 
| **Whopperflower (Hoa lừa dối)** [cite: 28] | $35\%$ [cite: 28] | $35\%$ [cite: 28] | $+40\%$ kháng nguyên tố trùng với hệ bản thân | Giảm $25\%$ toàn bộ kháng khi bị phá vỡ thanh gồng chiêu (choáng) | 

Sự phân bổ này cho thấy các quái vật cơ khí dòng Ruin Guard có lớp giáp sắt cực dày (kháng Vật lý lên tới $70\%$), buộc người chơi phải sử dụng phản ứng Siêu Dẫn (Superconduct) hoặc các đòn tấn công nguyên tố để hạ gục chúng một cách hiệu quả.

## 8. Tư duy thiết kế hệ thống và chiến lược cân bằng game

Tất cả các cơ chế chỉ số, nguyên tố, và trang bị trong trò chơi được tích hợp chặt chẽ nhằm giải quyết bài toán lớn nhất của các tựa game dịch vụ vận hành trực tuyến: **Ngăn chặn triệt để hiện tượng lạm phát chỉ số (Powercreep) nhưng vẫn kích thích người chơi liên tục chi tiền chiêu mộ nhân vật mới**.

### Chiến lược phá vỡ thế độc tôn của chỉ số ATK và nhân vật hỗ trợ Bennett

Trong giai đoạn đầu phát triển game, các nhà thiết kế đã phạm phải một sai lầm cân bằng lớn khi tạo ra nhân vật hỗ trợ Bennett. Với khả năng cung cấp một lượng lớn ATK phẳng dựa trên Base ATK vũ khí thông qua kỹ năng Nộ, Bennett khiến toàn bộ các nhân vật gây sát thương scale theo ATK trở nên quá mạnh mẽ, đồng thời bóp nghẹt sự đa dạng của các đội hình hỗ trợ khác.

Để giải quyết triệt để vấn đề này mà không cần trực tiếp giảm sức mạnh (nerf) nhân vật (hành vi tối kỵ trong các trò chơi gacha do rủi ro pháp lý và sự phẫn nộ của cộng đồng), nhà phát triển đã thay đổi hoàn toàn trục thiết kế thuộc tính từ phiên bản 2.0 trở đi:

- **Tạo ra các hệ số scale độc lập**: Họ liên tục giới thiệu các nhân vật gây sát thương chủ lực scale hoàn toàn theo HP (như Neuvillette, Furina) hoặc DEF (như Itto, Chiori, Linnea). Do các nhân vật này không nhận bất kỳ lợi ích nào từ chỉ số ATK, việc mang theo Bennett trong đội hình trở nên vô nghĩa.
- **Thiết kế hỗ trợ chuyên biệt (Niche Supports)**: Thay vì tạo ra các hỗ trợ vạn năng tăng ATK, hệ thống giới thiệu các hỗ trợ chuyên sâu cho các trục thuộc tính mới, ví dụ như Gorou chỉ gia tăng DEF cho hệ Nham, hay các thánh di vật tăng trực tiếp HP%. Điều này giúp đa dạng hóa lối chơi và mở ra hàng loạt trục xây dựng đội hình hoàn toàn mới.

### Cơ chế "Sức mạnh vay mượn" (Borrowed Power) để kiểm soát vòng đời nhân vật

Một tư duy thiết kế xuất sắc khác của trò chơi là việc áp dụng cơ chế "Sức mạnh vay mượn" gắn liền với đặc trưng của từng quốc gia:

- **Hệ thống Nightsoul và Phlogiston tại Natlan (Phiên bản 5.x)**: Mang lại khả năng cơ động thám hiểm vượt trội cho các nhân vật bản địa. Tuy nhiên, năng lượng Phlogiston dùng để duy trì trạng thái di chuyển đặc biệt này chỉ có thể được sạc và sử dụng trong phạm vi bản đồ vùng đất Natlan. Khi người chơi mang các nhân vật này vào các phụ bản hoặc La Hoàn Thâm Cảnh, hiệu năng của chúng tự động được đưa về mốc cân bằng tiêu chuẩn.
- **Hệ thống Moonsign tại Nod-Krai (Phiên bản 6.x)**: Hệ thống Moonsign (Nascent Gleam và Ascendant Gleam) yêu cầu đội hình phải sở hữu các nhân vật bản địa của Nod-Krai để kích hoạt tối đa sức mạnh của hệ phản ứng mới Lunar Reactions.

Lối thiết kế này giúp nhà phát triển liên tục tạo ra cảm giác mới mẻ và động lực chiêu mộ nhân vật mới cho mỗi chu kỳ cập nhật lớn mà hoàn toàn không làm xáo trộn hay lỗi thời hóa sức mạnh của các nhân vật cũ ở các vùng đất trước đó.

## 9. Phân tích tâm lý học hành vi và vòng lặp phản hồi Dopamine

Sự thành công vượt bậc về mặt doanh thu của trò chơi được củng cố bởi một hệ thống bẫy tâm lý học hành vi cực kỳ tinh vi, biến trò chơi thành một chiếc "máy sưởi Dopamine" đối với người chơi.

### Thuyết nhạy cảm khuyến khích (Incentive-Sensitization Theory): "Wanting" và "Liking"

Trong nghiên cứu thần kinh học hiện đại về chứng nghiện, dopamine không phải là chất tạo ra cảm giác thỏa mãn khi đạt được mục tiêu (Liking), mà là **chất kích thích sự thèm khát, tò mò và định hướng hành vi tìm kiếm phần thưởng trước khi nó xảy ra (Wanting)**.

Hệ thống Gacha của trò chơi được xây dựng như một công cụ tối ưu hóa tối đa hệ thống "Wanting" này:

- **Tạo ra các gợi ý kích thích (Cue-triggered Wanting)**: Các banner nhân vật giới hạn được thiết kế với hình ảnh chuyển động rực rỡ, nhạc nền độc quyền kích thích thính giác, và cốt truyện nhân vật sâu sắc. Khi người chơi nhìn thấy các gợi ý này, não bộ lập tức giải phóng một lượng lớn dopamine dự báo, tạo ra một cơn sóng "thèm khát" sở hữu nhân vật.
- **Sự phân rã của cảm giác thỏa mãn**: Khi người chơi rút thành công nhân vật (đạt được Liking), hệ thống dopamine sẽ nhanh chóng sụt giảm về trạng thái bão hòa sau vài ngày sử dụng. Sự thèm khát (Wanting) nhanh chóng được tái định hướng sang nhân vật giới hạn tiếp theo ở phiên bản kế tiếp, duy trì một vòng lặp chi tiêu không bao giờ kết thúc.

### Các bẫy hành vi củng cố tỷ lệ biến đổi (Variable Ratio Reinforcement Schedules)

- **Lịch trình củng cố tỷ lệ biến đổi**: Đây là cơ chế tâm lý cốt lõi đứng sau máy đánh bạc (slot machines) tại các sòng bạc. Người chơi không bao giờ biết chính xác lượt quay nào sẽ trúng thưởng, nhưng họ biết chắc chắn phần thưởng tồn tại. Việc trò chơi thiết kế tỷ lệ rơi ngẫu nhiên các dòng phụ của thánh di vật hoạt động chính xác theo cơ chế này. Người chơi tiếp tục tiêu tốn Nhựa mỗi ngày với niềm tin: *"Lần chạy bí cảnh tiếp theo rất có thể sẽ rơi ra chiếc ly sát thương nguyên tố hoàn hảo"*.
- **Hiệu ứng Chi phí chìm (Sunk Cost Fallacy)**: Việc giới hạn thể lực Nhựa hàng ngày buộc người chơi phải đăng nhập game đều đặn để tiêu thụ, tránh lãng phí. Việc đăng nhập lặp đi lặp lại này, kết hợp với cơ chế cộng dồn bảo hiểm gacha truyền đời qua các banner, khiến người chơi tích lũy một lượng lớn "chi phí chìm" về mặt thời gian và công sức vào tài khoản. Khi một người chơi đã gắn bó liên tục trong 2 năm, rào cản tâm lý ngăn cản họ từ bỏ trò chơi trở nên cực kỳ vững chắc, vì bộ não của họ coi việc dừng lại là một sự thừa nhận thất bại và lãng phí toàn bộ nỗ lực trong quá khứ.

## 10. Tổng hợp cập nhật và xu hướng vận hành phiên bản mới nhất

Tính đến phiên bản cập nhật lớn mới nhất (phiên bản 6.0 và 6.1 tại vùng đất Nod-Krai), các nhà thiết kế đã thực hiện một cuộc cải tổ toàn diện về mặt meta chiến đấu và tiến trình nhân vật nhằm định hình lại lối chơi.

### Cơ chế Moonsign và hệ phản ứng Lunar Reactions

Tại khu vực mới Nod-Krai, trò chơi chính thức giới thiệu cơ chế **Moonsign** tích hợp sâu vào sơ đồ đội hình:

- **Nascent Gleam (Trạng thái trăng non)**: Kích hoạt khi đội hình sở hữu duy nhất 1 nhân vật thuộc khu vực Nod-Krai.
- **Ascendant Gleam (Trạng thái trăng rằm)**: Kích hoạt khi đội hình sở hữu từ 2 nhân vật thuộc khu vực Nod-Krai trở lên. Trạng thái này tự động bao hàm và khuếch đại các hiệu ứng của Nascent Gleam.

Các nhân vật Nod-Krai mới như **Lauma** (5 sao hệ Thảo, sở hữu khả năng độc quyền chuyển đổi phản ứng Sum Suê thông thường thành phản ứng Lunar-Bloom mạnh mẽ) và **Flins** (5 sao hệ Lôi, sử dụng Polearm) được thiết kế để trở thành các nhân vật gánh đội (carries) tận dụng tối đa cơ chế này.

### Phân tích hai bộ thánh di vật mới trong phiên bản 6.0/6.1

Để bổ trợ trực tiếp cho hệ phản ứng Mặt Trăng mới, hai bộ thánh di vật 5 sao mới đã được thêm vào các bí cảnh của Nod-Krai:

#### 1. Bộ thánh di vật "Khúc Ca Ánh Trăng Bạc" (Silken Moon's Serenade)

- **Hiệu ứng 2 mảnh**: Tăng $+20\%$ Hiệu quả nạp nguyên tố.
- **Hiệu ứng 4 mảnh**: Sau khi nhân vật trang bị gây sát thương nguyên tố lên kẻ địch, kích hoạt trạng thái Gleaming Moon: Devotion trong 8 giây: tăng thêm $60$ điểm Tinh thông nguyên tố (ở trạng thái Nascent Gleam) hoặc $120$ điểm Tinh thông nguyên tố (ở trạng thái Ascendant Gleam) cho toàn bộ thành viên trong đội.
- **Tác động vĩ mô**: Hiệu ứng này có thể kích hoạt ngay cả khi nhân vật trang bị đang ở ngoài sân (off-field), biến nó trở thành bộ trang bị trấn phái bắt buộc cho các nhân vật hỗ trợ phản ứng như Lauma hay Aino. Đồng thời, mỗi hiệu ứng Gleaming Moon khác nhau hiện diện trong đội hình sẽ tăng thêm $+10\%$ sát thương cho các phản ứng Lunar Reactions.

#### 2. Bộ thánh di vật "Bầu Trời Khai Mở" (Night of the Sky's Unveiling)

- **Hiệu ứng 2 mảnh**: Tăng $+80$ điểm Tinh thông nguyên tố.
- **Hiệu ứng 4 mảnh**: Khi đồng đội kích hoạt phản ứng Lunar Reactions, nếu nhân vật trang bị đang đứng trên sân (on-field), họ sẽ nhận trạng thái Gleaming Moon: Intent trong 4 giây: tăng thêm $15\%$ CRIT Rate (ở trạng thái Nascent Gleam) hoặc **$30\%$ CRIT Rate** (ở trạng thái Ascendant Gleam).
- **Tác động vĩ mô**: Việc cung cấp tới $30\%$ CRIT Rate miễn phí giúp người chơi giảm bớt áp lực cực lớn khi phải cày cuốc các dòng phụ chí mạng trên trang bị, dọn đường cho việc xây dựng các nhân vật thuần sát thương phản ứng chí mạng như Flins.

### Đánh giá tổng quan dành cho nhà phát triển game thế hệ mới

Từ góc độ thiết kế trò chơi (game design), sự thăng tiến cơ học của *Genshin Impact* từ phiên bản 1.0 đến nay mang lại những bài học kinh nghiệm sâu sắc cho bất kỳ dự án game nhập vai nào:

- **Không bao giờ thiết kế các hỗ trợ tăng thuộc tính vạn năng quá mạnh** ngay từ giai đoạn đầu, tránh việc bóp nghẹt không gian sáng tạo của các nhân vật phát hành sau này.
- **Sử dụng lý thuyết Gauge và hệ thống ICD** làm chiếc phanh hãm tự nhiên để điều tiết tần suất xuất hiện sát thương lớn, buộc người chơi phải suy nghĩ về thứ tự combo chiêu thức thay vì chỉ bấm loạn xạ nút kỹ năng.
- **Áp dụng cơ chế "Sức mạnh vay mượn" theo vùng miền** để liên tục làm mới trải nghiệm chơi và kích thích doanh thu gacha mà hoàn toàn không bị rơi vào cái bẫy lạm phát chỉ số của các dòng game RPG truyền thống.