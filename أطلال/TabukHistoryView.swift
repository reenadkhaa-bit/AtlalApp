//
//  TabukHistoryView.swift
//  AtlalApp
//
//  Created by Norah H. AlDakheel on 21/02/1448 AH.
//

import SwiftUI

struct TabukHistoryView: View {
    @Environment(\.dismiss) var dismiss
 

    var body: some View {
        
            ContentView(
                cardTitle: " تاريخ بناء القلعة",
                cardDescription: "يعود تاريخ بناها إلى عام ٩٧١هـ، ثم أعيد ترميمها في عام ١٠٦٤هـ، وفي عام ١٢٥٩هـ أعيد ترميمها وتجديدها بالكامل مرة أخرى، وقد وُضع بمحراب المسجد نقش خاص بهذه الذكرى، ثم جُددت القلعة في عام ١٣٧٠هـ وأجريت عليها ترميمات شاملة عام ١٤١٣هـ من قبل وكالة الآثار والمتاحف بوزارة المعارف سابقًا.",
               
                onBackButtonTapped: {
                    dismiss()
                }
            )
            
        }
    
}
#Preview {
    TabukHistoryView()
}
