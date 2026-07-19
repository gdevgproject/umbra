# Báo Cáo Nghiên Cứu Kỹ Thuật: Hệ Thống Thuộc Tính Nhân Vật, Vòng Tuần Hoàn Nguyên Tố và Logic Toán Học Cân Bằng Chiến Đấu Trong Game ARPG

## Chương 1: Hệ thống chỉ số sức mạnh và logic tiến trình

### 1. Danh sách các chỉ số cốt lõi và vai trò trong hệ thống ARPG

Trong thiết kế hệ thống chiến đấu của một trò chơi nhập vai hành động (ARPG) hiện đại, hệ thống chỉ số là nền tảng định hình lối chơi, phân loại phân lớp nhân vật (Class), và tạo động lực phát triển dài hạn cho người chơi. Mối quan hệ tương tác giữa các thuộc tính cốt lõi tạo ra một ma trận cân bằng động, giúp ngăn chặn tình trạng một chỉ số duy nhất thống trị toàn bộ meta-game.

| **Ký hiệu** | **Tên thuộc tính** | **Mô tả và vai trò thiết kế** | **Cơ chế tương tác** | 
| --- | --- | --- | --- | 
| $HP$ | Sinh mệnh (Health Points) | Đo lường ngưỡng chịu đựng sát thương tối đa của thực thể trước khi tử vong. | Tương tác trực tiếp với khả năng hồi phục, các kỹ năng tạo lá chắn, và là hệ số tỷ lệ cho một số nhân vật phân lớp Đỡ đòn (Tanker). | 
| $ATK$ | Sức tấn công (Attack Power) | Giá trị cơ sở để tính toán lượng sát thương đầu ra của hầu hết các kỹ năng vật lý và nguyên tố. | Kết hợp với hệ số kỹ năng (Talent Scaling) để tạo thành Sát thương cơ bản (Base Damage). | 
| $DEF$ | Phòng thủ (Defense) | Giảm thiểu lượng sát thương gánh chịu từ các đòn tấn công của kẻ địch. | Chuyển đổi thành Hệ số giảm trừ sát thương phi tuyến tính dựa trên cấp độ tương đối giữa kẻ tấn công và mục tiêu. | 
| $CR$ | Tỷ lệ chí mạng (Crit Rate) | Xác suất một đòn đánh kích hoạt trạng thái sát thương chí mạng. | Bị giới hạn trần toán học ở mức $100\%$ ($1.0$). Vượt quá giới hạn này sẽ gây lãng phí tài nguyên thuộc tính. | 
| $CD$ | Sát thương chí mạng (Crit DMG) | Lượng sát thương gia tăng thêm khi đòn đánh chí mạng được kích hoạt thành công. | Hoạt động như một hệ số nhân độc lập áp dụng trực tiếp lên Sát thương cơ bản. | 
| $SPD$ | Tốc độ (Speed) | Bao gồm Tốc độ di chuyển (Movement Speed) và Tốc độ tấn công (Attack Speed). | Ảnh hưởng trực tiếp đến nhịp độ chiến đấu (Tempo), khung bất tử (I-frames) khi né tránh, và tần suất kích hoạt đòn đánh. | 
| $PEN$ | Xuyên giáp (Penetration) | Khả năng bỏ qua một lượng tuyệt đối hoặc tỷ lệ phần trăm chỉ số phòng thủ ($DEF$) của mục tiêu. | Giảm trừ hiệu quả phòng ngự của kẻ địch trước khi áp dụng hệ số phòng thủ toán học. | 
| $Vamp$ | Hút máu (Lifesteal) | Tỷ lệ phần trăm sát thương gây ra được chuyển hóa thành trị số hồi phục $HP$ cho bản thân. | Phụ thuộc vào loại sát thương (sát thương đơn mục tiêu hiệu quả cao hơn sát thương diện rộng AoE để tránh lạm phát hồi phục). | 
| $EM$ | Tinh thông nguyên tố (Elemental Mastery) | Chỉ số đặc thù gia tăng hiệu quả và sát thương của các phản ứng nguyên tố. | Tăng hiệu suất sát thương theo đồ thị logarithmic để tránh tình trạng gia tăng sức mạnh quá mức ở giai đoạn cuối game. | 

Sự cân bằng giữa các thuộc tính này được duy trì thông qua các trục đối nghịch kinh điển: $HP/DEF$ đối kháng trực tiếp với $ATK/PEN$, trong khi bộ đôi $CR/CD$ đóng vai trò là chất xúc tác khuếch đại sát thương theo cấp số nhân khi người chơi đạt đến ngưỡng trang bị trung và cao cấp.

### 2. Logic tiến trình lên cấp (Level-up Progression)

#### Công thức toán học tính lượng Kinh nghiệm cần có (XP Curve Formula)

Để kiểm soát tốc độ tiến trình của người chơi, lượng kinh nghiệm cần thiết để tăng cấp từ cấp độ $L$ lên cấp độ $L+1$ được thiết kế dưới dạng hàm đa thức kết hợp mũ phi tuyến tính:

$$XP(L) = \text{Base\_XP} \times \left( \gamma \cdot L^{\alpha} + (1 - \gamma) \cdot \beta^{L-1} \right)$$
[cite: 13]

Trong đó:

- $XP(L)$ là lượng kinh nghiệm yêu cầu để vượt qua cấp độ $L$.
- $\text{Base\_XP}$ là lượng kinh nghiệm cơ sở tại cấp độ 1 (ví dụ: $\text{Base\_XP} = 1000$).
- $\alpha$ là hệ số đa thức kiểm soát tốc độ tăng trưởng ở giai đoạn đầu và giữa game (thường đặt $\alpha \in [2.0, 3.0]$).
- $\beta$ là cơ số mũ tạo ra bức tường kinh nghiệm ở giai đoạn cuối game nhằm kéo dài vòng đời nội dung (thường đặt $\beta \in [1.05, 1.15]$).
- $\gamma$ là trọng số điều phối giữa hai mô hình tăng trưởng ($\gamma \in [0, 1]$).

Với cấu trúc này, khi người chơi ở cấp độ thấp ($L$ nhỏ), thành phần đa thức $L^{\alpha}$ sẽ chiếm ưu thế, mang lại cảm giác lên cấp nhanh chóng, kích thích hormone dopamine. Khi bước vào giai đoạn cuối game ($L$ lớn), thành phần mũ $\beta^{L-1}$ bắt đầu bùng nổ, kéo giãn thời gian cày cuốc một cách có kiểm soát.

Bảng dưới đây minh họa sự phát triển của chuỗi kinh nghiệm yêu cầu từ cấp 1 đến 90 dựa trên các thông số cấu hình tiêu chuẩn: $\text{Base\_XP} = 1000$, $\gamma = 0.6$, $\alpha = 2.5$, $\beta = 1.12$.

