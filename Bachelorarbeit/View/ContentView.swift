//
//  ContentView.swift
//  Bachelorarbeit
//
//  Created by JT X on 12.10.20.
//

import SwiftUI

enum ActiveSheet {
   case first, second
}

struct ContentView: View {
 
    @StateObject var loginVM = LoginViewModel()
    @State var webService = Webservice()
   
   @State var isLeftNav = false
   @State var show = false
   @EnvironmentObject var userData: UserData
   @EnvironmentObject var selectedLanguage : LanguageSettings
   @State private var isShowPresented: Bool = false
   @State private var activeSheet: ActiveSheet = .first

    let texts : [String]
    @EnvironmentObject var selectedLang : LanguageSettings
    @EnvironmentObject var audioRecorder: AudioRecorder
    @EnvironmentObject var nearbyService: NearbyService
    
    @State private var selectedTab:Int = 0
    
    init(texts:[String]) {
          UITableView.appearance().backgroundColor = .white
        self.texts = texts
          }
   
   var profileButton: some View {
       Button(action: {
           isShowPresented = true
           self.activeSheet = .first
       }) {
           Image(systemName: "person.crop.circle")
               .imageScale(.large)
               .accessibility(label: Text("User Profile"))
               .padding()
       }
   }
   
   var settingButton : some View{
       Button(action: {
           isShowPresented = true
           self.activeSheet = .second
       }) {
           //Image(systemName: "slider.horizontal.3")
           Text(texts[34].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue))
       } //: BUTTON
      
   }
   

   
   var body: some View {
       
       let service = NearbyService(displayName: userData.profile.username,userData)
       TabView(selection: self.$selectedTab){
           ProfileHost()
               .environmentObject(self.userData)
               .tabItem{
                     Image(systemName: "person")
            }.tag(0)
           
       NavigationView{
              List{
          // VStack{
         //         TextField("username", text: $loginVM.username)
         //         TextField("password", text: $loginVM.password)
        //          Button("login") {
        //              loginVM.login()
        //          }
                  
                  NavigationLink(destination:AufnahmeUI(selectedTab: self.$selectedTab)
                                  .environmentObject(AudioRecorder(service))
                                  .environmentObject(service)
                  ){
                      VStack{
                          HStack{
                              if #available(iOS 15.0, *) {
                                  Image(systemName: "person.2.fill").foregroundColor(.indigo).font(.system(size:80)).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                              } else {
                                  // Fallback on earlier versions
                              }
                          }
                      Spacer()
                          HStack{
                              VStack{
                                  // Ich bin
                                  let IchBin = texts[30]
                                  Text((IchBin.localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue))).font(.system(size: 14, weight: .medium)).frame(maxWidth:.infinity, alignment: .leading)
                                  //Mitspieler
                                  let textMitspieler = texts[32]
                                  Text((textMitspieler.localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue))).font(.system(size: 32, weight: .bold)) .frame(maxWidth:.infinity, alignment: .leading)
                              }
                          } .frame(maxWidth: .infinity)
                              .padding(12)
                              .background(Color(#colorLiteral(red: 0.8509804010391235, green: 0.8509804010391235, blue: 0.8509804010391235, alpha: 0.27000001072883606)).opacity(0.8))
                  }
                   //   .frame(maxWidth: 800,   maxHeight: 220)
                      .frame(maxWidth: 800,   maxHeight: 180)
                      .background(Color(#colorLiteral(red: 0.9764705896377563, green: 0.9764705896377563, blue: 0.9764705896377563, alpha: 1)))
                      .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                      .shadow(color: Color.gray.opacity(0.3), radius: 20, x: 0, y: 10)
              }
                  // 放到这之前
                  
                  
                   NavigationLink(destination:SpielleiterUI(selectedTab: self.$selectedTab)
                                   .environmentObject(service)
                   )
                  
                  
                  {
                       
                       VStack{
                           HStack{
                               Image(systemName: "person.fill").foregroundColor(.yellow).font(.system(size:80)).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                           }
                           HStack{
                               VStack{
                                   // Ich bin
                                   let IchBin = texts[30]
                                   Text((IchBin.localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue))).font(.system(size: 14, weight: .medium)).frame(maxWidth:.infinity, alignment: .leading)
                                   
                                   // Spielleiter
                                   let textSpielleiter = texts[31]
                                   Text((textSpielleiter.localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue))).font(.system(size: 32, weight: .bold)) .frame(maxWidth:.infinity, alignment: .leading)
                               }
                           }.frame(maxWidth: .infinity)
                               .padding(12)
                               .background(Color(#colorLiteral(red: 0.8509804010391235, green: 0.8509804010391235, blue: 0.8509804010391235, alpha: 0.27000001072883606)).opacity(0.8))
                   
                   }
                       .frame(maxWidth: 800,   maxHeight: 180)
                       .background(Color(#colorLiteral(red: 0.9764705896377563, green: 0.9764705896377563, blue: 0.9764705896377563, alpha: 1)))
                      .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                      .shadow(color: Color.gray.opacity(0.3), radius: 20, x: 0, y: 10)
                   }
               //    Spacer()
                  
           }
               .navigationTitle(Text("GroupRecorder"))
    //       .navigationBarItems(leading: profileButton, trailing: settingButton)
               .navigationBarItems(trailing: settingButton)
           
           .sheet(isPresented:self.$isShowPresented){
               if self.activeSheet == .first {
                   ProfileHost()
                       .environmentObject(self.userData)
               }else {
                   SettingView().environmentObject(selectedLanguage)
               }
           }
           .onAppear{
               service.stopBrowser()
               service.stopAdvertising()
           }
           
       }
       .padding()
       .tabItem{
                Image(systemName: "mic")
       }.tag(1)
          
      /*     RecordingList(audioRecorder: audioRecorder).tabItem{
               Image(systemName: "folder")
               */
     /*      RecordingList(audioRecorder: audioRecorder).tabItem{
                        Image(systemName: "folder")
               */
           showFiles()
               .environmentObject(AudioRecorder(service))
               .environmentObject(service)
               .tabItem{
               Image(systemName: "folder")
      }.tag(2)
       }
            .onAppear{
                UITabBar.appearance().barTintColor = .white
            }
            .accentColor(.blue)
       
   }
}




struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
       ContentView( texts:texts).environmentObject(UserData())   .environmentObject(LanguageSettings())//.environmentObject(AudioRecorder(NearbyService(displayName: "",UserData())))
   }
}




