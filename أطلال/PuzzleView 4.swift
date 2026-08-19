import SwiftUI
import CoreML

struct PuzzleView4: View {

    @Binding var shuffleTrigger: Bool
    @Binding var gameWon: Bool
    
    @State private var lastAIHint: String? = nil

    // هذا التريغر سيأتي من زر "تلميح"
    @Binding var aiHintTrigger: Bool

    let imageName = "قلعة تبوك"
    let gridSize: Int

    @State private var pieces: [Int] = []
    @State private var selectedIndex: Int? = nil
    @State private var isGameWon = false
    @State private var croppedImages: [UIImage] = []

    // الأماكن التي سيقترحها الـ AI
    @State private var hintIndexes: Set<Int> = []

    var body: some View {

        GeometryReader { geometry in

            let side = min(geometry.size.width, geometry.size.height)
            let pieceSize = side / CGFloat(gridSize)

            let columns = Array(
                repeating: GridItem(
                    .fixed(pieceSize),
                    spacing: isGameWon ? 0 : 1
                ),
                count: gridSize
            )

            LazyVGrid(
                columns: columns,
                spacing: isGameWon ? 0 : 1
            ) {

                ForEach(0..<pieces.count, id: \.self) { index in

                    let pieceID = pieces[index]
                    let isSelected = selectedIndex == index

                    // هل هذه القطعة اختارها AI كتلميح؟
                    let isAIHint = hintIndexes.contains(index)

                    ZStack {

                        RoundedRectangle(
                            cornerRadius: isGameWon ? 0 : 8
                        )
                        .fill(
                            isGameWon
                            ? Color.clear
                            : Color.white
                        )

                        if pieceID < croppedImages.count {

                            Image(uiImage: croppedImages[pieceID])
                                .resizable()
                                .scaledToFill()
                                .frame(
                                    width: isGameWon
                                    ? pieceSize
                                    : pieceSize - 2,

                                    height: isGameWon
                                    ? pieceSize
                                    : pieceSize - 2
                                )
                                .clipShape(
                                    RoundedRectangle(
                                        cornerRadius: isGameWon ? 0 : 6
                                    )
                                )
                        }
                    }
                    .frame(
                        width: pieceSize,
                        height: pieceSize
                    )

                    // MARK: - تحديد القطعة
                    .overlay {

                        Rectangle()
                            .stroke(
                                isAIHint
                                ? Color.yellow
                                : (
                                    isSelected
                                    ? Color.yellow
                                    : Color.white
                                ),
                                lineWidth:
                                    isGameWon
                                    ? 0
                                    : (
                                        isAIHint
                                        ? 5
                                        : (isSelected ? 3 : 0.5)
                                    )
                            )
                    }

                    // تأثير بسيط للقطعتين
                    .scaleEffect(isAIHint ? 0.92 : 1)

                    .animation(
                        .easeInOut(duration: 0.3),
                        value: hintIndexes
                    )

                    .onTapGesture {
                        handlePieceTap(at: index)
                    }
                }
            }
            .frame(
                width: side,
                height: side
            )
            .position(
                x: geometry.size.width / 2,
                y: geometry.size.height / 2
            )
        }

        .aspectRatio(1, contentMode: .fit)
        .padding(.horizontal, 10)

        .onAppear {
            setupGame()
        }

        .onChange(of: shuffleTrigger) {
            setupGame()
        }

        .onChange(of: gridSize) { _, _ in
            setupGame()
        }

        // لما المستخدم يضغط زر التلميح
        .onChange(of: aiHintTrigger) { _, _ in

            if gridSize == 5 {
                getAIHint()
            }
        }
    }

    // MARK: - Setup Game

    private func setupGame() {

        let totalPieces = gridSize * gridSize

        if let uiImage = UIImage(named: imageName) {

            croppedImages = sliceImage(
                uiImage,
                gridSize: gridSize
            )
        }

        pieces = Array(0..<totalPieces).shuffled()

        selectedIndex = nil
        hintIndexes.removeAll()

        isGameWon = false
        gameWon = false
    }

    // MARK: - Slice Image

    private func sliceImage(
        _ image: UIImage,
        gridSize: Int
    ) -> [UIImage] {

        guard let cgImage = image.cgImage else {
            return []
        }

        let imgWidth = CGFloat(cgImage.width)
        let imgHeight = CGFloat(cgImage.height)

        let cropSquareSize = min(
            imgWidth,
            imgHeight
        )

        let startX =
            (imgWidth - cropSquareSize) / 2

        let startY =
            (imgHeight - cropSquareSize) / 2

        let pieceSize =
            cropSquareSize / CGFloat(gridSize)

        var slicedImages: [UIImage] = []

        for row in 0..<gridSize {

            for col in 0..<gridSize {

                let rect = CGRect(
                    x: startX
                        + CGFloat(col) * pieceSize,

                    y: startY
                        + CGFloat(row) * pieceSize,

                    width: pieceSize,
                    height: pieceSize
                )

                if let cropped =
                    cgImage.cropping(to: rect) {

                    slicedImages.append(
                        UIImage(
                            cgImage: cropped,
                            scale: image.scale,
                            orientation:
                                image.imageOrientation
                        )
                    )
                }
            }
        }

        return slicedImages
    }

