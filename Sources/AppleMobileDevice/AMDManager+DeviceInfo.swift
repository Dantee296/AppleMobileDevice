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
    func listDeviceIdentifiers() -> [String] {
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

    class DeviceRecord: CodableRecord {
        public var activationState: String? { decode("ActivationState") }
        public var activationStateAcknowledged: Bool? { decode("ActivationStateAcknowledged") }
        public var basebandActivationTicketVersion: String? { decode("BasebandActivationTicketVersion") }
        public var basebandCertId: Int? { decode("BasebandCertId") }
        public var basebandChipID: Int? { decode("BasebandChipID") }
        public var basebandMasterKeyHash: String? { decode("BasebandMasterKeyHash") }
        public var basebandRegionSKU: Data? { decode("BasebandRegionSKU") }
        public var basebandSerialNumber: Data? { decode("BasebandSerialNumber") }
        public var basebandStatus: String? { decode("BasebandStatus") }
        public var basebandVersion: String? { decode("BasebandVersion") }
        public var bluetoothAddress: String? { decode("BluetoothAddress") }
        public var boardId: Int? { decode("BoardId") }
        public var bootSessionID: String? { decode("BootSessionID") }
        public var brickState: Bool? { decode("BrickState") }
        public var buildVersion: String? { decode("BuildVersion") }
        public var cpuArchitecture: String? { decode("CPUArchitecture") }
        public var certID: Int? { decode("CertID") }
        public var chipID: Int? { decode("ChipID") }
        public var chipSerialNo: Data? { decode("ChipSerialNo") }
        public var deviceClass: String? { decode("DeviceClass") }
        public var deviceColor: String? { decode("DeviceColor") }
        public var deviceName: String? { decode("DeviceName") }
        public var dieID: Int? { decode("DieID") }
        public var ethernetAddress: String? { decode("EthernetAddress") }
        public var firmwareVersion: String? { decode("FirmwareVersion") }
        public var fusingStatus: Int? { decode("FusingStatus") }
        public var gid1: String? { decode("GID1") }
        public var gid2: String? { decode("GID2") }
        public var hardwareModel: String? { decode("HardwareModel") }
        public var hardwarePlatform: String? { decode("HardwarePlatform") }
        public var hasSiDP: Bool? { decode("HasSiDP") }
        public var humanReadableProductVersionString: String? { decode("HumanReadableProductVersionString") }
        public var iTunesHasConnected: Bool? { decode("iTunesHasConnected") }
        public var integratedCircuitCardIdentity2: String? { decode("IntegratedCircuitCardIdentity2") }
        public var integratedCircuitCardIdentity: String? { decode("IntegratedCircuitCardIdentity") }
        public var internationalMobileEquipmentIdentity2: String? { decode("InternationalMobileEquipmentIdentity2") }
        public var internationalMobileEquipmentIdentity: String? { decode("InternationalMobileEquipmentIdentity") }
        public var internationalMobileSubscriberIdentity2: String? { decode("InternationalMobileSubscriberIdentity2") }
        public var internationalMobileSubscriberIdentity: String? { decode("InternationalMobileSubscriberIdentity") }
        public var internationalMobileSubscriberIdentityOverride: Bool? { decode("InternationalMobileSubscriberIdentityOverride") }
        public var kctPostponementInfoPRIVersion: String? { decode("kCTPostponementInfoPRIVersion") }
        public var kctPostponementInfoPRLName: Int? { decode("kCTPostponementInfoPRLName") }
        public var kctPostponementInfoServiceProvisioningState: Bool? { decode("kCTPostponementInfoServiceProvisioningState") }
        public var kctPostponementStatus: String? { decode("kCTPostponementStatus") }
        public var mlbSerialNumber: String? { decode("MLBSerialNumber") }
        public var mobileSubscriberCountryCode: String? { decode("MobileSubscriberCountryCode") }
        public var mobileSubscriberNetworkCode: String? { decode("MobileSubscriberNetworkCode") }
        public var modelNumber: String? { decode("ModelNumber") }
        public var priVersion_Major: Int? { decode("PRIVersion_Major") }
        public var priVersion_Minor: Int? { decode("PRIVersion_Minor") }
        public var priVersion_ReleaseNo: Int? { decode("PRIVersion_ReleaseNo") }
        public var pairRecordProtectionClass: Int? { decode("PairRecordProtectionClass") }
        public var partitionType: String? { decode("PartitionType") }
        public var passwordProtected: Bool? { decode("PasswordProtected") }
        public var phoneNumber: String? { decode("PhoneNumber") }
        public var pkHash: Data? { decode("PkHash") }
        public var productName: String? { decode("ProductName") }
        public var productType: String? { decode("ProductType") }
        public var productVersion: String? { decode("ProductVersion") }
        public var productionSOC: Bool? { decode("ProductionSOC") }
        public var protocolVersion: String? { decode("ProtocolVersion") }
        public var proximitySensorCalibration: Data? { decode("ProximitySensorCalibration") }
        public var regionInfo: String? { decode("RegionInfo") }
        public var sim1IsEmbedded: Bool? { decode("SIM1IsEmbedded") }
        public var sim2GID1: Data? { decode("SIM2GID1") }
        public var sim2GID2: Data? { decode("SIM2GID2") }
        public var sim2IsEmbedded: Bool? { decode("SIM2IsEmbedded") }
        public var simGID1: Data? { decode("SIMGID1") }
        public var simGID2: Data? { decode("SIMGID2") }
        public var simStatus: String? { decode("SIMStatus") }
        public var simTrayStatus: String? { decode("SIMTrayStatus") }
        public var serialNumber: String? { decode("SerialNumber") }
        public var softwareBehavior: Data? { decode("SoftwareBehavior") }
        public var softwareBundleVersion: String? { decode("SoftwareBundleVersion") }
        public var telephonyCapability: Bool? { decode("TelephonyCapability") }
        public var timeIntervalSince1970: Double? { decode("TimeIntervalSince1970") }
        public var timeZone: String? { decode("TimeZone") }
        public var timeZoneOffsetFromUTC: Int? { decode("TimeZoneOffsetFromUTC") }
        public var uniqueChipID: Int? { decode("UniqueChipID") }
        public var uniqueDeviceID: String? { decode("UniqueDeviceID") }
        public var useRaptorCerts: Bool? { decode("UseRaptorCerts") }
        public var uses24HourClock: Bool? { decode("Uses24HourClock") }
        public var wifiAddress: String? { decode("WiFiAddress") }
    }

    func obtainDeviceInfo(
        udid: String,
        domain: String? = nil,
        key: String? = nil,
        connection: ConnectionMethod = configuration.connectionMethod
    ) -> DeviceRecord? {
        var result: AnyCodable?
        requireDevice(udid: udid, connection: connection) { device in
            guard let device else { return }
            requireLockdownClient(device: device) { client in
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
                    free(buf)
                    plist_free(plist)
                }
            }
        }
        guard let result else { return nil }
        return .init(store: result)
    }
}
