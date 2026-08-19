import SwiftUI
import CoreML

struct PuzzleView2: View {

    @Binding var shuffleTrigger: Bool
    @Binding var gameWon: Bool
    
    @Binding var aiHintTrigger: Bool

    let imageName = "سفينة تبوك"
    let gridSize: Int
    
    @State private var pieces: [Int] = []
    @State private var selectedIndex: Int? = nil
    @State private var isGameWon = false
    @State private var croppedImages: [UIImage] = []
    
    @State private var hintIndexes: Set<Int> = []
    @State private var lastAIHint: String? = nil
    
    var body: some View {
        
        GeometryReader { geometry in
            
            let side = min(geometry.size.width, geometry.size.height)
            let pieceSize = side / CGFloat(gridSize)
            
            // إلغاء المسافات بين الأوردة عند الفوز
            let columns = Array(
                repeating: GridItem(.fixed(pieceSize), spacing: isGameWon ? 0 : 1),
                count: gridSize
            )
            
            // إلغاء المسافات بين الصفوف عند الفوز
            LazyVGrid(columns: columns, spacing: isGameWon ? 0 : 1) {
                
                ForEach(0..<pieces.count, id: \.self) { index in
                    
                    let pieceID = pieces[index]
                    let isSelected = selectedIndex == index
                    
                    let isAIHint = hintIndexes.contains(index)
                    
                    ZStack {

                        RoundedRectangle(cornerRadius: isGameWon ? 0 : 8)
                            .fill(isGameWon ? Color.clear : Color.white)

                        if pieceID < croppedImages.count {

                            // تكبير الصور لملء المربع بالكامل عند الفوز
                            Image(uiImage: croppedImages[pieceID])
                                .resizable()
                                .scaledToFill()
                                .frame(
                                    width: isGameWon ? pieceSize : pieceSize - 2,
                                    height: isGameWon ? pieceSize : pieceSize - 2
                                )
                                .clipShape(
                                    RoundedRectangle(cornerRadius: isGameWon ? 0 : 6)
                                )

                        }

                    }
                    .frame(width: pieceSize, height: pieceSize)
                    
                    .overlay(
                        Rectangle()
                            .stroke(
                                isAIHint
                                ? Color.yellow
                                : (isSelected ? Color.yellow : Color.white),

                                lineWidth:
                                    isGameWon
                                    ? 0
                                    : (isAIHint ? 5 : (isSelected ? 3 : 0.5))
                            )
                    )
                    .scaleEffect(isAIHint ? 0.92 : 1)
                    .animation(.easeInOut(duration: 0.3), value: hintIndexes)
                    
                    .onTapGesture {
                        handlePieceTap(at: index)
                    }
                    
                }
                
            }
            .frame(width: side, height: side)
            .position(x: geometry.size.width / 2,
                      y: geometry.size.height / 2)
            
        }
        .aspectRatio(1, contentMode: .fit)
        .padding(.horizontal, 10)
        .onAppear {
            setupGame()
        }
        .onChange(of: shuffleTrigger) {
            setupGame()
        }
        
        .onChange(of: aiHintTrigger) { _, _ in
            if gridSize == 5 {
                getAIHint()
            }
        }
        
        .onChange(of: gridSize) { _, _ in
            setupGame()
        }
        
    }
    
    private func setupGame() {
        
        let totalPieces = gridSize * gridSize
        
        if let uiImage = UIImage(named: imageName) {
            croppedImages = sliceImage(uiImage, gridSize: gridSize)
        }
        
        pieces = Array(0..<totalPieces).shuffled()
        
        selectedIndex = nil
        isGameWon = false
        gameWon = false
        
        hintIndexes.removeAll()
        lastAIHint = nil
        
    }
    
    private func sliceImage(_ image: UIImage, gridSize: Int) -> [UIImage] {
        
        guard let cgImage = image.cgImage else {
            return []
        }
        
        let imgWidth = CGFloat(cgImage.width)
        let imgHeight = CGFloat(cgImage.height)
        
        let cropSquareSize = min(imgWidth, imgHeight)
        
        let startX = (imgWidth - cropSquareSize) / 2
        let startY = (imgHeight - cropSquareSize) / 2
        
        let pieceSize = cropSquareSize / CGFloat(gridSize)
        
        var slicedImages: [UIImage] = []
        
        for row in 0..<gridSize {
            
            for col in 0..<gridSize {
                
                let rect = CGRect(
                    x: startX + CGFloat(col) * pieceSize,
                    y: startY + CGFloat(row) * pieceSize,
                    width: pieceSize,
                    height: pieceSize
                )
                
                if let cropped = cgImage.cropping(to: rect) {
                    
                    slicedImages.append(
                        UIImage(
                            cgImage: cropped,
                            scale: image.scale,
                            orientation: image.imageOrientation
                        )
                    )
                }
            }
        }
        
        return slicedImages
    }
    
    private func handlePieceTap(at index: Int) {
        
        hintIndexes.removeAll()
        
        if isGameWon {
            return
        }
        
        if let firstIndex = selectedIndex {
            
            pieces.swapAt(firstIndex, index)
            selectedIndex = nil
            
            checkWinCondition()
            
        } else {
            
            selectedIndex = index
            
        }
    }
    
    private func checkWinCondition() {
        
        let correctOrder = Array(0..<pieces.count)
        
        if pieces == correctOrder {

            // دمج الصور وإخفاء الخطوط بحركة ناعمة
            withAnimation(.easeInOut(duration: 0.3)) {
                isGameWon = true
            }

            // تأخير ظهور نافذة الفوز الخارجية 3 ثوانٍ
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                gameWon = true
            }

        }
    }
    
    private func getAIHint() {

        guard gridSize == 5,
              pieces.count == 25 else {
            return
        }

        do {

            let model = try TabukPuzzle_1_copy_2(
                configuration: MLModelConfiguration()
            )

            let prediction = try model.prediction(
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

            if let result = chooseRandomAIHint(
                from: prediction.bestSwapProbability
            ) {

                lastAIHint = result
                showAIHint(from: result)
            }

        } catch {
            print("❌ Aseel AI Error:", error)
        }
    }


    private func chooseRandomAIHint(
        from probabilities: [String: Double]
    ) -> String? {

        let sorted = probabilities.sorted {
            $0.value > $1.value
        }

        var choices = Array(sorted.prefix(3))

        if let lastAIHint {
            choices.removeAll {
                $0.key == lastAIHint
            }
        }

        if choices.isEmpty {
            choices = Array(sorted.prefix(3))
        }

        return choices.randomElement()?.key
    }


    private func showAIHint(from result: String) {

        let parts = result.split(separator: "_")

        guard parts.count == 3,
              let first = Int(parts[1]),
              let second = Int(parts[2]),
              first < pieces.count,
              second < pieces.count else {
            return
        }

        withAnimation {
            hintIndexes = [first, second]
        }

        DispatchQueue.main.asyncAfter(
            deadline: .now() + 3
        ) {
            withAnimation {
                hintIndexes.removeAll()
            }
        }
    }
    
}
