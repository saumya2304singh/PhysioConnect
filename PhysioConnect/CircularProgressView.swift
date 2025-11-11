//
//  CircularProgressView.swift
//  PhysioConnect
//
//  Created by user@8 on 11/11/25.
//

import UIKit

// MARK: - Animated Circular Progress View
final class CircularProgressView: UIView {

    private let trackLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    private let percentageLabel = UILabel()

    private var progressValue: CGFloat = 0.0

    init(progress: CGFloat) {
        self.progressValue = progress
        super.init(frame: .zero)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        // Circle path centered in 80x80 view
        let path = UIBezierPath(arcCenter: CGPoint(x: 40, y: 40),
                                radius: 35,
                                startAngle: -.pi/2,
                                endAngle: 1.5 * .pi,
                                clockwise: true)

        trackLayer.path = path.cgPath
        trackLayer.strokeColor = UIColor.systemGray5.cgColor
        trackLayer.lineWidth = 8
        trackLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(trackLayer)

        progressLayer.path = path.cgPath
        progressLayer.strokeColor = UIColor(hex: "1E6EF7").cgColor
        progressLayer.lineWidth = 8
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeEnd = 0
        progressLayer.lineCap = .round
        layer.addSublayer(progressLayer)

        percentageLabel.textAlignment = .center
        percentageLabel.font = .boldSystemFont(ofSize: 16)
        percentageLabel.textColor = UIColor(hex: "1E6EF7")
        percentageLabel.text = "0%"
        percentageLabel.frame = CGRect(x: 0, y: 25, width: 80, height: 30)
        addSubview(percentageLabel)
    }

    // Animate ring + count-up label
    func setProgress(to newValue: CGFloat, withAnimation: Bool = true, duration: CFTimeInterval = 1.2) {
        let clamped = min(max(newValue, 0), 1)
        let from = progressLayer.presentation()?.strokeEnd ?? progressLayer.strokeEnd

        if withAnimation {
            let anim = CABasicAnimation(keyPath: "strokeEnd")
            anim.fromValue = from
            anim.toValue = clamped
            anim.duration = duration
            anim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            progressLayer.strokeEnd = clamped
            progressLayer.add(anim, forKey: "progressAnim")
        } else {
            progressLayer.strokeEnd = clamped
        }

        animateLabel(to: Int(clamped * 100), duration: duration)
    }

    private func animateLabel(to target: Int, duration: CFTimeInterval) {
        let steps = 30
        let interval = duration / CFTimeInterval(steps)
        var current = 0
        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            current += 1
            let t = Double(current) / Double(steps)
            let value = Int(t * Double(target))
            self.percentageLabel.text = "\(value)%"
            if current >= steps { self.percentageLabel.text = "\(target)%"; timer.invalidate() }
        }
    }
}
