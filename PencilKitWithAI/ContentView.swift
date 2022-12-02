//
//  ContentView.swift
//  PencilKitWithAI
//
//  Created by COMI on 2022/12/03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            MainView()
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
