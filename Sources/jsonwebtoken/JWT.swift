import Foundation
import SwiftyJSON
import Crypto

public struct JWT {
    public let header:JSON
    public let payload:JSON
    public let signature:String
}

extension JWT {
    private static func GetJSONFromBase64String(_ string:String) -> JSON? {
        guard let data = Data(base64Encoded: string) else {
            return nil
        }
        return try? JSON(data: data)
    }
    
    public static func Parse(_ token:String) -> JWT? {
        let parts = token.split(separator: ".")
        guard parts.count == 3 else {
            return nil
        }
        
        // decode each base64url-encoded section
        let headerString = String(parts[0]).base64FromBase64Url
        let payloadString = String(parts[1]).base64FromBase64Url
        let signatureString = String(parts[2]).base64FromBase64Url
        
        guard let header = GetJSONFromBase64String(headerString) else {
            return nil
        }
        guard let payload = GetJSONFromBase64String(payloadString) else {
            return nil
        }
        
        return JWT(header: header, payload: payload, signature: signatureString)
    }
}

extension JWT {
    /*
     Credit to Jan Kaltoun for the approach found here
     https://blog.kaltoun.cz/verifying-rsa-jwt-signatures-in-swift/
     */
    public static func VerifyAuthenticity(of token:String, withCert data:Data) -> Bool {
        let parts = token.split(separator: ".")
        guard parts.count == 3 else {
            return false
        }
        
        let value = "\(parts[0]).\(parts[1])"
        let signature = String(parts[2])
        
        guard let valueData = value.data(using: .ascii) else {
            return false
        }
        guard let signatureData = Data(base64Encoded: signature.base64FromBase64Url, options: .ignoreUnknownCharacters) else {
            return false
        }
        
        guard let rsaKey = try? RSAKey.public(certificate: data) else {
            print("ERROR: failed to create RSA public key")
            return false
        }
        
        let rsa = RSA(algorithm: .sha256)
        
        do {
            let result = try rsa.verify(signatureData, signs: valueData, key: rsaKey)
            return result
        } catch {
            print("rsa verification failed")
            print(error)
            return false
        }
    }
    /*
    public static func VerifyAuthenticity(of token:String, withCert data:Data, using algorithm: SecKeyAlgorithm) -> Bool {
        let parts = token.split(separator: ".")
        guard parts.count == 3 else {
            return false
        }
        
        let value = "\(parts[0]).\(parts[1])"
        let signature = String(parts[2])
        
        guard let valueData = value.data(using: .ascii) as CFData? else {
            return false
        }
        guard let signatureData = Data(base64Encoded: signature.base64FromBase64Url, options: .ignoreUnknownCharacters) as CFData? else {
            return false
        }
        guard let certificate = SecCertificateCreateWithData(nil, data as CFData) else {
            return false
        }
        guard let publicKey = SecCertificateCopyKey(certificate) else {
            return false
        }
        
        return SecKeyVerifySignature(publicKey, algorithm, valueData, signatureData, nil)
    }
    */
}

extension JWT {
    public var string:String {
        "invalid"
    }
}
