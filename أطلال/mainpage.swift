//
//  mainpage.swift
//  atlal app
//
//  Created by reenad alkhamees on 23/02/1448 AH.
//

import SwiftUI

// 1. الصفحة الرئيسية (الكود الاول)
struct mainpage: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // الخلفية
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                // المحتوى الرئيسي
                VStack(spacing: 0) {
                    Spacer()
                    
                    // النصوص الترحيبية
                    VStack(spacing: 8) {
                        Text("حيّـاك!")
                            .font(.custom("ThmanyahSans-bold", size: 44))
                            .foregroundColor(.navy)
                            .multilineTextAlignment(.center)
                        
                        Text("اكتشف تاريخ تبوك بطريقة تفاعلية")
                            .font(.custom("ThmanyahSans-medium", size: 18))
                            .foregroundColor(.brown)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 48)
                    
                    // الخريطة
                    Image("SaudiMap")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 330)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                    
                    // الوصف
                    VStack(spacing: 10) {
                        Text("ابدأ رحلتك عبر معالم تبوك التاريخية.")
                        Text("قم بتركيب الصور، ثم استكشف قصة كل معلم!")
                    }
                    .font(.custom("thmanyahsans-Regular", size: 16))
                    .bold()
                    .foregroundColor(.brown)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                    
                    // زر البدء (ينتقل إلى واجهة allCircle)
                    NavigationLink(destination: TabukMap3()) {
                        
                        
                        
                        Text("ابدأ")
                            .font(.custom("thmanyahsans-Bold", size: 18))
                            .foregroundColor(.white)
                            .frame(width: 300, height: 60)
                            .background(.navy)
                            .cornerRadius(16)
                    }
                    .padding(.top, 50)
                    .padding(.bottom, 65)
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    mainpage()
}
//
