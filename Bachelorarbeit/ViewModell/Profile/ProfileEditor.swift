//
//  ProfileEditor.swift
//  Bachelorarbeit
//
//  Created by JT X on 18.10.20.
//

import SwiftUI

struct ProfileEditor: View {
    @Binding var profile: Profile
    @EnvironmentObject var selectedLang : LanguageSettings

    
    var body: some View {
        List {
            HStack {
                Text(texts[4].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue)).bold()
                Divider()
                TextField(texts[4].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue), text: $profile.username)
            }
            
            HStack {
                Text(texts[6].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue)).bold()
                Divider()
                TextField(texts[6].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue), text: $profile.Alter)
            }
            
            HStack {
                Text(texts[23].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue)).bold()
                Divider()
                TextField(texts[23].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue), text: $profile.regionaleHerkunft)
            }
            HStack{
                Text(texts[5].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue)).bold()
                Divider()
                TextField(texts[5].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue), text: $profile.Geschlecht)
            }
            
            
           /*
            VStack(alignment: .leading, spacing: 20) {
                Text("Geschlecht").bold()
                
                Picker("Geschlecht", selection: $profile.Geschlecht) {
                    ForEach(Profile.Geschlecht.allCases, id: \.self) { season in
                        Text(season.rawValue).tag(season)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding(.top)
            */
            
         
        
        }
    }
}

struct ProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditor(profile: .constant(.default))
    }
}