| **Cấp độ (L)** | **Thành phần đa thức (0.6×L2.5)** | **Thành phần mũ (0.4×1.12L−1)** | **Hệ số tổng** | **Lượng kinh nghiệm yêu cầu (XP(L))** | 
| --- | --- | --- | --- | --- | 
| $1$ | $0.60$ | $0.40$ | $1.00$ | $1,000$ | 
| $10$ | $189.74$ | $1.11$ | $190.85$ | $190,850$ | 
| $20$ | $1,073.31$ | $3.44$ | $1,076.75$ | $1,076,750$ | 
| $40$ | $6,071.24$ | $33.24$ | $6,104.48$ | $6,104,480$ | 
| $60$ | $16,730.81$ | $321.14$ | $17,051.95$ | $17,051,950$ | 
| $80$ | $34,348.22$ | $3,102.13$ | $37,450.35$ | $37,450,350$ | 
| $90$ | $45,955.41$ | $9,636.52$ | $55,591.93$ | $55,591,930$ | 

#### Mô hình tăng trưởng 1: Tự động tăng chỉ số theo hệ số tăng trưởng Class

Mỗi Class nhân vật sở hữu một bộ hệ số tăng trưởng riêng biệt phản ánh bản sắc của Class đó. Chỉ số $Stat$ của một thuộc tính tại cấp độ $L$ được tính toán theo công thức:

$$Stat(L) = Stat_{\text{Base}} + \theta_{\text{Class}} \times (L - 1)^{\delta}$$
Trong đó:

- $Stat_{\text{Base}}$ là trị số thuộc tính khởi đầu tại cấp độ 1.
- $\theta_{\text{Class}}$ là hệ số tăng trưởng đặc trưng của Class.
- $\delta$ là tham số phi tuyến tính hóa tiến trình tăng trưởng của chỉ số (thường đặt $\delta \in [1.0, 1.15]$ để tạo ra sự tăng trưởng nhẹ về hiệu suất khi cấp độ tăng cao).

Bảng dưới đây quy định chi tiết các hệ số tăng trưởng của ba lớp nhân vật chính với $\delta = 1.05$:

| **Thuộc tính Class** | **Chiến binh (Warrior)** | **Pháp sư (Mage)** | **Sát thủ (Assassin)** | 
| --- | --- | --- | --- | 
| $HP_{\text{Base}}$ | $1500$ | $1000$ | $1200$ | 
| $\theta_{HP}$ | $220.0$ | $150.0$ | $180.0$ | 
| $ATK_{\text{Base}}$ | $120$ | $150$ | $140$ | 
| $\theta_{ATK}$ | $12.0$ | $18.0$ | $15.0$ | 
| $DEF_{\text{Base}}$ | $80$ | $50$ | $60$ | 
| $\theta_{DEF}$ | $8.0$ | $5.0$ | $6.0$ | 

Sử dụng các thông số trên để tính toán chỉ số cho một Chiến binh tại cấp độ $90$:

$$HP(90) = 1500 + 220.0 \times (90 - 1)^{1.05} \approx 1500 + 220.0 \times 111.45 \approx 26,019$$$$ATK(90) = 120 + 12.0 \times (90 - 1)^{1.05} \approx 120 + 12.0 \times 111.45 \approx 1,457$$$$DEF(90) = 80 + 8.0 \times (90 - 1)^{1.05} \approx 80 + 8.0 \times 111.45 \approx 971$$
#### Mô hình tăng trưởng 2: Phân bổ Điểm Tiềm Năng tự do (Stat Points Allocation)

Mô hình này cấp cho người chơi một lượng Điểm Tiềm Năng cố định $N_{\text{point}}$ mỗi khi lên cấp để tự do phân bổ vào các thuộc tính cốt lõi.

- **Ưu điểm**: Tối ưu hóa tính cá nhân hóa và khả năng tùy biến lối chơi (Player Agency). Người chơi có thể tự do thử nghiệm các hướng phát triển độc đáo như "Sát thủ né tránh" hoặc "Đỡ đòn phản sát thương".
- **Nhược điểm**: Gây khó khăn cực lớn cho công tác cân bằng chiến đấu. Người chơi có xu hướng tối ưu hóa toán học bằng cách dồn toàn bộ $100\%$ điểm vào một chỉ số tối ưu duy nhất (thường là $ATK$ cho các lớp nhân vật gây sát thương hoặc $HP$ cho các lớp nhân vật chống chịu), dẫn đến việc phá vỡ cấu trúc thử thách của phụ bản (Dungeon).

#### Cơ chế kìm hãm lạm phát bằng công thức hiệu suất giảm dần (Diminishing Returns)

Để ngăn chặn hành vi dồn điểm cực đoan, hệ thống áp dụng cơ chế Hiệu suất giảm dần thông qua hàm tiệm cận dưới dạng toán học Hyperbolic để chuyển đổi điểm tiềm năng thô thành tỷ lệ phần trăm hiệu quả thực tế:

$$Stat_{\text{Effective}}(x) = \text{Cap} \times \frac{x}{x + K}$$
[cite: 14]

Trong đó:

- $x$ là tổng số điểm tiềm năng thô mà người chơi đã đầu tư vào thuộc tính đó.
- $Stat_{\text{Effective}}(x)$ là tỷ lệ phần trăm hiệu quả thực tế nhận được (ví dụ: Tỷ lệ chí mạng, Tỷ lệ giảm sát thương).
- $\text{Cap}$ là giới hạn trần toán học mà chỉ số này có thể đạt được ($\text{Cap} < 1.0$ hoặc $100\%$).
- $K$ là hằng số bán bão hòa (Half-saturation constant), biểu thị số điểm thô cần thiết để đạt được $50\%$ giá trị $\text{Cap}$.

**Trường hợp số liệu thực tế (Case study)**: Thiết kế hệ thống Tỷ lệ chí mạng ($CR$) với giới hạn tối đa là $40\%$ ($\text{Cap} = 0.40$). Nhà thiết kế mong muốn rằng tại mốc đầu tư $x = 100$ điểm tiềm năng, người chơi sẽ đạt được tỷ lệ chí mạng thực tế là $35\%$ ($0.35$).

Để xác định hằng số phản hồi $K$ của hệ thống, phương trình được thiết lập và giải như sau:

$$0.35 = 0.40 \times \frac{100}{100 + K} \implies \frac{100}{100 + K} = 0.875 \implies 100 + K = 114.29 \implies K \approx 14.29$$
[cite: 14]

Bảng dưới đây thể hiện mối quan hệ phi tuyến tính giữa điểm đầu tư thô $x$ và tỷ lệ hiệu quả thực tế nhận được khi áp dụng $K = 14.29$:

