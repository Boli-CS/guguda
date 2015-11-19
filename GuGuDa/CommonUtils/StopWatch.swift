//
//  StopWatch.swift
//  GuGuDa
//
//  Created by boli on 11/19/15.
//  Copyright © 2015 boli. All rights reserved.
//


/// 秒表类，用于统计已经运动的时长
class StopWatch {
    /// 已经计时的秒钟数
    var seconds : Double?
    
    /// 上一次计时开始时间
    var startDate : NSDate?
    
    /// 秒表当前状态
    var state : StopWatchStateEnum?
    
    init() {
        self.seconds = 0.0
        self.state = StopWatchStateEnum.UNSTART
    }
    
    func getSeconds() -> Double? {
        if(self.state == StopWatchStateEnum.COUNTING) {
            let timeInterval = NSDate().timeIntervalSinceDate(startDate!)
            self.seconds = Double(timeInterval) + self.seconds!
        }
        return self.seconds
    }
    
    func start() {
        self.startDate = NSDate()
        self.state = StopWatchStateEnum.COUNTING
    }
    
    func pause() {
        self.state = StopWatchStateEnum.PAUSE
    }
    
    func resume() {
        self.start()
    }
    
    func stop() {
        self.state = StopWatchStateEnum.STOP
    }
}