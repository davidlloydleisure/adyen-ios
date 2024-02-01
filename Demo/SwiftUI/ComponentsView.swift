//
// Copyright (c) 2024 Adyen N.V.
//
// This file is open source and available under the MIT license. See the LICENSE file for more info.
//

import Adyen
import AdyenSwiftUI
import SwiftUI
import Combine

internal struct StoreView: View {
    
    internal var body: some View {
        NavigationStack {
            let _ = print(Self.self)
            List {
                Text("2")
            }
            .navigationTitle("MyStore")
        }
    }
}

internal struct CartView: View {
    
    internal var body: some View {
        NavigationStack {
            let _ = print(Self.self)
            List {
                Text("2")
            }
            .navigationTitle("Cart")
        }
    }
}

internal struct SettingsView: View {
    
    @Binding var color: Color
    
    internal var body: some View {
        NavigationStack {
            let _ = print(Self.self)
            List {
                ColorPicker("Tint", selection: $color)
            }
            .navigationTitle("Settings")
        }
    }
}

protocol ViewModelDataSource {
    var color: Color { get set }
}

internal class ViewModel: ObservableObject {
    
    @Published internal var selectedTab: Int = 1
    @Published internal var color: Color {
        didSet { dataSource.color = color }
    }
    
    private var dataSource: ViewModelDataSource
    
    init(dataSource: ViewModelDataSource) {
        self.dataSource = dataSource
        color = dataSource.color
    }
}

internal struct ComponentsView: View {
    
    @ObservedObject internal var model: ViewModel
    
    internal var body: some View {
        TabView(selection: $model.selectedTab) {
            let _ = print(Self.self)
            StoreView()
                .tabItem { Label("Store", systemImage: "1.square") }
                .tag(0)
            
            CartView()
                .tabItem { Label("Cart", systemImage: "2.square") }
                .tag(1)
                
            SettingsView(color: $model.color)
                .tabItem { Label("Settings", systemImage: "3.square") }
                .tag(2)
        }
        .tint(model.color)
    }
}