| **Điểm tiềm năng thô (x)** | **Tỷ lệ chí mạng thực tế (StatEffective​(x))** | **Tăng trưởng biên (Hiệu suất trên mỗi điểm)** | 
| --- | --- | --- | 
| $0$ | $0.00\%$ | N/A | 
| $10$ | $16.47\%$ | $1.647\%$ | 
| $50$ | $31.11\%$ | $0.366\%$ | 
| $100$ | $35.00\%$ | $0.078\%$ | 
| $200$ | $37.33\%$ | $0.023\%$ | 
| $500$ | $38.89\%$ | $0.005\%$ | 

Đồ thị tăng trưởng này chứng minh rằng việc dồn điểm quá mức từ mốc $100$ lên $500$ chỉ đem lại thêm $3.89\%$ tỷ lệ thực tế, buộc người chơi phải tự phân bổ lại điểm sang các thuộc tính khác để tối ưu hóa tổng thể sức mạnh chiến đấu.

## Chương 2: Toàn diện về hệ thống 7 nguyên tố và ma trận phản ứng

### 1. Vòng tròn khắc chế nguyên tố hoàn chỉnh (7 Hệ)

Hệ thống nguyên tố bao gồm 7 hệ cốt lõi: Hỏa (Pyro), Thủy (Hydro), Lăng/Băng (Cryo), Lôi (Electro), Phong (Anemo), Nham (Geo), và Thảo (Dendro). Quy luật tương tác được xây dựng dựa trên nguyên lý tuần hoàn khép kín đối với nhóm nguyên tố chủ động và cơ chế bổ trợ/chuyển hóa đối với nhóm nguyên tố thụ động.

```
[Thủy (Hydro)]
               /            \
              v              v
       [Hỏa (Pyro)]     [Lôi (Electro)]
            |                  |
            v                  v
       [Băng (Cryo)]    [Thảo (Dendro)]
            \                  /
             v                v
             [Băng (Cryo)] <--- (Khắc chế vòng ngoài)
```

Quy định tỷ lệ giảm giáp nguyên tố (RES Shred) và gia tăng sát thương cơ bản (%) khi xảy ra các đòn tấn công khắc chế được chi tiết hóa trong bảng dưới đây:

| **Nguyên tố tấn công** | **Nguyên tố mục tiêu** | **Trạng thái phản ứng** | **Sát thương tăng thêm (%)** | **Giảm kháng nguyên tố mục tiêu (RES Shred)** | 
| --- | --- | --- | --- | --- | 
| Thủy (Hydro) | Hỏa (Pyro) | Vaporize Thuận (Forward) | $+100.0\%$ (Hệ số $2.0x$) | Không | 
| Hỏa (Pyro) | Thủy (Hydro) | Vaporize Nghịch (Reverse) | $+50.0\%$ (Hệ số $1.5x$) | Không | 
| Hỏa (Pyro) | Băng (Cryo) | Melt Thuận (Forward) | $+100.0\%$ (Hệ số $2.0x$) | Không | 
| Băng (Cryo) | Hỏa (Pyro) | Melt Nghịch (Reverse) | $+50.0\%$ (Hệ số $1.5x$) | Không | 
| Lôi (Electro) | Thủy (Hydro) | Electro-Charged | Sát thương duy trì theo thời gian (DoT) liên tục giật giữa các mục tiêu gần nhau. | Không | 
| Thảo (Dendro) | Lôi (Electro) | Quicken/Catalyze | Tạo trạng thái suy yếu nguyên tố nền. | $-15.0\%$ Kháng Lôi và Kháng Thảo | 
| Băng (Cryo) | Lôi (Electro) | Superconduct | Sát thương diện rộng nguyên tố Băng. | $-40.0\%$ Kháng Vật lý của mục tiêu | 
| Phong (Anemo) | Bất kỳ (Trừ Nham) | Swirl (Khuếch tán) | Khuếch tán nguyên tố bị ảnh hưởng ra phạm vi xung quanh. | $-40.0\%$ Kháng nguyên tố bị khuếch tán (yêu cầu trang bị kích hoạt cụ thể). | 
| Nham (Geo) | Bất kỳ (Trừ Phong) | Crystallize (Kết tinh) | Tạo ra mảnh tinh thể nguyên tố tương ứng. | Nhận lá chắn hấp thụ sát thương nguyên tố đó với hiệu quả tăng $250\%$. | 

### 2. Ma trận kết hợp nguyên tố (Elemental Reaction Matrix)

Ma trận kết hợp nguyên tố dưới đây liệt kê chi tiết toàn bộ các trường hợp phản ứng xảy ra khi kết hợp các nguyên tố từ 2 đến 3 thành phần:

| **Tên phản ứng** | **Các nguyên tố tham gia** | **Phân nhóm phản ứng** | **Hệ số cơ sở** | **Cơ chế tác động chi tiết** | 
| --- | --- | --- | --- | --- | 
| **Vaporize (Thuận)** | Thủy (Aura) $\rightarrow$ Hỏa (Trigger) | Tăng cường (Amplifying) | $2.0$ [cite: 17, 21] | Nhân trực tiếp sát thương của đòn đánh kích hoạt bằng 2. Tiêu thụ lượng lớn ấn nguyên tố. | 
| **Vaporize (Nghịch)** | Hỏa (Aura) $\rightarrow$ Thủy (Trigger) | Tăng cường (Amplifying) | $1.5$ [cite: 17, 21] | Nhân trực tiếp sát thương kích hoạt bằng 1.5. Tiêu thụ ít ấn nền hơn, dễ duy trì phản ứng liên tục. | 
| **Melt (Thuận)** | Băng (Aura) $\rightarrow$ Hỏa (Trigger) | Tăng cường (Amplifying) | $2.0$ [cite: 17, 21] | Khuếch đại sát thương đòn đánh Hỏa trúng mục tiêu đính kèm Băng. | 
| **Melt (Nghịch)** | Hỏa (Aura) $\rightarrow$ Băng (Trigger) | Tăng cường (Amplifying) | $1.5$ [cite: 17, 21] | Khuếch đại sát thương đòn đánh Băng trúng mục tiêu đính kèm Hỏa. | 
| **Overloaded** | Hỏa + Lôi | Biến đổi (Transformative) | $2.75$ [cite: 16, 22] | Gây nổ Hỏa diện rộng phá giáp nặng, hất văng mục tiêu trong bán kính 5m. | 
| **Electro-Charged** | Thủy + Lôi | Biến đổi (Transformative) | $2.0$ [cite: 22, 25] | Gây sát thương Lôi liên tục lên mục tiêu và lan truyền sang kẻ địch xung quanh bị ướt. | 
| **Superconduct** | Băng + Lôi | Biến đổi (Transformative) | $1.5$ [cite: 16, 22] | Gây sát thương Băng diện rộng, giảm 40% kháng vật lý của kẻ địch trong 12 giây. | 
| **Bloom** | Thảo + Thủy | Biến đổi (Transformative) | $2.0$ [cite: 22] | Sinh ra hạt nhân Thảo trên sân đấu tồn tại tối đa 6 giây (giới hạn tối đa 5 hạt). | 
| **Hyperbloom** | Thảo + Thủy + Lôi | Biến đổi (Transformative) | $3.0$ [cite: 22] | Áp dụng thuộc tính Lôi vào hạt nhân Thảo, chuyển hóa nó thành tiễn tầm nhiệt tự tìm mục tiêu. | 
| **Burgeon** | Thảo + Thủy + Hỏa | Biến đổi (Transformative) | $3.0$ [cite: 22] | Áp dụng thuộc tính Hỏa kích nổ hạt nhân Thảo ngay lập tức, gây sát thương Thảo diện rộng. | 
| **Swirl** | Phong + (Hỏa/Thủy/Băng/Lôi) | Biến đổi (Transformative) | $0.6$ [cite: 22] | Khuếch tán ấn nguyên tố hiện tại của mục tiêu ra diện rộng, gây thêm sát thương phản ứng phụ. | 
| **Burning** | Thảo + Hỏa | Biến đổi (Transformative) | $0.25$ [cite: 22] | Gây sát thương Hỏa liên tục theo chu kỳ cực nhanh và liên tục tái áp dụng ấn Hỏa mạnh. | 
| **Crystallize** | Nham + (Hỏa/Thủy/Băng/Lôi) | Khống chế / Đa dụng | N/A | Tạo tinh thể nguyên tố tương ứng, khi nhặt sẽ cung cấp lá chắn hấp thụ sát thương. | 
| **Frozen** | Thủy + Băng | Khống chế / Đa dụng | N/A | Đóng băng mục tiêu tạm thời, chặn hoàn toàn mọi hành vi di chuyển và tấn công. | 
| **Shatter** | Đóng băng + Đòn đánh nặng | Biến đổi (Transformative) | $3.0$ [cite: 22] | Phá vỡ trạng thái đóng băng ngay lập tức để gây một lượng lớn sát thương vật lý độc lập. | 

