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
    func listDevices() -> [String] {
        var deviceIdentifier = Set<String>()

        var dev_list: UnsafeMutablePointer<idevice_info_t?>?
        var count: Int32 = 0
        idevice_get_device_list_extended(&dev_list, &count)

        if let dev_list {
            for idx in 0 ..< Int(count) {
                if let udidCString = dev_list[idx]?.pointee.udid {
                    if let udid = String(cString: udidCString, encoding: .utf8) {
                        deviceIdentifier.insert(udid)
                    }
                }
            }
            idevice_device_list_extended_free(dev_list)
        }

        return Array(deviceIdentifier)
    }

    func obtainDeviceInfo(udid: String, domain: String? = nil, key: String? = nil, connection: ConnectionMethod = .any) -> AnyCodable? {
        var result: AnyCodable?
        useDevice(udid: udid, connection: connection) { device in
            guard let device else { return }
            useLockdownClient(device: device) { client in
                guard let client else { return }
                var plist: plist_t?
                lockdownd_get_value(client, domain, key, &plist)
                if let plist {
                    var buf: UnsafeMutablePointer<CChar>?
                    var len: UInt32 = 0
                    let error = plist_to_bin(plist, &buf, &len)
                    if error == PLIST_ERR_SUCCESS, let buf, len > 0 {
                        let data = Data(bytes: buf, count: Int(len))
                        if let ret = try? PropertyListDecoder().decode(AnyCodable.self, from: data) {
                            result = ret
                        }
                    }
                }
            }
        }
        return result
    }
}
