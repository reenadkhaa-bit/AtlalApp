//
//  TabukInfoView.swift
//  AtlalApp
//
//  Created by Norah H. AlDakheel on 21/02/1448 AH.
//

import SwiftUI

struct TabukInfoView2: View {
    @Environment(\.dismiss) var dismiss
    

    var body: some View {
       // NavigationStack {
            ContentView(
                cardTitle: "معلومة مميزة عن البئر!",
                cardDescription: "نظير عطاء هذا البئر على امتداد التاريخ أصبح مضربًا للأمثال في الكرم، وملهم قريحة الشعراء، وهناك الكثير من الأبيات الشعرية التي تغنت ببئر هداج، سواء باسمه الأصلي أو بأحد الألقاب كما قاله حاكم تيماء في القرن الخامس الميلادي: بنـى لـي عاديًـا حصنًـا حصينًـا ومـاءً كلمـا شئـت استقيـت.",
                
                onBackButtonTapped: {
                    dismiss()
                }
            )
            
       // }
    }
}
#Preview {
    TabukInfoView2()
}
