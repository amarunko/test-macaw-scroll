//
//  MainView.swift
//  test-macaw-scroll
//
//  Created by Anton Marunko on 17/02/2019.
//  Copyright © 2019 exyte. All rights reserved.
//

import Foundation
import Macaw

final class MainView: MacawView {

    var scale = 1.0

    private var prevMovingPosition = CGPoint()

    required init?(coder aDecoder: NSCoder) {
        let currentNode = (try? SVGParser.parse(resource: "macaw-logo")) ?? Group()
        super.init(node: currentNode, coder: aDecoder)


    }

    override func touchesBegan(_ touches: Set<MTouch>, with event: MEvent?) {
        super.touchesBegan(touches, with: event)

        let location = touches.first!.location(in: self)
        //origLocation = location

        var transformedLocation = CGPoint(x: location.x, y: location.y)

        let transform = self.node.place
        transformedLocation.x -= CGFloat(transform.dx)
        transformedLocation.y -= CGFloat(transform.dy)

        gestureStart(at: location)
    }

    override func touchesMoved(_ touches: Set<MTouch>, with event: MEvent?) {
        super.touchesMoved(touches, with: event)

        let location = touches.first!.location(in: self)

        let move = Point(
            x: Double(location.x - prevMovingPosition.x),
            y: Double(location.y - prevMovingPosition.y)
        )
        prevMovingPosition = location

        node.place = node.place.move(dx: move.x, dy: move.y)
    }

    func gestureStart(at: CGPoint) {
        prevMovingPosition = CGPoint(x: at.x, y: at.y)
    }
}
