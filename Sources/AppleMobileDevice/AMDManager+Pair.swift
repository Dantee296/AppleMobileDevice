//
//  File.swift
//
//
//  Created by QAQ on 2023/8/11.
//

import AnyCodable
import Foundation
import libAppleMobileDevice

public extension AppleMobileDeviceManager {
    class PairRecord: CodableRecord {
        public var deviceCertificate: Data? { decode("DeviceCertificate") }
        public var escrowBag: Data? { decode("EscrowBag") }
        public var hostCertificate: Data? { decode("HostCertificate") }
        public var hostID: String? { decode("HostID") }
        public var hostPrivateKey: Data? { decode("HostPrivateKey") }
        public var rootCertificate: Data? { decode("RootCertificate") }
        public var rootPrivateKey: Data? { decode("RootPrivateKey") }
        public var systemBUID: String? { decode("SystemBUID") }
        public var wifiMACAddress: String? { decode("WiFiMACAddress") }
    }

    func obtainSystemBUID() -> String? {
        var buf: UnsafeMutablePointer<CChar>?
        guard usbmuxd_read_buid(&buf) == 0, let buf else { return nil }
        let ret = String(cString: buf)
        free(buf)
        return ret.isEmpty ? nil : ret
    }

    func obtainPairRecord(udid: String) -> PairRecord? {
        var result: AnyCodable?
        var buf: UnsafeMutablePointer<CChar>?
        var len: Int32 = 0
        usbmuxd_read_pair_record(udid, &buf, &len)
        if let buf, len > 0 {
            let data = Data(bytes: buf, count: Int(len))
            result = try? PropertyListDecoder().decode(AnyCodable.self, from: data)
        }
        free(buf)
        guard let result else { return nil }
        return .init(store: result)
    }

    func isDevicePaired(udid: String, connection: ConnectionMethod = configuration.connectionMethod) -> Bool? {
        var result: Bool?
        requireDevice(udid: udid, connection: connection) { device in
            guard let device else { return }
            result = false
            requireLockdownClient(device: device, handshake: true) { client in
                guard client != nil else { return }
                result = true
            }
        }
        return result
    }

    func sendPairRequest(udid: String, connection: ConnectionMethod = configuration.connectionMethod) {
        requireDevice(udid: udid, connection: connection) { device in
            guard let device else { return }
            requireLockdownClient(device: device, handshake: true) { client in
                guard let client else { return }
                lockdownd_pair(client, nil)
            }
        }
    }

    func unpaireDevice(udid: String, connection: ConnectionMethod = configuration.connectionMethod) {
        requireDevice(udid: udid, connection: connection) { device in
            guard let device else { return }
            requireLockdownClient(device: device, handshake: true) { client in
                guard let client else { return }
                lockdownd_unpair(client, nil)
            }
        }
    }
}
