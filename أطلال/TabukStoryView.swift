//
//  SwiftUIView.swift
//  AtlalApp
//
//  Created by Norah H. AlDakheel on 21/02/1448 AH.
//

import SwiftUI

struct TabukStoryView: View {
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
       // NavigationStack {
            ContentView(
                cardTitle: "قصة قلعة تبوك",
                cardDescription: "تقع قلعة تبوك الأثرية وسط المدينة القديمة، بالقرب من «عين السكر»، التي لطالما شكلت موردًا مائيًا أساسيًا للحجاج والمسافرين. شكلت القلعة إحدى المحطات الرئيسة على طريق الحج الشامي، الذي يمتد من الحدود السعودية الأردنية وصولاً إلى المدينة المنورة، مرورًا بعدد من القلاع والمنازل المخصصة لخدمة الحجيج.",
                
                onBackButtonTapped: {
                    dismiss()
                }
            )
          
      //  }
    }
}
#Preview {
    TabukStoryView()
}
