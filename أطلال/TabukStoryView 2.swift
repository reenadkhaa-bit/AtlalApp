//
//  SwiftUIView.swift
//  AtlalApp
//
//  Created by Norah H. AlDakheel on 21/02/1448 AH.
//

import SwiftUI

struct TabukStoryView2: View {
    @Environment(\.dismiss) var dismiss
    //@State private var goToNextScreen = false

    var body: some View {
        //NavigationStack {
            ContentView(
                cardTitle: "قصة بئر هداج",
                cardDescription: "يعد بئر هداج أحد أكبر آبار الجزيرة العربية وأشهرها، وهي محطة رئيسة لاستراحة الحجاج والسقيا منها في طريق الحج خلال العصور الإسلامية المختلفة.",
                
                onBackButtonTapped: {
                    dismiss()
                }
            )
            
        //}
    }
}
#Preview {
    TabukStoryView2()
}
