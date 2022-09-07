//
//  ProfileSummary.swift
//  Bachelorarbeit
//
//  Created by JT X on 18.10.20.
//


import SwiftUI

struct ProfileSummary: View {
    @State var submit = false
   // @StateObject var locationManager = LocationManager()
    @StateObject var locationViewModel = LocationViewModel()
//    var profile: Profile
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var selectedLang : LanguageSettings

    /*
    var userLatitude : String{
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }
    var userLongitude: String {
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }
    */
    var userLatitude: String{
        return "\(locationViewModel.lastSeenLocation?.coordinate.latitude ?? 0)"
    }
       
    var userLongitude: String{
        return "\(locationViewModel.lastSeenLocation?.coordinate.longitude ?? 0)"
    }
    var userCity: String{
        return "\(locationViewModel.currentPlacemark?.locality ?? "")"
    }
    var userCountry: String{
        return "\(locationViewModel.currentPlacemark?.country ?? "")"
    }
   
    var body: some View {
        NavigationView{
        Form{
            Text(userData.profile.username).bold()
            
       //     Text("Geschlecht: \(userData.profile.Geschlecht.rawValue)")
            Text("Geschlecht: \(userData.profile.Geschlecht)")
            
         //   Text(texts[5].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue) + ":" \(userData.profile.Geschlecht.rawValue))
            
            Text("Alter:\(userData.profile.Alter)")
            
            Text("Regionale Herkunft:\(userData.profile.regionaleHerkunft)")
            
            Button(action: {
                locationViewModel.requestPermission()
            }, label: {
                Label("Allow tracking", systemImage: "location")
            })
            
          //  Text("Latitude: \(userLatitude)")
         //   Text("Longitude: \(userLongitude)")
            Text("City:\(userCity)")
            Text("County: \(userCountry)")
            
//            Button(action: {
//                locationViewModel.requestPermission()
//            }, label: {
//                Label("From Adress Book", systemImage: "book")
//            })
            }
          
        .navigationBarTitle("Persönliche Daten")
        .onDisappear {
            self.userData.profile.userLatitude = userLatitude
            self.userData.profile.userLongitude = userLongitude
            self.userData.profile.userCity = userCity
            self.userData.profile.userCountry = userCountry
        }
    }
}
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary()
    }
}

