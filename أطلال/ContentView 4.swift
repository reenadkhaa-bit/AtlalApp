import SwiftUI

struct ContentView4: View {

    @AppStorage("level1Completed") private var level1Completed = false

    @Environment(\.dismiss) private var dismiss

    @State private var gridSize = 3
    @State private var timeRemaining = 30
    @State private var gameTimer: Timer?

    @State private var shuffleTrigger = false

    // التلميح العادي بالصورة
    @State private var showHint = false

    @State private var showWinAlert = false
    @State private var showLoseAlert = false
    @State private var gameWon = false

    @State private var selectedDifficulty = 3

    // MARK: - AI أصيل

    @State private var aiHintTrigger = false

    // عدد مساعدات أصيل
    @State private var hintChances = 3

    // رسالة انتهاء المساعدات
    @State private var showNoHintsMessage = false

    // الانتقال للصفحة التالية
    @State private var navigateToNext = false


    var body: some View {

        NavigationStack {

            ZStack {

                // MARK: - Background

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

                            Text("قلعة تبوك")
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

                        // صعب
                        Button {

                            gridSize = 5
                            selectedDifficulty = 5

                            // إعادة فرص أصيل
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


                        // متوسط
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


                        // سهل
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


                        PuzzleView4(
                            shuffleTrigger: $shuffleTrigger,
                            gameWon: $gameWon,
                            aiHintTrigger: $aiHintTrigger,
                            gridSize: gridSize
                        )
                        .padding(12)


                        // MARK: - التلميح العادي بالصورة

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

                                Image("قلعة تبوك")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(25)
                            }
                            .frame(
                                width: 300,
                                height: 300
                            )
                            .shadow(
                                color: .black.opacity(0.25),
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


                    // MARK: - Hint + Shuffle

                    HStack(spacing: 20) {

                        // التلميح العادي
                        Button {

                            showHint = true

                            DispatchQueue.main.asyncAfter(
                                deadline: .now() + 3
                            ) {

                                withAnimation {
                                    showHint = false
                                }
                            }

                        } label: {

                            HStack(spacing: 8) {

                                Image(
                                    systemName: "lightbulb.fill"
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


                        // إعادة الخلط
                        Button {

                            shuffleTrigger.toggle()

                            // ترجع فرص أصيل 3
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


                    // MARK: - زر أصيل AI

                    // لأن الموديل مدرب فقط على 5×5
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


                // MARK: - انتهى الوقت

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


                // MARK: - رسالة انتهاء فرص أصيل

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


                            Text("انتهت مساعدات أصيل")
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

/*
                            Text(
                                "حاول إكمال اللغز بنفسك "
                            )
                            .font(
                                .custom(
                                    "thmanyahsans-Medium",
                                    size: 15
                                )
                            )
                            .foregroundStyle(.gray)*/


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
                                systemName: "trophy.fill"
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

                                gameWon = false
                                navigateToNext = true
                                level1Completed = true

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

            // MARK: - Navigation

            .navigationDestination(
                isPresented: $navigateToNext
            ) {

                MainMenuView()
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


    // MARK: - Timer

    func startTimer(seconds: Int) {

        gameTimer?.invalidate()

        timeRemaining = seconds

        gameTimer = Timer.scheduledTimer(
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
    ContentView4()
}
