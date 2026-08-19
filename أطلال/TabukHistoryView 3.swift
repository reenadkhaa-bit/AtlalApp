//
//  TabukHistoryView.swift
//  AtlalApp
//
//  Created by Norah H. AlDakheel on 21/02/1448 AH.
//

import SwiftUI

struct TabukHistoryView3: View {
    @Environment(\.dismiss) var dismiss
    //@State private var goToNextScreen = false

    var body: some View {
       // NavigationStack {
            ContentView(
                cardTitle: "تاريخ بناء السفينة",
                cardDescription: " صُنعت السفينة في إنجلترا بمقاطعة سندرلاند في عام 1949م، بعد ثلاثة أعوام من انتهاء الحرب العالمية الثانية، وبدأت مسيرتها الفعلية كناقلة شحن عام 1958م",
               
                onBackButtonTapped: {
                    dismiss()
                }
            )
            
       // }
    }
}
#Preview {
    TabukHistoryView3()
}
