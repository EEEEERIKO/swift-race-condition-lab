# Swift Race Condition Lab

A Swift Playground exploring **race conditions, shared mutable state, and thread synchronization** using `Thread` and `NSLock`.

This project demonstrates how concurrent access to a shared counter can cause race conditions and how mutual exclusion helps ensure thread-safe updates.

## Learning Objectives

- Understand race conditions in multithreaded programming.
- Explore concurrent execution using `Thread`.
- Identify risks associated with shared mutable state.
- Prevent concurrent modification issues using `NSLock`.
- Compare unsafe and synchronized implementations.
- Understand the role of `@unchecked Sendable` in Swift concurrency.

## Implementations

### 1. Unsafe Counter

The `CounterUnsafe` class increments a shared integer without synchronization.

Two threads each perform 1,000 increments. Because `value += 1` is not an atomic operation, concurrent updates can be lost.

The final value may be less than 2,000, although an individual run may still produce the expected result.

### 2. Safe Counter

The `CounterSafe` class uses `NSLock` to protect access to the shared counter.

- `lock.lock()` acquires the lock before modifying or reading the value.
- `defer { lock.unlock() }` ensures the lock is released when the method exits.
- The counter's value is private, so access goes through synchronized methods.

When both threads complete successfully, the final counter value should be exactly 2,000.

## Technologies

- Swift
- Foundation
- `Thread`
- `NSLock`
- `@unchecked Sendable`
- Xcode Playgrounds

## Project Structure

```text
swift-race-condition-lab/
├── RaceConditionLab/
│   └── main.swift
└── README.md
```

## Getting Started

1. Clone the repository:

   ```bash
   git clone https://github.com/EEEEERIKO/swift-race-condition-lab.git
   ```

2. Open `RaceConditionLab` in Xcode.
3. Run the Playground.
4. Compare the output of the unsafe and safe implementations.

## Expected Results

| Implementation | Expected behavior |
|---|---|
| `CounterUnsafe` | The final value is not guaranteed to be 2,000. |
| `CounterSafe` | The final value should be 2,000. |

## Key Concepts

**Race condition:** A defect that occurs when a program's result depends on the timing or interleaving of concurrent operations.

**Mutual exclusion:** A synchronization mechanism that ensures only one thread at a time can execute a protected critical section.

**Thread safety:** The ability of code to behave correctly when accessed concurrently.

**`NSLock`:** A Foundation locking primitive used to protect shared mutable state.

**`@unchecked Sendable`:** An annotation that transfers responsibility for validating thread safety from the compiler to the developer. It does not make a class thread-safe by itself.

## Author

Erik Valencia Cardona

## License

This project is intended for educational purposes.
