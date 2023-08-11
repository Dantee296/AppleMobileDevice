//
//  AppleMobileDeviceManager.swift
//
//
//  Created by QAQ on 2023/8/10.
//

import AnyCodable
import Foundation
import libAppleMobileDevice

public class AppleMobileDeviceManager {
    public static let shared = AppleMobileDeviceManager()

    private init() {}

    public struct Configuration {
        public var connectionMethod: ConnectionMethod = .usbPreferred
    }

    public static var configuration: Configuration = .init()

    public class CodableRecord: Codable, Equatable, Hashable, Identifiable {
        public var id: UUID = .init()

        public internal(set) var store: AnyCodable
        public init() { store = .init([String: String]()) }
        public init(store: AnyCodable) { self.store = store }

        var dictionary: [String: Any] { store.value as? [String: Any] ?? [:] }

        func decode<T: Codable>(_ key: String) -> T? {
            (store.value as? [String: Any])?[key] as? T
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(store)
        }

        public static func == (lhs: CodableRecord, rhs: CodableRecord) -> Bool {
            lhs.store == rhs.store
        }
    }
}

#if DEBUG

    func generateDictionaryGetter(_ input: AnyCodable?) {
        var gen = [String]()
        (input?.value as? [String: Any])?.forEach { pair in
            let key = pair.key
            guard !key.isEmpty else { return }
            let keyName = key.first!.lowercased() + String(key.dropFirst())
            let value = pair.value
            let valueType = type(of: value)
            gen.append("public var \(keyName): \(valueType)? { decode(\"\(key)\") }")
        }
        gen.sort()
        gen.forEach { print($0) }
    }

#endif
