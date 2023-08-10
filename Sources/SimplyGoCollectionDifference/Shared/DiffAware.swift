//
//  MainQueue+Synchronous.swift
//  Msgr
//
//  Created by Aung Ko Min on 12/10/22.
//
import Foundation

public protocol DiffAware {
    associatedtype DiffId: Hashable
    
    var diffId: DiffId { get }
    static func compareContent(_ a: Self, _ b: Self) -> Bool
}

public extension DiffAware where Self: Hashable {
    var diffId: Self {
        return self
    }
    
    static func compareContent(_ a: Self, _ b: Self) -> Bool {
        return a == b
    }
}

extension Int: DiffAware {}
extension String: DiffAware {}
extension Character: DiffAware {}
extension UUID: DiffAware {}
