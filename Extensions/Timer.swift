//
//  Timer.swift
//  Swift_xhl
//
//  Created by xhl on 2021/6/24.
//

import UIKit

public class GCDTimer {

    static var timers_    = [String:DispatchSourceTimer]()
    static var semaphore_ = DispatchSemaphore(value: 1)

    /// GCD定时器
    /// - Parameters:
    ///   - interval: 间隔时间
    ///   - isAsync: 是不是分线程执行
    ///   - task: 执行任务
    /// - Returns: 线程的标识
    static public func exectTask(repeating interval:DispatchTimeInterval = .seconds(1),
                                 _ isAsync:Bool = false,
                                 _ after:DispatchTimeInterval = .seconds(0),
                                 _ task:@escaping () -> () ) -> String?{
        
        let queue:DispatchQueue = isAsync ? DispatchQueue.global() : DispatchQueue.main
        let timer = DispatchSource.makeTimerSource(queue: queue)
        timer.schedule(deadline: .now() + after, repeating: interval)
        
        semaphore_.wait() //线程加锁
        let name = String(timers_.count)//定时器的唯一标识
        timers_[name] = timer //存放到字典中
        semaphore_.signal() //线程解锁
        
        timer.setEventHandler {
            task()
        }
        timer.resume()
        return name
    }
    
    static public func cancelTask(_ name:String) {
        
        let timer = timers_[name]
        semaphore_.wait()
        if timer != nil{
            timer?.cancel()
            timers_.removeValue(forKey: name)
        }
        semaphore_.signal()
    }
}
