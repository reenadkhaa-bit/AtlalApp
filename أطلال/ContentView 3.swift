import SwiftUI

struct ContentView3: View {

    @AppStorage("level2Completed")
    private var level2Completed = false

    @State private var gridSize = 3
    @State private var timeRemaining = 30
    @State private var gameTimer: Timer?

    @State private var shuffleTrigger = false
    @State private var showHint = false

    @State private var showWinAlert = false
    @State private var showLoseAlert = false

    @State private var gameWon = false
    @State private var selectedDifficulty = 3

    // AI
    @State private var aiHintTrigger = false
    @State private var hintChances = 3
    @State private var showNoHintsMessage = false

    @State private var navigateToNext = false

    var body: some View {

        NavigationStack {

            ZStack {

                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack {

                    // MARK: - Header

                    HStack {

                        Spacer()

                        VStack(
                            alignment: .trailing,
                            spacing: 4
                        ) {

                            Text("بئر هداج")
                                .font(
                                    .system(
                                        size: 33,
                                        weight: .bold
                                    )
                                )
                                .foregroundStyle(
                                    Color("navy")
                                )

                            Text(
                                "أعد تركيب الصورة لاكتشاف قصة هذا المكان"
                            )
                            .font(
                                .custom(
                                    "thmanyahsans-Medium",
                                    size: 14
                                )
                            )
                            .foregroundStyle(
                                Color("navy")
                            )
                        }
                    }

                    .padding(.horizontal, 27)
                    .padding(.top, 80)

                    // MARK: - Difficulty

                    HStack(spacing: 16) {

                        Button {

                            gridSize = 5
                            selectedDifficulty = 5
                            hintChances = 3
                            startTimer(seconds: 120)

                        } label: {

                            Text("صعب")
                                .font(
                                    .custom(
                                        "thmanyahsans-Medium",
                                        size: 14
                                    )
                                )
                                .foregroundStyle(
                                    selectedDifficulty == 5
                                    ? .white
                                    : Color("navy")
                                )
                                .frame(
                                    width: 90,
                                    height: 40
                                )
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 15
                                    )
                                    .fill(
                                        selectedDifficulty == 5
                                        ? Color("navy")
                                        : Color("green1")
                                    )
                                )
                        }

                        Button {

                            gridSize = 4
                            selectedDifficulty = 4
                            hintChances = 3
                            startTimer(seconds: 90)

                        } label: {

                            Text("متوسط")
                                .font(
                                    .custom(
                                        "thmanyahsans-Medium",
                                        size: 14
                                    )
                                )
                                .foregroundStyle(
                                    selectedDifficulty == 4
                                    ? .white
                                    : Color("navy")
                                )
                                .frame(
                                    width: 90,
                                    height: 40
                                )
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 15
                                    )
                                    .fill(
                                        selectedDifficulty == 4
                                        ? Color("navy")
                                        : Color("green1")
                                    )
                                )
                        }

                        Button {

                            gridSize = 3
                            selectedDifficulty = 3
                            hintChances = 3
                            startTimer(seconds: 45)

                        } label: {

                            Text("سهل")
                                .font(
                                    .custom(
                                        "thmanyahsans-Medium",
                                        size: 14
                                    )
                                )
                                .foregroundStyle(
                                    selectedDifficulty == 3
                                    ? .white
                                    : Color("navy")
                                )
                                .frame(
                                    width: 90,
                                    height: 40
                                )
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 15
                                    )
                                    .fill(
                                        selectedDifficulty == 3
                                        ? Color("navy")
                                        : Color("green1")
                                    )
                                )
                        }
                    }

                    .padding(.top, 30)

                    // MARK: - Timer

                    HStack(spacing: 8) {

                        Text(
                            String(
                                format: "%02d:%02d",
                                timeRemaining / 60,
                                timeRemaining % 60
                            )
                        )
                        .font(
                            .custom(
                                "thmanyahsans-Medium",
                                size: 18
                            )
                        )

                        Text("الوقت")
                            .font(
                                .custom(
                                    "thmanyahsans-Medium",
                                    size: 18
                                )
                            )
                            .foregroundStyle(
                                Color("brown")
                            )
                    }

                    .frame(
                        width: 190,
                        height: 30
                    )

                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.top, 50)

                    // MARK: - Puzzle

                    ZStack {

                        RoundedRectangle(
                            cornerRadius: 20
                        )
                        .fill(
                            Color.white.opacity(0.9)
                        )

                        PuzzleView3(
                            shuffleTrigger:
                                $shuffleTrigger,

                            gameWon:
                                $gameWon,

                            aiHintTrigger:
                                $aiHintTrigger,

                            gridSize:
                                gridSize
                        )

                        .padding(12)

                        if showHint {

                            ZStack {

                                RoundedRectangle(
                                    cornerRadius: 20
                                )
                                .fill(Color.white)

                                RoundedRectangle(
                                    cornerRadius: 20
                                )
                                .stroke(
                                    Color("navy"),
                                    lineWidth: 3
                                )

                                Image("بئر هداج")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(25)
                            }

                            .frame(
                                width: 300,
                                height: 300
                            )

                            .shadow(
                                color:
                                    .black.opacity(0.25),

                                radius: 8
                            )

                            .transition(.opacity)
                        }
                    }

                    .frame(
                        width: 340,
                        height: 340
                    )

                    .padding(.top, 30)

                    // MARK: - Normal Hint + Shuffle

                    HStack(spacing: 20) {

                        Button {

                            showHint = true

                            DispatchQueue
                                .main
                                .asyncAfter(
                                    deadline:
                                        .now() + 3
                                ) {

                                    withAnimation {

                                        showHint = false
                                    }
                                }

                        } label: {

                            HStack(spacing: 8) {

                                Image(
                                    systemName:
                                        "lightbulb.fill"
                                )

                                Text("تلميح")
                                    .font(
                                        .custom(
                                            "thmanyahsans-Medium",
                                            size: 16
                                        )
                                    )
                            }

                            .foregroundStyle(.white)

                            .frame(
                                width: 160,
                                height: 45
                            )

                            .background(
                                RoundedRectangle(
                                    cornerRadius: 15
                                )
                                .fill(Color("navy"))
                            )
                        }

                        Button {

                            shuffleTrigger.toggle()

                            hintChances = 3

                            if gridSize == 3 {

                                startTimer(seconds: 45)

                            } else if gridSize == 4 {

                                startTimer(seconds: 90)

                            } else {

                                startTimer(seconds: 120)
                            }

                        } label: {

                            HStack(spacing: 8) {

                                Image(
                                    systemName:
                                        "arrow.triangle.2.circlepath"
                                )

                                Text("إعادة الخلط")
                                    .font(
                                        .custom(
                                            "thmanyahsans-Medium",
                                            size: 16
                                        )
                                    )
                            }

                            .foregroundStyle(.white)

                            .frame(
                                width: 160,
                                height: 45
                            )

                            .background(
                                RoundedRectangle(
                                    cornerRadius: 15
                                )
                                .fill(Color("navy"))
                            )
                        }
                    }

                    .padding(.top, 35)

                    // MARK: - Aseel

                    if gridSize == 5 {
                        
                        Button {

                            if hintChances > 0 {

                                // تشغيل موديل Create ML
                                aiHintTrigger.toggle()

                                // نقص فرصة
                                hintChances -= 1

                            } else {

                                // انتهت الفرص
                                showNoHintsMessage = true
                            }

                        } label: {

                            HStack(spacing: 12) {

                                // الصورة اللي راح تضيفينها في Assets
                                Image("robot")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(
                                        width: 34,
                                        height: 34
                                    )
                                    .clipShape(Circle())


                                VStack(
                                    alignment: .leading,
                                    spacing: 1
                                ) {

                                    Text("أصيل")
                                        .font(
                                            .custom(
                                                "thmanyahsans-Medium",
                                                size: 17
                                            )
                                        )

                                    Text(
                                        "مساعد الذكاء الاصطناعي"
                                    )
                                    .font(
                                        .custom(
                                            "thmanyahsans-Medium",
                                            size: 11
                                        )
                                    )
                                    .opacity(0.8)
                                }


                                Spacer()


                                Text("\(hintChances)/٣")
                                    .font(
                                        .system(
                                            size: 16,
                                            weight: .bold
                                        )
                                    )

                                Image(
                                    systemName: "sparkles"
                                )
                            }
                            .padding(.horizontal, 18)
                            .foregroundStyle(.white)
                            .frame(
                                width: 290,
                                height: 40
                            )
                            .background(

                                RoundedRectangle(
                                    cornerRadius: 18
                                )
                                .fill(
                                    hintChances > 0
                                    ? Color("navy")
                                    : Color.gray
                                )
                            )
                        }
                        .padding(.top, -555)
                    }

                    Spacer()
                }

                // MARK: - Lose

                if showLoseAlert {

                    ZStack {

                        Color.black.opacity(0.45)
                            .ignoresSafeArea()

                        VStack(spacing: 20) {

                            Image(
                                systemName: "clock.fill"
                            )
                            .font(.system(size: 40))

                            .foregroundStyle(
                                Color("green1")
                            )

                            Text("انتهى الوقت")
                                .font(
                                    .custom(
                                        "thmanyahsans-Medium",
                                        size: 20
                                    )
                                )
                                .foregroundStyle(
                                    Color("navy")
                                )

                            Text(
                                "حاول مرة أخرى لإكمال اللغز"
                            )
                            .font(
                                .custom(
                                    "thmanyahsans-Medium",
                                    size: 16
                                )
                            )
                            .foregroundStyle(.gray)

                            Button {

                                showLoseAlert = false

                                shuffleTrigger.toggle()

                                hintChances = 3

                                if gridSize == 3 {

                                    startTimer(seconds: 45)

                                } else if gridSize == 4 {

                                    startTimer(seconds: 90)

                                } else {

                                    startTimer(seconds: 120)
                                }

                            } label: {

                                Text("أعد المحاولة")
                                    .font(
                                        .custom(
                                            "thmanyahsans-Medium",
                                            size: 16
                                        )
                                    )

                                    .foregroundStyle(.white)

                                    .frame(
                                        width: 180,
                                        height: 45
                                    )

                                    .background(
                                        RoundedRectangle(
                                            cornerRadius: 15
                                        )
                                        .fill(
                                            Color("navy")
                                        )
                                    )
                            }
                        }

                        .padding(30)
                        .background(Color.white)

                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 25
                            )
                        )

                        .shadow(radius: 12)
                    }
                }

                // MARK: - End Aseel Chances

                if showNoHintsMessage {

                    ZStack {

                        Color.black.opacity(0.45)
                            .ignoresSafeArea()

                        VStack(spacing: 16) {

                            Image("robot")
                                .resizable()
                                .scaledToFill()

                                .frame(
                                    width: 75,
                                    height: 75
                                )

                                .clipShape(Circle())

                            Text(
                                "انتهت مساعدات أصيل"
                            )
                            .font(
                                .custom(
                                    "thmanyahsans-Medium",
                                    size: 21
                                )
                            )
                            .foregroundStyle(
                                Color("navy")
                            )

                            Text(
                                "استخدمت فرص المساعدة الثلاث"
                            )
                            .font(
                                .custom(
                                    "thmanyahsans-Medium",
                                    size: 15
                                )
                            )
                            .foregroundStyle(.gray)

                            Button {

                                showNoHintsMessage = false

                            } label: {

                                Text("حسنًا")
                                    .font(
                                        .custom(
                                            "thmanyahsans-Medium",
                                            size: 16
                                        )
                                    )

                                    .foregroundStyle(.white)

                                    .frame(
                                        width: 180,
                                        height: 45
                                    )

                                    .background(
                                        RoundedRectangle(
                                            cornerRadius: 15
                                        )
                                        .fill(
                                            Color("navy")
                                        )
                                    )
                            }
                        }

                        .padding(30)
                        .background(Color.white)

                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 25
                            )
                        )

                        .shadow(radius: 12)
                    }
                }

                // MARK: - Win

                if gameWon {

                    ZStack {

                        Color.black.opacity(0.45)
                            .ignoresSafeArea()

                        VStack(spacing: 20) {

                            Image(
                                systemName:
                                    "trophy.fill"
                            )
                            .font(.system(size: 40))

                            .foregroundStyle(
                                Color("green1")
                            )

                            Text("مبروك")
                                .font(
                                    .custom(
                                        "thmanyahsans-Medium",
                                        size: 20
                                    )
                                )

                                .foregroundStyle(
                                    Color("navy")
                                )

                            Text(
                                "لقد أكملت اللغز بنجاح"
                            )
                            .font(
                                .custom(
                                    "thmanyahsans-Medium",
                                    size: 16
                                )
                            )

                            .foregroundStyle(.gray)

                            Button {

                                level2Completed = true
                                gameWon = false
                                navigateToNext = true

                            } label: {

                                Text("رائع")
                                    .font(
                                        .custom(
                                            "thmanyahsans-Medium",
                                            size: 16
                                        )
                                    )

                                    .foregroundStyle(.white)

                                    .frame(
                                        width: 180,
                                        height: 45
                                    )

                                    .background(
                                        RoundedRectangle(
                                            cornerRadius: 15
                                        )
                                        .fill(
                                            Color("navy")
                                        )
                                    )
                            }
                        }

                        .padding(30)
                        .background(Color.white)

                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 25
                            )
                        )

                        .shadow(radius: 12)
                    }
                }
            }

            .navigationDestination(
                isPresented:
                    $navigateToNext
            ) {

                MainMenuView2()
            }

            .onAppear {

                startTimer(seconds: 45)
            }

            .onDisappear {

                gameTimer?.invalidate()
            }

            .onChange(of: gameWon) { _, newValue in

                if newValue {

                    gameTimer?.invalidate()
                }
            }
        }

        .environment(
            \.layoutDirection,
            .leftToRight
        )
    }

    func startTimer(
        seconds: Int
    ) {

        gameTimer?.invalidate()

        timeRemaining = seconds

        gameTimer =
            Timer.scheduledTimer(
                withTimeInterval: 1.0,
                repeats: true
            ) { _ in

                if timeRemaining > 0 {

                    timeRemaining -= 1

                } else {

                    gameTimer?.invalidate()

                    showLoseAlert = true
                }
            }
    }
}

#Preview {
    ContentView3()
}