#### Nhóm phản ứng Tăng cường (Khuếch đại sát thương)

Nhóm này bao gồm Melt (Tan chảy) và Vaporize (Bốc hơi). Cơ chế này không tạo ra nguồn sát thương mới mà nhân trực tiếp vào sát thương của đòn đánh kích hoạt.

$$\text{DMG}_{\text{Amplifying}} = \text{Base\_DMG} \times M_{\text{Reaction}} \times \left(1 + F_{\text{EM}} + \text{Reaction\_Bonus}\right)$$
[cite: 5]

Trong đó:

- $\text{Base\_DMG}$ là sát thương chưa tính hệ số phản ứng.
- $M_{\text{Reaction}}$ là Hệ số phản ứng gốc. $M_{\text{Reaction}} = 2.0$ cho các phản ứng Thuận (Thủy tác động lên Hỏa; Hỏa tác động lên Băng) và $M_{\text{Reaction}} = 1.5$ cho các phản ứng Nghịch (Hỏa tác động lên Thủy; Băng tác động lên Hỏa).
- $F_{\text{EM}}$ là tỷ lệ phần trăm gia tăng từ chỉ số Tinh thông nguyên tố ($EM$):

$$F_{\text{EM}} = \frac{2.78 \times EM}{1400 + EM}$$
[cite: 5]

- $\text{Reaction\_Bonus}$ là lượng sát thương tăng thêm từ hiệu ứng bộ trang bị (ví dụ: $+15\%$ sát thương phản ứng).

*Logic thiết kế*: Hệ số $2.0x$ (Thuận) tiêu thụ lượng ấn nguyên tố trên mục tiêu rất nhanh, khiến việc duy trì chuỗi phản ứng liên tục khó khăn hơn. Ngược lại, hệ số $1.5x$ (Nghịch) chỉ tiêu thụ một lượng nhỏ ấn nguyên tố, cho phép người chơi thiết lập chuỗi phản ứng liên tục với tần suất cực cao, đảm bảo tính cân bằng về sát thương tổng thể theo thời gian (DPS).

#### Nhóm phản ứng Biến đổi (Sát thương độc lập, bỏ qua phòng thủ)

Đặc trưng cốt lõi của nhóm này là bỏ qua hoàn toàn chỉ số phòng thủ ($DEF$) của kẻ địch, không thể gây chí mạng (ngoại trừ một số hiệu ứng kỹ năng đặc biệt), và lượng sát thương phụ thuộc hoàn toàn vào cấp độ của nhân vật kích hoạt phản ứng.

$$\text{DMG}_{\text{Transformative}} = \text{Reaction\_Multiplier} \times \text{Level\_Multiplier} \times \left(1 + \frac{16 \times EM}{2000 + EM} + \text{Reaction\_Bonus}\right) \times \text{RES\_Multiplier}$$
[cite: 5]

Trong đó:

- $\text{Reaction\_Multiplier}$ là hệ số cố định quy định sức mạnh của từng loại phản ứng.
- $\text{Level\_Multiplier}$ là giá trị sát thương cơ sở theo cấp độ của nhân vật.
- $\text{RES\_Multiplier}$ là hệ số kháng nguyên tố tương ứng của mục tiêu.

#### Nhóm phản ứng Khống chế và Đa dụng (Utility/CC Reactions)

##### Đóng băng (Frozen)

Xảy ra khi Thủy kết hợp với Băng. Thời gian khống chế $T_{\text{Freeze}}$ (giây) được tính theo lượng ấn nguyên tố tích lũy:

$$T_{\text{Freeze}} = 2\sqrt{5 \times U_{\text{Freeze}} \times \left(1 - \text{RES}_{\text{Freeze}}\right) + 4} - 4$$
[cite: 23]

Trong đó:

- $U_{\text{Freeze}}$ là dung lượng ấn Đóng băng tích lũy trên mục tiêu.
- $\text{RES}_{\text{Freeze}}$ là kháng đóng băng của mục tiêu.

Nếu mục tiêu đang trong trạng thái Đóng băng bị tấn công bởi một đòn đánh hạng nặng (Blunt Attack/Shatter - như trọng kiếm hoặc sát thương hệ Nham), trạng thái Đóng băng sẽ bị phá vỡ ngay lập tức (Shatter), tiêu thụ $8.0$ GU ấn Đóng băng và gây ra một lượng sát thương vật lý tương đương phản ứng biến đổi có hệ số $\text{Reaction\_Multiplier} = 3.0$.

##### Kết tinh (Crystallize)

Xảy ra khi Nham tác động lên mục tiêu đang bị đính kèm ấn Hỏa, Thủy, Băng hoặc Lôi. Lượng máu của lá chắn ($\text{Shield\_HP}$) được định nghĩa bởi:

$$\text{Shield\_HP} = 1.0 \times \text{Level\_Multiplier} \times \left(1 + \frac{4.44 \times EM}{1400 + EM} + \text{Shield\_Bonus}\right)$$
[cite: 5]

