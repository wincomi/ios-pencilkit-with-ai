//
//  AddSheetView.swift
//  PencilKitWithAI
//
//  Created by dale on 2022/12/03.
//

import SwiftUI

struct AddSheetView: View {
    @State var fileName: String
    @State var selected: Bool = false
    @State var keyWord: String
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("", text: $fileName)
                        .submitLabel(.next)
                    
                } header: {
                    Text("파일이름")
                }
                
                Section {
                    VStack(alignment: .leading) {
                        HStack {
                            Button{
                                selected.toggle()
                            } label: {
                                Image(systemName: selected ? "circle": "checkmark.circle")
                                    .foregroundColor(.black)
                            }
                            .buttonStyle(.plain)
                            Text("빈 페이지")
                        }
                        .padding()

                        HStack {
                            Button{
                                selected.toggle()
                            } label: {
                                Image(systemName: selected ? "checkmark.circle": "circle")
                                    .foregroundColor(.black)
                            }
                            .buttonStyle(.plain)
                            Text("AI 생성 페이지")
                        }
                        .padding()
                    }

                } header: {
                    Text("템플릿")
                }

                Section {
                    TextField("", text: $keyWord)

                } header: {
                    Text("키워드")
                }

            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
}

struct AddSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AddSheetView(fileName: "", keyWord: "")
    }
}
