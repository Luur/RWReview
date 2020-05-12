//
//  EmptyDataViewModifier.swift
//  RWReview
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import SwiftUI

struct EmptyDataViewModifier<Presenting, T>: View where Presenting: View, T: View {
    let presenting: () -> Presenting
    let emptyDataView: () -> T
    var condition: Bool
    
    var body: some View {
        if condition {
            return AnyView(emptyDataView())
        } else {
            return AnyView(presenting())
        }
    }
}

extension View {
    func emptyDataView<T>(condition: Bool, emptyDataView: @escaping () -> T) -> some View where T: View {
        EmptyDataViewModifier(presenting: { self }, emptyDataView: emptyDataView, condition: condition)
    }
}
