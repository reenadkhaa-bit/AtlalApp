//
//  TabukPeopleView.swift
//  AtlalApp
//
//  Created by Norah H. AlDakheel on 21/02/1448 AH.
//

import SwiftUI

struct TabukPeopleView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
            ContentView(
                cardTitle: "من عاش في القلعة؟",
                cardDescription: "كانت مقرًا عسكريًا وإداريًا مؤقتًا. سكنها وتواجد فيها عبر التاريخ الحراس والجنود العثمانيون، وكانت محطة استراحة ومأوى مؤقت لقافل الحجاج والمسافرين القادمين على طريق الحج.",
                
                onBackButtonTapped: {
                    dismiss()
                }
            )
            
        
    }
}
#Preview {
    TabukPeopleView()
}
