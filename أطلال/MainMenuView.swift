//
//  MainMenuView.swift
//  AtlalApp
//
//  Created by Norah H. AlDakheel on 24/02/1448 AH.
//

//
//  MainMenuView.swift
//  AtlalApp
//
//  Created by Norah H. AlDakheel on 21/02/1448 AH.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // خلفية التطبيق
                Image("background")
                    .resizable()
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    topHeaderView
                    
                    Spacer()

                    // الأزرار الرئيسية في المنتصف
                    VStack(spacing: 16) {
                        NavigationLink(destination: TabukStoryView()) {
                            menuButtonRow(title: "قصة المكان", icon: "book")
                        }

                        NavigationLink(destination: TabukPeopleView()) {
                            menuButtonRow(title: "من عاش هنا؟", icon: "person.3")
                        }

                        NavigationLink(destination: TabukInfoView()) {
                            menuButtonRow(title: "معلومة مميزة", icon: "sparkles")
                        }

                        NavigationLink(destination: TabukHistoryView()) {
                            menuButtonRow(title: "تاريخ البناء", icon: "building.columns")
                        }
                    }
                    .padding(.horizontal, 100) //امتداد الازرار-اسأل صبا///////

                    Spacer()

                    // بدلاً من الـ Button القديم، استخدم NavigationLink:
                    NavigationLink(destination: TabukMap3()) { // استبدل HomeView باسم الواجهة الرئيسية التي تريد الانتقال لها
                        Text("العودة للخريطة")
                            .font(.custom("ThmanyahSans-medium", size: 16))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(.navy)
                            .cornerRadius(18)
                            .padding(.horizontal, 40)
                    }
                    //.padding(.bottom, 8)
                }
            }
            .navigationBarHidden(true)
            .environment(\.layoutDirection, .rightToLeft)
        }
    }

    private var topHeaderView: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text("قلعـة تـبوك")
                    .font(.custom("ThmanyahSans-bold", size: 28))
                    .foregroundColor(.white)
                
                Text("تعرف على ما وراء القلعة!")
                    .font(.custom("ThmanyahSans-regular", size: 16))
                    .foregroundColor(.white.opacity(0.8))
            }
            Spacer()
            //////////الروبوت/////////////////////////////
           Image("")//صورة الروبوت/////////////////////////////
                .resizable()
                .frame(width: 45, height: 45)
                .clipShape(Circle())
        }
        .padding(.horizontal, 24)
        .padding(.top, 70)
        .padding(.bottom, 24)
        .background(.navy)
        .clipShape(UnevenRoundedRectangle(bottomLeadingRadius: 30, bottomTrailingRadius: 30))
        .ignoresSafeArea(edges: .top)
    }

    // تصميم زر القائمة المربع
    private func menuButtonRow(title: String, icon: String) -> some View {
        VStack(spacing: 12) { // استخدام VStack لجعل الأيقونة فوق النص
            Image(systemName: icon)
                .font(.system(size: 28)) // حجم الأيقونة
                .foregroundColor(.navy)
            
            Text(title)
                .font(.custom("ThmanyahSans-bold", size: 16))
                .foregroundColor(.navy)
        }
        .frame(maxWidth: .infinity) // العرض يملأ المساحة
        .frame(height: 120) // ضبط الارتفاع ليكون مربع الشكل تقريباً (يمكنك تعديل 120 حسب الرغبة)
        .background(Color.green1) // تأكدي من تعريف هذا اللون في Asset Catalog
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 3)
    }
}

#Preview {
    MainMenuView()
}
