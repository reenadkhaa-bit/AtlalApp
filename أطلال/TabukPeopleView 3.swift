//
//  TabukPeopleView.swift
//  AtlalApp
//
//  Created by Norah H. AlDakheel on 21/02/1448 AH.
//

import SwiftUI

struct TabukPeopleView3: View {
    @Environment(\.dismiss) var dismiss
    

    var body: some View {
        //NavigationStack {
            ContentView(
                cardTitle: "من عاش في السفينة؟",
                cardDescription: "الأسماك والكائنات البحرية، بعد غرقها وهجرها تحولت السفينة بالكامل إلى شعاب مرجانية اصطناعية وموطن تعيش فيه مئات الأنواع من الأسماك والحياة البحرية المتنوعة.",
                
                onBackButtonTapped: {
                    dismiss()
                }
            )
           
       // }
    }
}
#Preview {
    TabukPeopleView3()
}