Lá chắn này hấp thụ sát thương hiệu quả hơn $250\%$ đối với các đòn tấn công cùng thuộc tính nguyên tố với lá chắn.

## Chương 3: Lý thuyết nâng cao - Elemental Gauge Theory & Internal Cooldown (ICD)

### 1. Lý thuyết Gauge Nguyên Tố (Elemental Gauge Theory)

Lý thuyết Gauge Nguyên Tố là một cơ chế ẩn quy định cách thức các nguyên tố tương tác, tồn tại, và triệt tiêu lẫn nhau trên một thực thể. Sức mạnh của một lần áp dụng nguyên tố được đo bằng đơn vị Gauge Unit ($GU$). Có ba mức độ áp dụng phổ biến trong thiết kế: $1U$ (Yếu), $2U$ (Trung bình), và $4U$ (Mạnh).

#### Cơ chế Khấu trừ ấn (Aura Tax)

Khi một nguyên tố lần đầu tiên được áp dụng lên mục tiêu để tạo thành Ấn nguyên tố nền (Aura), nó sẽ ngay lập tức bị khấu trừ $20\%$ dung lượng gốc để chuyển hóa thành trạng thái duy trì.

$$U_{\text{Aura}} = 0.8 \times X$$
[cite: 23, 24]

Trong đó $X$ là số $GU$ của đòn tấn công nguyên tố gốc. Đối với một đòn đánh cấp $1U$, lượng ấn thực tế ghi nhận trên thanh trạng thái của mục tiêu chỉ còn lại $0.8$ GU. Đối với đòn đánh $2U$, lượng ấn nền là $1.6$ GU.

#### Tốc độ phân rã tự nhiên (Decay Rate)

Ấn nguyên tố nền sau khi hình thành sẽ liên tục phân rã tuyến tính theo thời gian. Thời gian tồn tại tối đa của ấn nguyên tố ($T_{\text{Duration}}$) nếu không có phản ứng can thiệp được định nghĩa bằng phương trình:

$$T_{\text{Duration}} = 2.5 \times X + 7 \text{ (giây)}$$
[cite: 23, 24]

Từ đó, tốc độ phân rã tự nhiên của ấn nguyên tố (ký hiệu là $R_{\text{decay}}(X)$, tính bằng lượng GU phân rã mỗi giây) được xác định bởi tỷ số giữa lượng ấn ban đầu $U_{\text{Aura}}$ và thời gian tồn tại:

$$R_{\text{decay}}(X) = \frac{U_{\text{Aura}}}{T_{\text{Duration}}} = \frac{0.8X}{2.5X + 7} \text{ (GU/giây)}$$
[cite: 23, 24]

Đồng thời, thời gian tiêu hao hết $1$ GU (ký hiệu là $D(X)$, tính bằng giây trên mỗi GU) được biểu diễn qua phương trình nghịch đảo:

$$D(X) = R_{\text{decay}}^{-1}(X) = \frac{2.5X + 7}{0.8X} = \frac{35}{4X} + \frac{25}{8} \text{ (giây/GU)}$$
[cite: 17, 24]

Bảng thông số chi tiết của các loại ấn nguyên tố khi tồn tại độc lập:

| **Thuộc tính đòn đánh** | **Giá trị Gauge gốc (X)** | **Lượng ấn nền (UAura​)** | **Thời gian tồn tại tối đa (TDuration​)** | **Tốc độ phân rã thời gian (D(X))** | 
| --- | --- | --- | --- | --- | 
| **Ấn Yếu (1U)** | $1.0$ GU | $0.8$ GU | $9.5$ giây | $11.875$ giây/GU | 
| **Ấn Trung bình (2U)** | $2.0$ GU | $1.6$ GU | $12.0$ giây | $7.500$ giây/GU | 
| **Ấn Mạnh (4U)** | $4.0$ GU | $3.2$ GU | $17.0$ giây | $5.3125$ giây/GU | 

Biểu thức xác định lượng ấn nguyên tố còn lại tại thời điểm $t$ bất kỳ tuân thủ công thức:

$$U_{\text{Aura}}(t) = 0.8X \times \left(1 - \frac{t}{2.5X + 7}\right)$$
[cite: 23, 24]

#### Nguyên lý Kế thừa Tốc độ phân rã (Decay Rate Inheritance)

Khi áp dụng liên tiếp một nguyên tố cùng loại lên mục tiêu đang có sẵn ấn nguyên tố nền, hệ thống sẽ thực hiện cập nhật dung lượng ấn nguyên tố hiện tại theo quy tắc:

$$U_{\text{Aura, New}} = \max\left(U_{\text{Aura, Current}}, U_{\text{Trigger}}\right)$$
[cite: 17, 24]

Tuy nhiên, hệ thống sẽ **giữ nguyên tốc độ phân rã của ấn nguyên tố nền ban đầu** thay vì cập nhật theo tốc độ phân rã của đòn đánh mới.

**Ví dụ thực tế**: Áp dụng đòn đánh $1U$ lên mục tiêu trống tạo ấn nền $0.8$ GU với tốc độ phân rã cực chậm của $D(1) = 11.875$ giây/GU. Ngay sau đó tại $t = 1.0$ giây, bồi thêm đòn đánh $2U$ (ấn $1.6$ GU).

- Lượng ấn nền tại $t = 1.0$ giây trước khi bồi đòn: $U(1) = 0.8 \times \left(1 - \frac{1}{9.5}\right) \approx 0.716$ GU.
- Sau khi áp dụng đòn $2U$ ($1.6$ GU): $U_{\text{New}} = \max(0.716, 1.6) = 1.6$ GU.
- Tốc độ phân rã kế thừa: Giữ nguyên mức phân rã của ấn nền $1U$ ban đầu ($11.875$ giây/GU).
- Thời gian tồn tại thực tế còn lại của ấn mới: $1.6 \times 11.875 = 19.0$ giây.

Ngược lại, nếu áp dụng đòn $2U$ trước, sau đó bồi đòn $1U$ thì lượng ấn nền tối đa chỉ là $1.6$ GU nhưng bị phân rã theo tốc độ cực nhanh $D(2) = 7.5$ giây/GU, dẫn đến thời gian tồn tại thực tế chỉ kéo dài tối đa $12.0$ giây.

#### Phương trình Khấu trừ phản ứng (Reaction Consumption)

Khi một nguyên tố kích hoạt (Trigger) được áp dụng lên ấn nguyên tố nền (Aura) có sẵn, lượng ấn còn lại sau phản ứng được tính toán bằng phương trình khấu trừ:

$$U_{\text{Result}} = \left(U_{\text{Aura}} - C_{\text{Reaction}} \times U_{\text{Trigger}}\right)_{+}$$
[cite: 23, 24]

Trong đó $C_{\text{Reaction}}$ là Hệ số tiêu hao phản ứng (Reaction Coefficient) quy định bởi quy luật tương tác nguyên tố:

