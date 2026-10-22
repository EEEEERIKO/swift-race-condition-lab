//
//  main.swift
//  RaceConditionLab
//
//  Created by Erik Valencia Cardona on 22/10/26.
//
import Foundation

// MARK: - 1. Unsafe Counter (Race Condition)

final class CounterUnsafe: @unchecked Sendable {
    var value = 0

    func increment() {
        value += 1
    }
}

func runUnsafeCounterTask() {
    let counter = CounterUnsafe()

    let thread1 = Thread {
        for _ in 1...1000 {
            counter.increment()
        }
    }

    let thread2 = Thread {
        for _ in 1...1000 {
            counter.increment()
        }
    }

    thread1.start()
    thread2.start()

    while thread1.isExecuting || thread2.isExecuting {
        usleep(100)
    }

    print("UNSAFE counter: \(counter.value)")
    print("Expected: 2000")
}


// MARK: - 2. Safe Counter (NSLock)

final class CounterSafe: @unchecked Sendable {
    private var value = 0
    private let lock = NSLock()

    func increment() {
        lock.lock()
        defer { lock.unlock() }

        value += 1
    }

    func currentValue() -> Int {
        lock.lock()
        defer { lock.unlock() }

        return value
    }
}

func runSafeCounterTask() {
    let counter = CounterSafe()

    let thread1 = Thread {
        for _ in 1...1000 {
            counter.increment()
        }
    }

    let thread2 = Thread {
        for _ in 1...1000 {
            counter.increment()
        }
    }

    thread1.start()
    thread2.start()

    while thread1.isExecuting || thread2.isExecuting {
        usleep(100)
    }

    print("SAFE counter: \(counter.currentValue())")
    print("Expected: 2000")
}


// MARK: - 3. Run Experiments

print("===== UNSAFE IMPLEMENTATION =====")
runUnsafeCounterTask()

print("\n===== SAFE IMPLEMENTATION =====")
runSafeCounterTask()
