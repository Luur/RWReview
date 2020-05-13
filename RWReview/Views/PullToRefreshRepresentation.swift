//
//  PullToRefreshRepresentation.swift
//  RWReview
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import SwiftUI
import Introspect

private struct PullToRefreshRepresentation: UIViewRepresentable {
    
    @Binding var isShowing: Bool
    let onRefresh: () -> Void
    
    init(isShowing: Binding<Bool>, onRefresh: @escaping () -> Void) {
        _isShowing = isShowing
        self.onRefresh = onRefresh
    }
    
    class Coordinator {
        let onRefresh: () -> Void
        let isShowing: Binding<Bool>
        
        init(onRefresh: @escaping () -> Void, isShowing: Binding<Bool>) {
            self.onRefresh = onRefresh
            self.isShowing = isShowing
        }
        
        @objc func onValueChanged() {
            isShowing.wrappedValue = true
            onRefresh()
        }
    }
    
    func makeUIView(context: UIViewRepresentableContext<PullToRefreshRepresentation>) -> UIView {
        let view = UIView(frame: .zero)
        view.isHidden = true
        view.isUserInteractionEnabled = false
        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PullToRefreshRepresentation>) {
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            
            guard let parentView = self.parentView(entry: uiView) else { return }
            
            if let refreshControl = parentView.refreshControl {
                if self.isShowing {
                    if !refreshControl.isRefreshing {
                        parentView.setContentOffset(CGPoint(x: 0, y: parentView.contentOffset.y - refreshControl.frame.size.height), animated: true)
                    }
                    refreshControl.beginRefreshing()
                } else {
                    refreshControl.endRefreshing()
                }
                return
            }
            
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(context.coordinator, action: #selector(Coordinator.onValueChanged), for: .valueChanged)
            parentView.refreshControl = refreshControl
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(onRefresh: onRefresh, isShowing: $isShowing)
    }
}

extension PullToRefreshRepresentation {
    
    private func tableView(entry: UIView) -> UITableView? {
        if let tableView = Introspect.findAncestor(ofType: UITableView.self, from: entry) { return tableView }
        guard let viewHost = Introspect.findViewHost(from: entry) else { return nil }
        return Introspect.previousSibling(containing: UITableView.self, from: viewHost)
    }
    
    private func scrollView(entry: UIView) -> UIScrollView? {
        if let scrollView = Introspect.findAncestor(ofType: UIScrollView.self, from: entry) { return scrollView }
        guard let viewHost = Introspect.findViewHost(from: entry) else { return nil }
        return Introspect.previousSibling(containing: UIScrollView.self, from: viewHost)
    }
    
    private func parentView(entry: UIView) -> UIScrollView? {
        if let scrollView = self.scrollView(entry: entry) {
            return scrollView
        } else if let tableView = self.tableView(entry: entry) {
            return tableView
        }
        return nil
    }
}

extension View {
    public func pullToRefresh(isShowing: Binding<Bool>, onRefresh: @escaping () -> Void) -> some View {
        return overlay(
            PullToRefreshRepresentation(isShowing: isShowing, onRefresh: onRefresh)
                .frame(width: 0, height: 0)
        )
    }
}
