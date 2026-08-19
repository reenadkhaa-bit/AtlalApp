//
//  TabukInfoView.swift
//  AtlalApp
//
//  Created by Norah H. AlDakheel on 21/02/1448 AH.
//

import SwiftUI

struct TabukInfoView3: View {
    @Environment(\.dismiss) var dismiss
    

    var body: some View {
       // NavigationStack {
            ContentView(
                cardTitle: "معلومة مميزة عن السفينة!",
                cardDescription: "تتميز سفينة تبوك بأنها مشتعلة من الداخل رغم غرقها في الماء؛ فبعد جنوحها عام 1978، اندلع فيها حريق ضخم استمر أيامًا بسبب احتكاك محركاتها بالشعاب المرجانية، مما جعلها تجمع مفارقة النيران والماء في آن واحد.",
                
                onBackButtonTapped: {
                    dismiss()
                }
            )
            
      //  }
    }
}
#Preview {
    TabukInfoView3()
}
