//
//  NotDevelopedView.swift
//  MusePick
//
//  Created by Gokul Gopalakrishnan on 19/04/25.
//

import SwiftUI

struct NotDevelopedView: View {
    @Binding var selectedText: String
    
    var body: some View {
        VStack {
            Text(selectedText)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.black)
                .padding()
        }
        
    }
}
