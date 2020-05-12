//
//  EmptyDataView.swift
//  RWReview
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation
import SwiftUI

class EmptyDataViewFactory {
    
    enum EmptyDataViewType {
        case employees
    }
    
    func make(_ type: EmptyDataViewType) -> EmptyDataView {
        switch type {
        case .employees:
            return EmptyDataView(title: "Currently there are no employees.", imageName: "image_empty_happiness_chart")
        }
    }
}

struct EmptyDataView: View {
    var title: String
    var imageName: String
    
    init(title: String, imageName: String) {
        self.title = title
        self.imageName = imageName
    }
    
    var body: some View {
        
        GeometryReader { geometry in
        
            ScrollView(showsIndicators: false) {
        
                VStack(spacing: 20) {
                    
                    Spacer()
                
                    Image(self.imageName)
            
                    Text(self.title)
                        .font(.custom(Fonts.NunitoSans.regular, size: 16))
                        .foregroundColor(Color(Colors.slateGray))
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer()
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

struct EmptyDataView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyDataView(title: "Title", imageName: "onboarding_page_image")
    }
}
