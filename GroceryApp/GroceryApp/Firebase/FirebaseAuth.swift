//
//  FirebaseAuth.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 15.02.25.
//

import FirebaseAuth

final class FirebaseAuth {
    private let auth = Auth.auth()

    func isLoggedIn() -> Bool {
        return auth.currentUser != nil
    }

    func login(
        email: String,
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            DispatchQueue.main.async {
                completion(.success(()))
            }
        }
    }

    func logout(completion: @escaping (Result<Bool, Error>) -> Void) {
        do {
            try auth.signOut()
        } catch {
            print("Couldn't log out!")
            completion(.failure(Errors.LogoutFailed))
        }
        completion(.success(true))
    }


    func register(
        email: String,
        password: String,
        name: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                completion(.failure(Errors.RegisterFailed))
                return
            }
            self.editUserName(userName: name) { success in
                switch success {
                case .success():
                    break
                case .failure(_):
                    completion(.failure(Errors.RegisterFailed))
                }
            }
            DispatchQueue.main.async {
                completion(.success(()))
            }
        }
    }

    func editUserName(
        userName: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        guard let user = auth.currentUser else {
            completion(.failure(Errors.UserNameUpdateFailed))
            return
        }

        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = userName

        changeRequest.commitChanges { error in
            if error != nil {
                completion(.failure(Errors.UserNameUpdateFailed))
                return
            }
            completion(.success(()))
        }

    }

    func editEmail(newEmail: String, password: String,
                   completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = auth.currentUser, let email = user.email else {
            completion(.failure(Errors.EmailUpdateFailed))
            return
        }

        let credentials = EmailAuthProvider.credential(withEmail: email, password: password)

        user.reauthenticate(with: credentials) { error, _  in
            guard error != nil else {
                completion(.failure(Errors.EmailUpdateFailed))
                return
            }

            user.sendEmailVerification { error in
                if error != nil {
                    completion(.failure(Errors.EmailUpdateFailed))
                    return
                }
                completion(.success(()))
            }
        }
    }
}
