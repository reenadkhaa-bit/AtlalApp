
import SwiftUI

struct TabukMap3: View {
    
    // MARK: - حفظ التقدم
    @AppStorage("level1Completed") private var level1Completed = false
    @AppStorage("level2Completed") private var level2Completed = false
    @AppStorage("level3Completed") private var level3Completed = false
    
    @Environment(\.dismiss) private var dismiss
    
   
        
    
    
    var body: some View {
        
        
            
            
            ZStack {
                
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    
                    // MARK: - العنوان
                    
                    HStack(alignment: .top) {
                        
                        
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 5) {
                            
                            Text("خريطة تبوك")
                                .font(.custom("thmanyahsans-Bold", size: 30))
                                .foregroundStyle(.navy)
                            
                            Text("اختر المعلم التالي لاستكمال رحلتك")
                                .font(.custom("thmanyahsans-Regular", size: 16))
                                .foregroundStyle(.brown)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    
                    // MARK: - الخريطة
                    
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(.green1)
                        .frame(width: 350, height: 500)
                        .overlay {
                            
                            ZStack {
                                
                                Image("tabukmap")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(-2)
                                
                                
                                // =========================================
                                // المرحلة الأولى - قلعة تبوك
                                // =========================================
                                Group{
                                    if level1Completed {
                                        
                                        // مكتملة → علم
                                        NavigationLink(destination: ContentView4()) {
                                            levelMarker(
                                                title: "قلعة تبوك",
                                                symbol: "flag"
                                            )
                                        }
                                        
                                    } else {
                                        
                                        // الحالية → دائرة مظللة
                                        NavigationLink(destination: ContentView4()) {
                                            levelMarker(
                                                title: "قلعة تبوك",
                                                symbol: "circle.fill"
                                            )
                                        }
                                    }
                                }
                                .offset(x: -70, y: 30)
                                
                                
                                // =========================================
                                // المرحلة الثانية - بئر هداج
                                // =========================================
                                
                                Group{
                                    if level2Completed {
                                        
                                        // مكتملة → علم
                                        NavigationLink(destination: ContentView3()) {
                                            levelMarker(
                                                title: "بئر هداج",
                                                symbol: "flag"
                                            )
                                        }
                                        
                                    } else if level1Completed {
                                        
                                        // الحالية → دائرة مظللة
                                        NavigationLink(destination: ContentView3()) {
                                            levelMarker(
                                                title: "بئر هداج",
                                                symbol: "circle.fill"
                                            )
                                        }
                                        
                                    } else {
                                        
                                        // مقفلة → دائرة عادية
                                        levelMarker(
                                            title: "بئر هداج",
                                            symbol: "circle"
                                        )
                                    }
                                }
                                .offset(x: 60, y: -60)
                                
                                
                                // =========================================
                                // المرحلة الثالثة - سفينة تبوك
                                // =========================================
                                Group{
                                    if level3Completed {
                                        
                                        // مكتملة → علم
                                        NavigationLink(destination: ContentView2()) {
                                            levelMarker(
                                                title: "سفينة تبوك",
                                                symbol: "flag"
                                            )
                                        }
                                        
                                    } else if level2Completed {
                                        
                                        // الحالية → دائرة مظللة
                                        NavigationLink(destination: ContentView2()) {
                                            levelMarker(
                                                title: "سفينة تبوك",
                                                symbol: "circle.fill"
                                            )
                                        }
                                        
                                    } else {
                                        
                                        // مقفلة → دائرة عادية
                                        levelMarker(
                                            title: "سفينة تبوك",
                                            symbol: "circle"
                                        )
                                    }
                                }
                                .offset(x: -80, y: -170)
                                
                            }
                        }
                        .padding(.top, 25)
                    
                    
                    // MARK: - شرح الرموز
                    
                    HStack {
                        
                        HStack {
                            Image(systemName: "flag")
                                .foregroundStyle(.navy)
                            
                            Text("تم فتحها")
                                .font(.custom("thmanyahsans-Regular", size: 14))
                                .foregroundStyle(.navy)
                        }
                        
                        Spacer()
                        
                        HStack {
                            Text("غير مكتملة")
                                .font(.custom("thmanyahsans-Regular", size: 14))
                                .foregroundStyle(.navy)
                            
                            Image(systemName: "circle")
                                .foregroundStyle(.navy)
                            
                        }
                    }
                    .padding(.horizontal, 60)
                    
                    
                    // MARK: - زر ابدأ التحدي
                    
                    NavigationLink(destination: currentLevel) {
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 18)
                                .foregroundStyle(.navy)
                                .frame(width: 300, height: 60)
                            
                            Text("ابدأ التحدي")
                                .font(.custom("thmanyahsans-Medium", size: 18))
                                .foregroundStyle(.white)
                            
                            
                            /*Button("تصفير التقدم") {
                                level1Completed = false
                                level2Completed = false
                                level3Completed = false
                            }
                            .foregroundStyle(.black)
                            .padding(.top, -50)*/
                            
                        }
                    }
                    .padding(.top, 60)
                    
                    
                }
            }
            .environment(\.layoutDirection, .leftToRight)
            .navigationBarBackButtonHidden(true)
            
        
    }
    
    // MARK: - شكل المرحلة
    
    @ViewBuilder
    private func levelMarker(
        title: String,
        symbol: String
    ) -> some View {
        
        ZStack {
            
            // اللفافة
            /*Image("scroll")
                .resizable()
                .frame(width: 80, height: 70)
            
            // اسم المرحلة
            Text(title)
                .font(.custom("thmanyahsans-Regular", size: 10))
                .foregroundStyle(.navy)*/
            
            // علامة المرحلة
            if symbol == "circle.fill" {
                
                ZStack {
                    // الدائرة الخارجية
                    Circle()
                        .stroke(.navy, lineWidth: 3)
                        .frame(width: 26, height: 26)
                    
                    // الدائرة الداخلية
                    Circle()
                        .fill(.navy)
                        .frame(width: 30, height: 15)
                    ZStack{
                        Image("scroll")
                            .resizable()
                            .frame(width: 80, height: 70)
                            
                        
                        // اسم المرحلة
                        Text(title)
                            .font(.custom("thmanyahsans-Regular", size: 10))
                            .foregroundStyle(.navy)
                    }
                    .offset(y: 30)
                    
                }
                .offset(y: -30)
                
            } else if symbol == "flag"{
                
                
                
                Image("scroll")
                    .resizable()
                    .frame(width: 80, height: 70)
                    
                
                // اسم المرحلة
                Text(title)
                    .font(.custom("thmanyahsans-Regular", size: 10))
                    .foregroundStyle(.navy)
                
                
                
                Image(systemName: symbol)
                    .font(.system(size: 25))
                    .foregroundStyle(.navy)
                    .offset(y: -30)
                
                
                
            }
            
            else{
                
                
                
                Image(systemName: symbol)
                    .font(.system(size: 25))
                    .foregroundStyle(.navy)
                    .offset(y: -30)
                
            }
        }
    }
    

    
    
    // MARK: - المرحلة الحالية
    
    @ViewBuilder
    private var currentLevel: some View {
        
        if !level1Completed {
            
            ContentView4()
            
        } else if !level2Completed {
            
            ContentView3()
            
        } else {
            
            ContentView2()
        }
    }
}


#Preview {
    TabukMap3()
}