- Phản ứng khuếch đại thuận (Forward Melt/Vaporize): $C_{\text{Reaction}} = 2.0$.
- Phản ứng khuếch đại nghịch (Reverse Melt/Vaporize): $C_{\text{Reaction}} = 0.5$.
- Phản ứng biến đổi (Overloaded, Superconduct, Swirl): $C_{\text{Reaction}} = 1.0$.

### 2. Cơ chế Hồi chiêu Ẩn (Internal Cooldown - ICD)

Cơ chế Hồi chiêu Ẩn (ICD) kiểm soát tần suất một kỹ năng có thể áp dụng hiệu ứng nguyên tố lên cùng một mục tiêu, ngăn chặn việc người chơi kích hoạt liên tục hàng chục phản ứng nguyên tố trong một giây khi sử dụng các đòn đánh có tốc độ cực nhanh.

#### Quy tắc kép "2.5 giây hoặc 3 đòn đánh" (Standard ICD Rule)

Quy tắc ICD tiêu chuẩn hoạt động dựa trên hai bộ đếm độc lập chạy song song đối với từng nguồn sát thương (kỹ năng hoặc chuỗi đòn đánh thường):

```
[Đòn đánh trúng mục tiêu]
         |
         v
[Kiểm tra Bộ đếm thời gian > 2.5s?] --(Có)--> [Áp dụng Nguyên tố] -> [Reset cả 2 bộ đếm về 0]
         | (Không)
         v
[Kiểm tra Bộ đếm đòn đánh == 3?] ----(Có)--> [Áp dụng Nguyên tố] -> [Reset Bộ đếm đòn đánh về 0]
         | (Không)
         v
[Gây sát thương thuần, KHÔNG áp dụng Nguyên tố] -> [Tăng Bộ đếm đòn đánh lên 1]
```

- **Bộ đếm thời gian (Timer)**: Có độ dài cố định là $2.5$ giây. Khi đòn đánh đầu tiên áp dụng nguyên tố thành công, bộ đếm thời gian bắt đầu chạy. Ngay khi chạm mốc $2.5$ giây, bộ đếm thời gian sẽ tự động reset, và đòn tấn công tiếp theo trúng mục tiêu chắc chắn sẽ áp dụng nguyên tố thành công, đồng thời đặt lại cả bộ đếm thời gian và bộ đếm đòn đánh về trạng thái ban đầu.
- **Bộ đếm đòn đánh (Hit Counter)**: Đếm số lượng đòn tấn công trúng đích của cùng một nhóm kỹ năng. Đòn thứ 1 áp dụng nguyên tố (bộ đếm ghi nhận đòn đánh thứ nhất). Đòn thứ 2 và đòn thứ 3 chỉ gây sát thương vật lý/nguyên tố thuần túy mà không áp dụng ấn nguyên tố mới. Đòn thứ 4 (tương ứng với đòn trúng đích thứ 3 sau đòn áp dụng đầu tiên) sẽ bỏ qua thời gian hồi chiêu để cưỡng bức áp dụng nguyên tố lên mục tiêu, đồng thời đặt bộ đếm đòn đánh về 0.

#### Thuật toán logic lập trình ICD (C++ System Structure)

Dưới đây là cấu trúc dữ liệu và logic thực thi hệ thống ICD trên từng thực thể mục tiêu đối với một nhân vật tấn công:

C++
```
struct ICDState {
    float timer;            // Bộ đếm thời gian kể từ lần áp dụng nguyên tố gần nhất
    int hitCounter;         // Bộ đếm số đòn đánh trúng đích
    bool isActive;          // Trạng thái hoạt động của bộ đếm

    void Reset() {
        timer = 0.0f;
        hitCounter = 0;
        isActive = false;
    }
};

bool EvaluateElementalApplication(ICDState& state, float deltaTime) {
    if (!state.isActive) {
        state.isActive = true;
        state.timer = 0.0f;
        state.hitCounter = 1; 
        return true;
    }

    state.timer += deltaTime;

    if (state.timer >= 2.5f) {
        state.timer = 0.0f;
        state.hitCounter = 1; 
        return true;
    }

    state.hitCounter++;
    if (state.hitCounter >= 3) {
        state.hitCounter = 0; 
        return true;
    }

    return false; 
}
```

#### Thiết kế kỹ năng "No ICD" tạo đột biến chiến thuật

Trong thiết kế ARPG, một số kỹ năng được nhà phát triển loại bỏ hoàn toàn hệ thống ICD (được gọi là trạng thái "No ICD"), nghĩa là mọi đòn đánh trúng mục tiêu từ kỹ năng đó đều áp dụng hiệu ứng nguyên tố thành công.

- *Phương pháp thiết kế*: Để kích hoạt trạng thái "No ICD", nhà thiết kế gán đòn tấn công đó vào một nhóm định danh ICD (ICD Tag) hoàn toàn riêng biệt hoặc thiết lập cờ ghi đè `bypassICD = true` trong cơ sở dữ liệu kỹ năng.
- *Ý nghĩa ứng dụng*: Kỹ năng bão lửa quay quanh nhân vật hoặc các đòn tấn công khi nhảy đáp (Plunging Attacks) thường được cấu hình "No ICD". Điều này cho phép người chơi tạo ra các chiến thuật xoay quanh việc kích hoạt phản ứng liên tục mà không bị giới hạn bởi thời gian 2.5 giây, nâng tầm quan trọng của việc sắp xếp thứ tự ra chiêu trong đội hình chiến đấu.

## Chương 4: Thiết kế kẻ địch và cơ chế kháng ngự (Mitigation Math)

### 1. Công thức giảm trừ sát thương tổng quát

Lượng sát thương thực tế mà kẻ địch phải nhận ($\text{DMG}_{\text{Received}}$) khi chịu tác động từ đòn tấn công của người chơi được xác định bởi phương trình tích đa hệ số:

$$\text{DMG}_{\text{Received}} = \text{Outgoing\_DMG} \times \text{DEF\_Multiplier} \times \text{RES\_Multiplier}$$
[cite: 5, 20]

Trong đó Sát thương đầu ra của nhân vật ($\text{Outgoing\_DMG}$) được định nghĩa bởi:

$$\text{Outgoing\_DMG} = \left[ \left(\text{Base\_DMG} \times \text{Base\_DMG\_Multiplier}\right) + \text{Additive\_Base\_DMG\_Bonus}\right] \times \text{DMG\_Bonus\_Multiplier} \times \text{CRIT}$$
[cite: 5, 8]

