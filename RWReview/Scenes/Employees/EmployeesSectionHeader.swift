//
//  EmployeesSectionHeader.swift
//  RWReview
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import SwiftUI

struct EmployeesSectionHeader: View {
    
    let text: String
    
    var body: some View {
        
        HStack {
            
            Text(text)
                .font(.custom(Fonts.NunitoSans.bold, size: 20))
                .foregroundColor(Color(Colors.almostBlack))
                .padding()

            Spacer()
        }
        .background(Color.white)
        .listRowInsets(EdgeInsets())
    }
}

struct EmployeesSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        EmployeesSectionHeader(text: "Active")
    }
}
