//
//  SpielleiterUI.swift
//  Bachelorarbeit
//
//  Created by JT X on 01.11.20.
//



import Combine
import SwiftUI


/*
struct SpielleiterUI: View {
    
    
    @EnvironmentObject var nearbyService: NearbyService
    @EnvironmentObject var selectedLanguage : LanguageSettings
    @EnvironmentObject var selectedLang : LanguageSettings


    static let goalFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()
    

    var body: some View{
        
        List{
                
           // Text("Datum und Zeit \(self.nearbyService.sitzung.datum,formatter:Self.goalFormatter)")
            Text("\(self.nearbyService.sitzung.datum,formatter:Self.goalFormatter)")
        
            Spacer()
            Section(header:Text((texts[13].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue)))){
                TextField((texts[13].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue)), text: $nearbyService.sitzung.title).textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Spacer()
            HStack {
                Button {
                    nearbyService.showBrowsesrController()
                } label: {
                    Text((texts[12].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue)))
                }
            }
            Spacer()
            NavigationLink(destination:AufnahmeUI()
                            .environmentObject(nearbyService)
                            .environmentObject(AudioRecorder(nearbyService))
            ){
                Text((texts[10].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue)))
            }
            
            
        }.onAppear{
            nearbyService.startBrowser()
        }
    
        
    }
    
}


struct SpielleiterUI_Previews: PreviewProvider {
    static var previews: some View {
        SpielleiterUI()

    }
}
*/

struct SpielleiterUI: View {
    
    
    @EnvironmentObject var nearbyService: NearbyService
    @EnvironmentObject var selectedLanguage : LanguageSettings
    @EnvironmentObject var selectedLang : LanguageSettings
    @Binding var selectedTab: Int


    static let goalFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()
    

//    init(){
//        UITableView.appearance().separatorStyle = .none
//        UITableViewCell.appearance().backgroundColor = .white
//        UITableView.appearance().backgroundColor = .white
//    }
    
   
    var body: some View{
        
        VStack{
            Text("\(self.nearbyService.sitzung.datum,formatter:Self.goalFormatter)")
            //Titel
            /*
            VStack{
                Text("Group").font(.largeTitle).bold()
                    .frame(maxWidth:.infinity, alignment: .leading)
                Text("Recorder").font(.largeTitle).bold()
                    .frame(maxWidth:.infinity, alignment: .leading)
            }
            */
            // Button: Suchen
            Button{
                nearbyService.showBrowsesrController()
            } label: {
                VStack{
                    HStack{
                        Image(systemName: "magnifyingglass").foregroundColor(.yellow).font(.system(size:80)).frame(maxWidth: .infinity,  maxHeight: .infinity)
                    }
                //   Spacer()
                    HStack{
                        VStack{
                            Text((texts[33].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue))).font(.system(size: 32, weight: .bold)) .frame(maxWidth:.infinity, alignment: .leading).foregroundColor(.black)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(12)
                    .background(Color(#colorLiteral(red: 0.8509804010391235, green: 0.8509804010391235, blue: 0.8509804010391235, alpha: 0.27000001072883606)).opacity(0.8))
                }
                .frame(maxWidth: 200,   maxHeight: 200)
                .background(Color(#colorLiteral(red: 0.9764705896377563, green: 0.9764705896377563, blue: 0.9764705896377563, alpha: 1)))
               .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        }
        
            
            //Sitzungstitel
            List{
           //     Text("Sitzungstitel").frame(maxWidth: 320, maxHeight: 60)
               
                Section(header:Text((texts[13].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue)))){
                    TextField((texts[13].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue)), text: $nearbyService.sitzung.title).textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
               
          //      Text(" ")
            }

            NavigationLink(destination:AufnahmeUI(selectedTab: self.$selectedTab)
                .environmentObject(nearbyService)
                .environmentObject(AudioRecorder(nearbyService))
){
                Text("Speichern")
                    .font(.system(size: 28))
                    .foregroundColor(.white)
                    .frame(maxWidth: 320, maxHeight: 40)
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            }
     /*
        List{
                
           // Text("Datum und Zeit \(self.nearbyService.sitzung.datum,formatter:Self.goalFormatter)")
            Text("\(self.nearbyService.sitzung.datum,formatter:Self.goalFormatter)")
        
            Spacer()
            Section(header:Text((texts[13].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue)))){
                TextField((texts[13].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue)), text: $nearbyService.sitzung.title).textFieldStyle(RoundedBorderTextFieldStyle())
            }
            */
            
            /*
            Spacer()
            HStack {
                Button {
                    nearbyService.showBrowsesrController()
                } label: {
                    Text((texts[12].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue)))
                }
            }
            Spacer()
            NavigationLink(destination:AufnahmeUI()
                            .environmentObject(nearbyService)
                            .environmentObject(AudioRecorder(nearbyService))
            ){
                Text((texts[10].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue)))
            }
            */
            
        }.onAppear{
            nearbyService.startBrowser()
        }
    }
    
}


//struct SpielleiterUI_Previews: PreviewProvider {
//    static var previews: some View {
//        SpielleiterUI()
//
//    }
//}
