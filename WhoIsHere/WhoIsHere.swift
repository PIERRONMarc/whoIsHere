//
//  WhoIsHere.swift
//  WhoIsHere
//
//  Created by Etienne Vautherin on 07/02/2020.
//  Copyright © 2020 Etienne Vautherin. All rights reserved.
//

import Foundation
import Combine
import Firebase
import SwiftUI


struct WhoIsHere {
//    static let studentsRef = Database.database().reference(withPath: "students")
    
    static var subscriptions = Set<AnyCancellable>()

//    static func createMe() {
//        print("Create Me")
//
////        guard
////            let user = Auth.auth().currentUser,
////            let login = user.email else { return }
//
//        let name = "Etienne"
//        let login = "etienne@vautherin.com"
//
//        let me = Student(name: name, login: login)
//        let meRef = studentsRef.child(name.lowercased())
//        meRef.setValue(me.toAnyObject())
//    }
        
    static func createStudent(name: String, login: String, image: UIImage) {
        let student = Student(name: name, login: login, image: image)
        CloudStorage.Students.add(student: student)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .failure(let error): print("\(error.localizedDescription)")
                case .finished: print("Student added")
                }
            }) { _ in }
            .store(in: &subscriptions)
    }
    
//    static func signIn(mail: String) {
//        
//    }
            
//    static func synchronize() {
//
//        studentsRef
//            .queryOrdered(byChild: "name")
//            .observe(.value, with: { snapshot in
//                let students = snapshot.children
//                    .compactMap({ $0 as? DataSnapshot })
//                    .compactMap(Student.init)
//
//                print("Students: \(students)")
//            })
//    }
    
}
