//
//  SwiftUIView.swift
//  AtlalApp
//
//  Created by Norah H. AlDakheel on 21/02/1448 AH.
//

import SwiftUI

struct TabukStoryView3: View {
    @Environment(\.dismiss) var dismiss
    //@State private var goToNextScreen = false

    var body: some View {
        //NavigationStack {
            ContentView(
                cardTitle: "قصة سفينة تبوك",
                cardDescription: " كانت سفينة تبوك سفينة شحن إنجليزية حيث تم نقل ملكيتها عدة مرات. وفي العام 1977 الذي غرقت فيه السفينة كانت مُلكًا لشركة يونانية تنقل الدقيق، ثم اشتراها رجل أعمال سعودي قبل وقوع حادث مؤسف؛ حيث علقت السفينة في الشعاب المرجانية على سواحل السعودية، ولم تستطع المناورة بالرغم من محاولة البحارة إعادة تشغيل المحرك؛ مما تسبب في نشوب حريق استمر لعدة أيام.",
                
                onBackButtonTapped: {
                    dismiss()
                }
            )
            
       // }
    }
}
#Preview {
    TabukStoryView3()
}