- $\text{Base\_DMG}$ là lượng sát thương gốc dựa trên các chỉ số thuộc tính cốt lõi của nhân vật và hệ số tỷ lệ kỹ năng.
- $\text{Base\_DMG\_Multiplier}$ là hệ số nhân kỹ năng đặc biệt.
- $\text{Additive\_Base\_DMG\_Bonus}$ là lượng sát thương cộng thẳng từ các nguồn bổ trợ (như phản ứng tăng cường cộng thêm hoặc các nội tại thuộc tính đặc biệt).
- $\text{DMG\_Bonus\_Multiplier}$ là tổng các chỉ số tăng sát thương thuộc tính hoặc sát thương vật lý ($1 + \% \text{DMG Bonus}$).
- $\text{CRIT}$ là hệ số sát thương chí mạng:

$$\text{CRIT} = \begin{cases} 1 + CD & \text{nếu đòn đánh chí mạng thành công} [cite: 5, 33] \\ 1 & \text{nếu đòn đánh không chí mạng} [cite: 5, 33] \end{cases}$$
### 2. Hệ số phòng thủ của quái vật (DEF Multiplier)

Hệ số phòng thủ ($\text{DEF\_Multiplier}$) kiểm soát cách thức lượng phòng thủ cơ bản của quái vật giảm trừ sát thương nhận vào. Trị số này phụ thuộc chặt chẽ vào khoảng cách cấp độ giữa nhân vật tấn công ($L_{\text{CharBase}}$) và quái vật chịu đòn ($L_{\text{EnemyBase}}$) để khuyến khích người chơi nâng cấp nhân vật:

$$\text{DEF\_Multiplier} = \frac{L_{\text{CharBase}} + 100}{L_{\text{CharBase}} + 100 + \left(L_{\text{EnemyBase}} + 100\right) \times \left(1 - \text{DEF\_Shred}\right) \times \left(1 - \text{DEF\_Ignore}\right)}$$
[cite: 5, 19]

Trong đó:

- $\text{DEF\_Shred}$ là tỷ lệ giảm giáp áp dụng lên kẻ địch từ các hiệu ứng kỹ năng.
- $\text{DEF\_Ignore}$ là tỷ lệ xuyên giáp cá nhân của nhân vật thực hiện đòn tấn công.

*Phân tích toán học trường hợp số thực tế*: So sánh một nhân vật cấp 90 ($L_{\text{CharBase}} = 90$) tấn công quái vật cấp 100 ($L_{\text{EnemyBase}} = 100$) trong 3 trường hợp giảm giáp khác nhau:

- **Trường hợp A: Không có hiệu ứng giảm giáp/xuyên giáp** ($\text{DEF\_Shred} = 0$, $\text{DEF\_Ignore} = 0$):

$$\text{DEF\_Multiplier} = \frac{90 + 100}{90 + 100 + (100 + 100) \times 1 \times 1} = \frac{190}{190 + 200} \approx 0.4872 \text{ (giảm } 51.28\% \text{ sát thương)} [cite: 19]$$
- **Trường hợp B: Áp dụng hiệu ứng giảm giáp $30\%$** ($\text{DEF\_Shred} = 0.30$):

$$\text{DEF\_Multiplier} = \frac{190}{190 + 200 \times (1 - 0.30)} = \frac{190}{190 + 140} = \frac{190}{330} \approx 0.5758 \text{ (giảm } 42.42\% \text{ sát thương)} [cite: 19]$$
Hiệu quả tăng trưởng sát thương thực tế so với trường hợp A:

$$\Delta_{\text{DMG}} = \frac{0.5758}{0.4872} - 1 \approx 18.19\% [cite: 19]$$
- **Trường hợp C: Áp dụng hiệu ứng giảm giáp mạnh $60\%$** ($\text{DEF\_Shred} = 0.60$):

$$\text{DEF\_Multiplier} = \frac{190}{190 + 200 \times (1 - 0.60)} = \frac{190}{190 + 80} = \frac{190}{270} \approx 0.7037 \text{ (giảm } 29.63\% \text{ sát thương)} [cite: 19]$$
Hiệu quả tăng trưởng sát thương thực tế so với trường hợp A:

$$\Delta_{\text{DMG}} = \frac{0.7037}{0.4872} - 1 \approx 44.44\% [cite: 19]$$
Phân tích này chứng minh rằng việc kết hợp các nguồn giảm giáp mang lại hiệu suất sát thương tăng trưởng phi tuyến tính (hiệu suất biên tăng dần khi chỉ số tiệm cận mốc $100\%$), biến các kỹ năng hỗ trợ giảm giáp thành những tài nguyên chiến thuật cực kỳ đắt giá ở giai đoạn cuối game.

### 3. Hệ số kháng nguyên tố/vật lý (RES Multiplier)

Kháng nguyên tố hoặc kháng vật lý ($\text{RES}_{\text{Total}}$) của quái vật được trừ trực tiếp bởi các hiệu ứng giảm kháng (RES Shred):

$$\text{RES}_{\text{Total}} = \text{RES}_{\text{Base}} - \text{RES\_Shred}$$
[cite: 5]

Nhằm bảo vệ tính ổn định toán học của trò chơi, ngăn chặn việc sát thương bị bùng nổ quá mức khi kháng bị giảm sâu hoặc kẻ địch trở nên bất tử khi có kháng quá cao, hệ thống phân tách việc tính toán $\text{RES\_Multiplier}$ thành ba trường hợp riêng biệt:

$$\text{RES\_Multiplier} = \begin{cases} 1 - \frac{\text{RES}_{\text{Total}}}{2} & \text{nếu } \text{RES}_{\text{Total}} < 0 [cite: 5, 7, 20] \\ 1 - \text{RES}_{\text{Total}} & \text{nếu } 0 \le \text{RES}_{\text{Total}} < 0.75 [cite: 5, 7, 20] \\ \frac{1}{4 \times \text{RES}_{\text{Total}} + 1} & \text{nếu } \text{RES}_{\text{Total}} \ge 0.75 [cite: 5, 19, 20] \end{cases}$$
#### Trường hợp số thực tế 1: Đối kháng với quái vật có kháng cơ bản thấp ($\text{RES}_{\text{Base}} = 10\%$)

- Khi không có giảm kháng: $0 \le 0.10 < 0.75 \implies \text{RES\_Multiplier} = 1 - 0.10 = 0.90$.
- Khi áp dụng hiệu ứng giảm kháng $40\%$ ($\text{RES\_Shred} = 0.40$):

  - Kháng thực tế: $\text{RES}_{\text{Total}} = 0.10 - 0.40 = -0.30 < 0$.
  - Hệ số kháng mới: $\text{RES\_Multiplier} = 1 - \frac{-0.30}{2} = 1.15$.
  - Hiệu quả gia tăng sát thương: $\frac{1.15}{0.90} - 1 \approx 27.78\%$.

#### Trường hợp số thực tế 2: Đối kháng với quái vật có kháng cơ bản cực cao ($\text{RES}_{\text{Base}} = 80\%$)

