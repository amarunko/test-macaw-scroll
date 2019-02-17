//
//  ViewController.swift
//  test-macaw-scroll
//
//  Created by Anton Marunko on 17/02/2019.
//  Copyright © 2019 exyte. All rights reserved.
//

import UIKit
import Macaw

final class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var mainView: MainView!

    var currentScale: CGFloat = 1.0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestures()
    }

    // MARK: - Private

    private func setupGestures() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(gestureRecognizer:)))

        pinchGesture.delegate = self
        mainView.addGestureRecognizer(pinchGesture)
    }

    @objc private func handlePinch(gestureRecognizer: UIPinchGestureRecognizer) {
        let scale = gestureRecognizer.scale

        switch gestureRecognizer.state {
        case .changed:

            currentScale = currentScale * scale

            mainView.scale = Double(currentScale)

            let location = gestureRecognizer.location(in: mainView)
            let dx = Double(location.x * (1 - scale))
            let dy = Double(location.y * (1 - scale))

            mainView.node.place = mainView.node.place
                .scale(sx: Double(currentScale), sy: Double(currentScale))
                .move(dx: dx, dy: dy)
        default: break
        }
    }

    //MARK: - UIGestureRecognaizerDelegate

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {

        return true
    }
}

