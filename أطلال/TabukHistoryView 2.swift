//
//  TabukHistoryView.swift
//  AtlalApp
//
//  Created by Norah H. AlDakheel on 21/02/1448 AH.
//

import SwiftUI

struct TabukHistoryView2: View {
    @Environment(\.dismiss) var dismiss
    //@State private var goToNextScreen = false

    var body: some View {
        //NavigationStack {
            ContentView(
                cardTitle: "تاريخ بناء البئر",
                cardDescription: "يعود تاريخ بناءه إلى عام ٩٧١هـ، ثم يعود تاريخ حفره إلى القرن السادس قبل الميلاد، وهو مبني من الحجارة المصقولة، ويحيط به أشجار النخيل من الجهات الأربعة.",
                
                onBackButtonTapped: {
                    dismiss()
                }
            )
            
        //}
    }
}
#Preview {
    TabukHistoryView2()
}
