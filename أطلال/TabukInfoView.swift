//
//  TabukInfoView.swift
//  AtlalApp
//
//  Created by Norah H. AlDakheel on 21/02/1448 AH.
//

import SwiftUI

struct TabukInfoView: View {
    @Environment(\.dismiss) var dismiss
    

    var body: some View {
        
            ContentView(
                cardTitle: "معلومة مميزة عن القلعة!",
                cardDescription: "تحولت قلعة تبوك في الوقت الحالي إلى متحف مفتوح يعرض قطعًا أثرية وتراثية نادرة.",
                
                onBackButtonTapped: {
                    dismiss()
                }
            )
            
        }
    
}
#Preview {
    TabukInfoView()
}
