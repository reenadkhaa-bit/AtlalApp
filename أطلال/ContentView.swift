//
//  ContentView.swift
//  AtlalApp
//
//  Created by Norah H. AlDakheel on 21/02/1448 AH.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @Environment(\.dismiss) var dismiss
    
    var cardTitle: String
    var cardDescription: String
    //var onNextButtonTapped: () -> Void
    var onBackButtonTapped: () -> Void

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            

            VStack(spacing: 0) {
                topHeaderView
                Spacer()
                mainCardView
                    .padding(.horizontal, 24)
                Spacer()
               
            }
        }
        
        .environment(\.layoutDirection, .rightToLeft)
    }

    
    
    private var topHeaderView: some View {
            HStack(alignment: .center) {
              
                Spacer()

                // سهم العودة على اليسار
                Button(action: {
                    onBackButtonTapped()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.navy)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 70) //
            .padding(.bottom, 24)
            .background(.navy)
            .clipShape(UnevenRoundedRectangle(bottomLeadingRadius: 30, bottomTrailingRadius: 30))
            .ignoresSafeArea(edges: .top)
        }
    private var mainCardView: some View {
        VStack(spacing: 36) {
            Text(cardTitle)
                .font(.custom("ThmanyahSans-bold", size: 18))
                .foregroundColor(.black)

            Text(cardDescription)
                .font(.custom("ThmanyahSans-regular", size: 15))
                .multilineTextAlignment(.center)
                .lineSpacing(8)
                .foregroundColor(Color.black.opacity(0.85))
        }
        .padding(.horizontal, 28)
        .padding(.vertical, 40)
        .frame(maxWidth: .infinity)
        .frame(height: 480)
        .background(Color.white)
        .cornerRadius(24)
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
    
    
    

    }

#Preview {
    TabukStoryView()
}

