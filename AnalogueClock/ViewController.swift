//
//  ViewController.swift
//  AnalogueClock
//
//  Created by 유현재 on 01/06/2020.
//  Copyright © 2020 유현재. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var hourView: UIView!
    @IBOutlet weak var minuteView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var centerView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.secondTimerProcess(_:)), userInfo: nil, repeats: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    
    private func initView() {
        self.centerView.layer.cornerRadius = self.centerView.frame.width / 2
    }
    
    @objc
    private func secondTimerProcess(_ sender: Timer) {
        // 현재 시간
        let date = Date()
        
        // Calendar를 사용하여 현재 시간의 시, 분, 초 단위로 취득
        let calendar = Calendar(identifier: .gregorian)
        let dateComponets = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

        // 시침, 분침, 초침의 각도를 계산
        // 시침에 대해서는 분침에 따라서 조금씩 변화하기 때문에 분침 단위와 현재의 분침을 더하여 각도 계산
        let hourChangeValue = (60 * dateComponets.hour!) + dateComponets.minute!
        let hourAngle = CGAffineTransform(rotationAngle: CGFloat(2.0 * .pi * Double(hourChangeValue) / (60 * 12)))
        let minuteAngle = CGAffineTransform(rotationAngle: CGFloat(2.0 * .pi * Double(dateComponets.minute!) / 60))
        let secondAngle = CGAffineTransform(rotationAngle: CGFloat(2.0 * .pi * Double(dateComponets.second!) / 60))

        // 애니메이션으로 움직임을 표시 딱딱함 0.1 부드럽게 2
        UIView.animate(withDuration: 0.1) {
            self.hourView.transform = hourAngle
            self.minuteView.transform = minuteAngle
            self.secondView.transform = secondAngle
        }
    }
}

