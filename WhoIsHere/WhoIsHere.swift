//
//  WhoIsHere.swift
//  WhoIsHere
//
//  Created by Marc on 07/02/2020.
//  Copyright © 2020 Marc. All rights reserved.
//

import Foundation
import Firebase

struct WhoIsWhere {
    static let studentRef = Database.database().reference(withPath: "students")
    
    static func createMe() {
        guard
            let user = Auth.auth().currentUser,
            let login = user.email else { return }
        
        let name = "Marc"
        
        let me = Student(name:name, login: login)
        let meRef = studentRef.child(name.lowercased())
        meRef.setValue(me.toAnyObject())
    }
    
    static func createStudent(name: String, login: String) {
        let student = Student(name: name, login: login)
        let ref = studentRef.child(name.lowercased())
        ref.setValue(student.toAnyObject())
    }
    
    static func synchronize() {
        studentRef
            .queryOrdered(byChild: "name")
            .observe(.value, with: { snapshot in
                let students = snapshot.children
                    .compactMap( { $0 as? DataSnapshot } )
                    .compactMap(Student.init)
                print("Students : \(students)")
            }
        )
    }
}
