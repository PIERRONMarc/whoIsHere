//
//  WelcomeView.swift
//  FirebaseLogin
//
//  Created by Mavis II on 9/2/19.
//  Copyright © 2019 Bala. All rights reserved.
//

import SwiftUI
import Firebase

public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}


struct SignOutButton: View {
    @Binding var MainviewState: CGSize
    @Binding var viewState: CGSize

    var body: some View {
        Button(action: {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                ObservableModel.shared.connected = false
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }

            self.MainviewState = CGSize(width: screenWidth, height: 0)
            self.viewState = CGSize(width: 0, height: 0)

        }, label: {
            Text("Sign Out")
                .foregroundColor(Color.white)
                .padding()
        })
        .background(Color.green)
        .cornerRadius(5)
    }
}


struct CreateStudentView: View {
    @State var studentName: String = ""
    @State var studentLogin: String = ""
    @State var image: Image? = nil
    @State var uiImage: UIImage? = nil
    @State var showCaptureImageView: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                Button(action: {
                    self.showCaptureImageView.toggle()
                }) {
                    Text("Choose photos")
                }
                image?.resizable()
                    .frame(width: 250, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
            }
            if (showCaptureImageView) {
                CaptureImageView(
                    isShown: $showCaptureImageView,
                    image: $image,
                    uiImage: $uiImage
                )
            }
            VStack {
                TextField("Student name", text: $studentName)
                TextField("user@domain.com", text: $studentLogin)
            }
            .padding(10)
            Button(action: {
                guard let uiImage = self.uiImage else { return }

                print("\(self.studentName)")
                print("\(self.studentLogin)")
                WhoIsHere.createStudent(
                    name: self.studentName,
                    login: self.studentLogin,
                    image: uiImage
                )
            }, label: {
                Text("Create Student")
                    .foregroundColor(Color.white)
                    .padding()
            })
                .background(Color.green)
                .cornerRadius(5)
        }
    }
}


struct AuthenticatedView: View {
    @Binding var MainviewState: CGSize
    @Binding var viewState: CGSize

    @ObservedObject var model = ObservableModel.shared

    var body: some View {
        VStack{
            AppTitleView(Title: "Home")
            Spacer()


            List(model.students) { (student) in
                CardView(image: student.image, name: student.name, login: student.login)
            }
//            ScrollView(.vertical) {
//                ForEach(model.students, id: \.self) { (student) in
//                    CardView(image: student.image, name: student.name, login: student.login)
//
//                }
//            }
        }
        .edgesIgnoringSafeArea(.top).background(Color.white)
        .offset(x: self.MainviewState.width).animation(.spring())
    }
}


struct SigningView: View {
    @Binding var MainviewState: CGSize
    @Binding var viewState: CGSize

    @State var signUpIsPresent: Bool = false
    @State var signInIsPresent: Bool = false

    var body: some View {

        VStack {
            AppTitleView(Title: "Welcome")
            Spacer()
            VStack(spacing:20) {

                Button(action: {self.signUpIsPresent = true}){
                    Text("Sign Up")
                }.sheet(isPresented: self.$signUpIsPresent){
                    SignUpView()
                }

                Button(action: {self.signInIsPresent = true}){
                    Text("Sign In")
                }.sheet(isPresented: $signInIsPresent) {

                SignInView(onDismiss:{
                    self.viewState = CGSize(width: screenWidth, height: 0)
                    self.MainviewState = CGSize(width: 0, height: 0)
                })}}
            
                Spacer()

        }
        .edgesIgnoringSafeArea(.top).edgesIgnoringSafeArea(.bottom)
        .offset(x:self.viewState.width).animation(.spring())
    }
}


struct WelcomeView: View {
    @Binding var connected: Bool

    @State var viewState = CGSize.zero
    @State var MainviewState =  CGSize.zero
        
    var body: some View {
        ZStack{
            if (connected) {
                VStack {
                    CreateStudentView()
                    Spacer()
                    SignOutButton(MainviewState: $MainviewState, viewState: $viewState)
                }
            } else {
                SigningView(MainviewState: $MainviewState, viewState: $viewState)
            }
            
            Button(action: { CloudStorage.Students.set(inside: true, login: "Etienne@vautherin.com")}){
                Text("Test inside")
            }
        }
        .tabItem {
            VStack {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
        .tag(1)
    }
}



//struct WelcomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        WelcomeView(connected: true)
//    }
//}
