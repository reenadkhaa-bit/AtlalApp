//
//  TabukPeopleView.swift
//  AtlalApp
//
//  Created by Norah H. AlDakheel on 21/02/1448 AH.
//

import SwiftUI

struct TabukPeopleView2: View {
    @Environment(\.dismiss) var dismiss
    

    var body: some View {
       // NavigationStack {
            ContentView(
                cardTitle: "من عاش عند البئر؟",
                cardDescription: "تعاقبت عدة حضارات على بئر هداج وهم الأراميون والبابليون وبعض الجاليات الهودية وأخيرًا العرب والقبائل المحلية ",
                
                onBackButtonTapped: {
                    dismiss()
                }
            )
                    }
   // }
}
#Preview {
    TabukPeopleView2()
}
