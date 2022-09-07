//
//  ProfileHost.swift
//  Bachelorarbeit
//
//  Created by JT X on 18.10.20.
//

import SwiftUI

struct ProfileHost: View {
    @Environment(\.editMode) var mode
    @EnvironmentObject var userData: UserData
    @State var draftProfile = Profile.default
    @StateObject var loginVM = LoginViewModel()
    @StateObject var uploadVM = uploadViewModel()
    
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 20) {
            HStack{
            Image(systemName: loginVM.isAuthenticated ? "lock.fill": "lock.open")
            Button("login") {
                loginVM.login()
            }
            }
            Button("upload") {
                uploadVM.UploadAudioFiles()
            }
            
            HStack {
                if self.mode?.wrappedValue == .active {
                    Button("Cancel") {
                        self.draftProfile = self.userData.profile
                        self.mode?.animation().wrappedValue = .inactive
                    }
                }
                
                Spacer()
                
                Button(self.mode?.wrappedValue == .active ? "Done" : "Edit") {
                    self.mode?.animation().wrappedValue = (self.mode?.wrappedValue == .active ?  .inactive : .active)
                }
            }
            if self.mode?.wrappedValue == .inactive {
                ProfileSummary()
                    .environmentObject(userData)
            } else {
                ProfileEditor(profile: $draftProfile)
                    .onAppear {
                        self.draftProfile = self.userData.profile
                    }
                    .onDisappear {
                        self.userData.profile = self.draftProfile
                    }
            }
            
            
        }
        .padding()
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost().environmentObject(UserData())
    }
}
