//
//  ProfileCoordinator.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 15.02.25.
//

import SwiftUI

final class ProfileCoordinator: ObservableObject, Coordinator{
    @Published var path = [ProfileDestination]()
    private var auth: FirebaseAuth
    private var locationManager = LocationManager.shared

    var initialDestination: ProfileDestination!

    @MainActor
    init(firebaseAuth: FirebaseAuth) {
        self.auth = firebaseAuth

        let vm = ProfileViewModel(
            auth: auth,
            toLogin: { [weak self] in
                self?.transitionToLogin()
            },
            toRegister: { [weak self] in
                self?.transitionToRegister()
            },
            toMap: {
                self.transitionToMap()
            }
        )
        self.initialDestination = .profile(viewModel: vm)
    }

    func start() -> some View {
        ProfileCoordinatorView(coordinator: self)
    }

    private func profileDestination() -> ProfileDestination {
        .profile(
            viewModel: ProfileViewModel(
                auth: auth,
                toLogin: {
                    self.transitionToLogin()
                },
                toRegister: {
                    self.transitionToRegister()
                },
                toMap: {
                    self.transitionToMap()
                }
            )
        )
    }

    private func mapDestination() -> ProfileDestination {
        .map(viewModel: MapViewModel(locationManager: locationManager))
    }


    private func loginDestination() -> ProfileDestination {
        .login(viewModel: LoginViewModel(
            auth: auth,
            onSuccessfullLogin: {
                self.transitionToProfile()
            }
        ))
    }


    private func registerDestination() -> ProfileDestination {
        .register(viewModel: RegisterViewModel(
            auth: auth,
            onSuccessRegister: {
                self.transitionToProfile()
            }
        ))
    }

    private func transitionToLogin(){
        self.path.append(self.loginDestination())
    }

    private func transitionToRegister(){
        self.path.append(self.registerDestination())
    }

    private func transitionToProfile(){
        path.removeAll()
    }

    private func transitionToMap(){
        self.path.append(self.mapDestination())
    }
}
