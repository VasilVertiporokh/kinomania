//
//  BaseViewController.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {

}

// MARK: - BaseViewProtocol
extension BaseViewController: BaseViewProtocol {
    func startLoading() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            return
        }

        if let loadingView = keyWindow.viewWithTag(LoadingView.tagValue) as? LoadingView {
            loadingView.isLoading = true
        } else {
            let loadingView = LoadingView(frame: UIScreen.main.bounds)
            keyWindow.addSubview(loadingView)
            loadingView.isLoading = true
        }
    }

    func stopLoading() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            return
        }

        keyWindow.viewWithTag(LoadingView.tagValue)?.removeFromSuperview()
    }

    func onError(_ error: Error?) {
        let alertController = UIAlertController(
            title: Localization.General.error,
            message: error?.localizedDescription,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: Localization.General.ok, style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    func onError(errorMessage: String?) {
        let alertController = UIAlertController(
            title: Localization.General.error,
            message: errorMessage,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: Localization.General.ok, style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
