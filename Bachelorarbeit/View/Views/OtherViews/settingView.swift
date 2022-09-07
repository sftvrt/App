//
//  Aufnahme&Verbindung.swift
//  Bachelorarbeit
//
//  Created by JT X on 10.12.20.
//

import SwiftUI

struct SettingView: View {
    // MARK: - PROPERTIES
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var selectedLang : LanguageSettings
    
    // MARK: - BODY
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false) {
                /*
                VStack(spacing: 20) {
                    // MARK: - SECTION 2
                    GroupBox(
                        label:
                            HStack {
                              Text(" ".uppercased()).fontWeight(.bold)
                              Spacer()
                            
                            }
                        
                    ){
                        Divider().padding(.vertical,4)
                        
                        Picker("Language", selection: $selectedLang.lang) {
                            Text("ENG").tag(lang.en)
                            Text("ZH").tag(lang.zh)
                            Text("DE").tag(lang.de)
                        }
                        .pickerStyle(.segmented)
                        
                        Divider().padding(.vertical, 4)
                        
                    }
                    
                
                } //: VSTACK
                */
                VStack(spacing: 20) {
              /*      Divider().padding(.vertical,4)
                    
                    Picker("Language", selection: $selectedLang.lang) {
                        Text("ENG").tag(lang.en)
                        Text("ZH").tag(lang.zh)
                        Text("DE").tag(lang.de)
                    }
                    .pickerStyle(.segmented)
                    
                    Divider().padding(.vertical, 4)*/
                    Picker(selection: $selectedLang.lang,label: Text("Picker"),
                           content: {
                        Text("ENG").tag(lang.en)
                        Text("ZH").tag(lang.zh)
                        Text("DE").tag(lang.de)
                    })
                    .pickerStyle(WheelPickerStyle())
                }
                
                .navigationBarTitle(Text(texts[2].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue)), displayMode: .large)
                .navigationBarItems(
                    trailing:
                        Button(action:{
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "xmark")
                        }
                )
                .padding()
            } //: SCROLL
        } //: NAVIGATION
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(LanguageSettings())
    }
}
