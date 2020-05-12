//
//  EmployeesListRow.swift
//  RWReview
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation
import SwiftUI
import KingfisherSwiftUI

struct EmployeesListRow: View {
    
    var name: String
    var role: String?
    var profilePictureURL: URL?
    var isActive: Bool
    
    var body: some View {
        
        HStack(spacing: 16) {
            
            KFImage(profilePictureURL)
                .placeholder {
                    Image("image_avatar_placeholder")
                        .resizable()
                }
                .cancelOnDisappear(true)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70)
                .clipShape(Circle())
                .grayscale(isActive ? 0.00 : 0.99)
            
            VStack(alignment: .leading, spacing: 3) {
                
                Text(name)
                    .font(.custom(Fonts.NunitoSans.bold, size: 16))
                    .foregroundColor(Color(isActive ? Colors.almostBlack : Colors.slateGray))
                
                role.map {
                    Text($0)
                        .font(.custom(Fonts.NunitoSans.regular, size: 12))
                        .foregroundColor(Color(Colors.slateGray))
                }
            }
            
            Spacer()
        }
    }
}

struct EmployeesListRow_Previews: PreviewProvider {
    static var previews: some View {
        EmployeesListRow(name: "John Doe", role: "ADMIN", profilePictureURL: nil, isActive: true)
    }
}