- Khi không có giảm kháng: $0.80 \ge 0.75 \implies \text{RES\_Multiplier} = \frac{1}{4 \times 0.80 + 1} = \frac{1}{4.2} \approx 0.2381$.
- Khi áp dụng hiệu ứng giảm kháng $40\%$ ($\text{RES\_Shred} = 0.40$):

  - Kháng thực tế: $\text{RES}_{\text{Total}} = 0.80 - 0.40 = 0.40$ (thuộc trường hợp $0 \le 0.40 < 0.75$).
  - Hệ số kháng mới: $\text{RES\_Multiplier} = 1 - 0.40 = 0.60$.
  - Hiệu quả gia tăng sát thương: $\frac{0.60}{0.2381} - 1 \approx 152.0\%$.

*Đánh giá chiến thuật*: Đối với các quái vật có kháng thông thường ($10\%$), giảm kháng mang lại hiệu quả tăng sát thương vừa phải ($27.78\%$). Tuy nhiên, đối với các kẻ địch có kháng cao ($80\%$), hiệu quả giảm kháng mang lại sức mạnh bùng nổ lên tới $152\%$, biến cơ chế này thành chìa khóa bắt buộc phải có để vượt qua các thử thách cấp cao của trò chơi.

## Chương 5: Thiết kế hệ thống vũ khí và quy luật bù trừ thuộc tính (Stat Trade-off)

### 1. Quy luật toán học bù trừ thuộc tính (Stat Budget Law)

Trong thiết kế hệ thống trang bị của ARPG, việc duy trì sự công bằng giữa các lựa chọn vũ khí là tối quan trọng. Hệ thống áp dụng quy luật "Ngân sách thuộc tính" (Stat Budget): Một món vũ khí sở hữu Sức tấn công cơ bản ($\text{Base\_ATK}$) càng cao thì giá trị của dòng phụ thuộc tính ($\text{Substat}$) của nó bắt buộc phải giảm đi theo một tỷ lệ tuyến tính nghiêm ngặt để đảm bảo tổng giá trị quy đổi về một hệ số chuẩn là không đổi.

Mối quan hệ bù trừ giữa Sức tấn công cơ bản ($\text{Base\_ATK}$) và dòng phụ Tỷ lệ chí mạng ($\text{Crit\_Rate}$) đối với vũ khí cao cấp (5 sao) tại cấp độ tối đa ($90$) tuân thủ phương trình tuyến tính sau:

$$\text{Base\_ATK} + 6.0 \times \left(\text{Crit\_Rate} \times 100\right) = 806.6$$
[cite: 36]

Dựa trên nguyên tắc thiết kế này, trọng số quy đổi giữa các thuộc tính chính trong game tuân thủ tỷ lệ vàng $1.0 : 2.0 : 1.5$ tương ứng với $\text{Crit\_Rate} : \text{Crit\_DMG} : \%\text{ATK}$. Từ đó ta có các phương trình quy đổi tương đương cho các dòng phụ khác:

$$\text{Trọng số dòng phụ Sát thương chí mạng (Crit DMG): } w_{\text{CD}} = 3.0 \implies \text{Base\_ATK} + 3.0 \times \left(\text{Crit\_DMG} \times 100\right) = 806.6$$
[cite: 36]

$$\text{Trọng số dòng phụ Phần trăm tấn công (\%ATK): } w_{\text{ATK}\%} = 4.0 \implies \text{Base\_ATK} + 4.0 \times \left(\%\text{ATK} \times 100\right) = 806.6$$
[cite: 36]

### 2. Thiết kế và cân bằng ba phân cấp vũ khí

Bảng dưới đây quy định chi tiết các thông số của ba phân cấp vũ khí 5 sao tại cấp độ 90 sử dụng hệ thống ngân sách thuộc tính chuẩn hóa $B_{\text{Weapon}} = 806.6$:

| **Phân cấp vũ khí** | **Thiết kế định vị chiến thuật** | **Sức tấn công cơ bản (Base_ATK)** | **Dòng phụ 1: Tỷ lệ chí mạng (Crit_Rate)** | **Dòng phụ 2: Sát thương chí mạng (Crit_DMG)** | **Dòng phụ 3: Phần trăm tấn công (%ATK)** | **Kiểm định ngân sách (B=806.6)** | 
| --- | --- | --- | --- | --- | --- | --- | 
| **Phân cấp A** (Thiên ATK) | Sát thương cơ bản cực lớn, tối ưu hóa cho các nhân vật có sẵn chỉ số chí mạng cao hoặc nhận nhiều hỗ trợ chí mạng. | $674$ [cite: 36] | $22.1\%$ [cite: 36] | $44.2\%$ [cite: 36] | $33.1\%$ [cite: 36] | $674 + 6 \times 22.1 = 806.6$ [cite: 36] | 
| **Phân cấp B** (Cân bằng) | Thiết kế đa dụng, trung hòa giữa lực tấn công vật lý và hiệu suất kích hoạt chí mạng. | $608$ [cite: 36] | $33.1\%$ [cite: 36] | $66.2\%$ [cite: 36] | $49.6\%$ [cite: 36] | $608 + 6 \times 33.1 = 806.6$ [cite: 36] | 
| **Phân cấp C** (Thiên Dòng phụ) | Cung cấp chỉ số dòng phụ khổng lồ giúp người chơi dễ dàng tối ưu hóa thánh di vật, chấp nhận giảm sức mạnh cơ bản. | $542$ [cite: 36] | $44.1\%$ [cite: 36] | $88.2\%$ [cite: 36] | $66.2\%$ [cite: 36] | $542 + 6 \times 44.1 = 806.6$ [cite: 36] | 

#### Triết lý Cân bằng dựa trên Tỷ lệ vàng chí mạng $1 : 2$

Để tối ưu hóa lượng sát thương trung bình gây ra ($\text{DMG}_{\text{Average}}$) theo thời gian chiến đấu, người chơi luôn tìm cách tối đa hóa biểu thức toán học:

$$\text{Multiplier}_{\text{Crit\_Average}} = 1 + \text{Crit\_Rate} \times \text{Crit\_DMG}$$
[cite: 3]

Dưới góc độ hình học, đây là bài toán tìm diện tích lớn nhất của một hình chữ nhật khi chu vi của nó bị giới hạn bởi một lượng tài nguyên thuộc tính cố định trên trang bị.

Giả sử tổng ngân sách đầu tư vào hai chỉ số chí mạng trên trang bị của người chơi quy đổi về một lượng điểm cố định $S$:

$$2 \times \text{Crit\_Rate} + \text{Crit\_DMG} = S$$
[cite: 3]

Áp dụng bất đẳng thức Cauchy (AM-GM) cho biểu thức sát thương chí mạng trung bình:

$$\text{Crit\_Rate} \times \text{Crit\_DMG} = \frac{1}{2} \times \left(2 \times \text{Crit\_Rate}\right) \times \text{Crit\_DMG} \le \frac{1}{2} \times \left(\frac{2 \times \text{Crit\_Rate} + \text{Crit\_DMG}}{2}\right)^2 = \frac{S^2}{8}$$