    // MARK: - Piece Tap

    private func handlePieceTap(at index: Int) {

        if isGameWon {
            return
        }

        // نخفي تلميح AI بمجرد ما يبدأ المستخدم بالاختيار
        hintIndexes.removeAll()

        if let firstIndex = selectedIndex {

            pieces.swapAt(
                firstIndex,
                index
            )

            selectedIndex = nil

            checkWinCondition()

        } else {

            selectedIndex = index
        }
    }

    // MARK: - AI Hint ⭐️

    private func getAIHint() {

        // الموديل مدرب فقط على 5 × 5
        guard gridSize == 5 else {
            return
        }

        guard pieces.count == 25 else {

            print("❌ عدد القطع ليس 25")

            return
        }

        do {

            let config = MLModelConfiguration()

            let model =
                try TabukPuzzle_1_copy_2(
                    configuration: config
                )

            let prediction =
                try model.prediction(

                    p0: Int64(pieces[0]),
                    p1: Int64(pieces[1]),
                    p2: Int64(pieces[2]),
                    p3: Int64(pieces[3]),
                    p4: Int64(pieces[4]),

                    p5: Int64(pieces[5]),
                    p6: Int64(pieces[6]),
                    p7: Int64(pieces[7]),
                    p8: Int64(pieces[8]),
                    p9: Int64(pieces[9]),

                    p10: Int64(pieces[10]),
                    p11: Int64(pieces[11]),
                    p12: Int64(pieces[12]),
                    p13: Int64(pieces[13]),
                    p14: Int64(pieces[14]),

                    p15: Int64(pieces[15]),
                    p16: Int64(pieces[16]),
                    p17: Int64(pieces[17]),
                    p18: Int64(pieces[18]),
                    p19: Int64(pieces[19]),

                    p20: Int64(pieces[20]),
                    p21: Int64(pieces[21]),
                    p22: Int64(pieces[22]),
                    p23: Int64(pieces[23]),
                    p24: Int64(pieces[24])
                )

            let probabilities = prediction.bestSwapProbability

            let result = chooseRandomAIHint(
                from: probabilities
            )

            guard let result else {
                print("❌ ما حصلت اقتراح مناسب")
                return
            }

            print("🤖 أصيل اختار:", result)

            lastAIHint = result

            showAIHint(from: result)

        } catch {

            print("❌ AI Error:", error)
        }
    }

    // MARK: - Convert AI Result

    private func showAIHint(
        from result: String
    ) {

        // مثال:
        // swap_3_17

        let parts =
            result.split(separator: "_")

        guard parts.count == 3,
              let first =
                Int(parts[1]),
              let second =
                Int(parts[2])
        else {

            print(
                "❌ لم أستطع قراءة:",
                result
            )

            return
        }

        guard first >= 0,
              first < pieces.count,
              second >= 0,
              second < pieces.count
        else {
            return
        }

        // نحدد القطعتين
        withAnimation {

            hintIndexes = [
                first,
                second
            ]
        }

        print(
            "💡 بدّل المكان",
            first,
            "مع",
            second
        )

        // يختفي التلميح بعد 3 ثوان
        DispatchQueue.main.asyncAfter(
            deadline: .now() + 3
        ) {

            withAnimation {
                hintIndexes.removeAll()
            }
        }
    }

    // MARK: - Win

    private func checkWinCondition() {

        let correctOrder =
            Array(0..<pieces.count)

        if pieces == correctOrder {

            withAnimation(
                .easeInOut(duration: 0.3)
            ) {
                isGameWon = true
            }

            DispatchQueue.main.asyncAfter(
                deadline: .now() + 3.0
            ) {

                gameWon = true
            }
        }
    }
    
    
    private func chooseRandomAIHint(
        from probabilities: [String: Double]
    ) -> String? {

        // ترتيب اقتراحات الـ AI من الأفضل للأقل
        let sortedHints = probabilities.sorted {
            $0.value > $1.value
        }

        // نأخذ أفضل 5 اقتراحات
        var bestHints = Array(sortedHints.prefix(5))

        // نحاول عدم تكرار آخر تلميح
        if let lastAIHint {

            bestHints.removeAll {
                $0.key == lastAIHint
            }
        }

        // لو ما بقي شيء نرجع لأفضل النتائج
        if bestHints.isEmpty {

            bestHints = Array(
                sortedHints.prefix(5)
            )
        }

        // اختيار عشوائي من أفضل الاقتراحات
        return bestHints.randomElement()?.key
    }
    
    
}
