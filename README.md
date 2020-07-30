# jsonwebtoken

A swift library to decode JWT and verify JWT signatures.

### Why use this library?
`jsonwebtoken` is simple and focused, using SwiftyJSON to manage the JSON layer and native Apple APIs to perform signature verification.

Other swift JWT libraries either
- omit verification entirely or 
- outsource the work to openSSL, introducing complex dependency graphs which complicate deployment to server environments.

## Requirements
- macOS 10.14+, linux
- swift tools 5.2+

## Usage
the short version
```swift
// parse a token, -> JWT?
let jwt = JWT.Parse(token_string)

// access header metadata
print("type: \(jwt.header["typ"].string ?? "not_found"))

// access payload claims
print("path.to.element: \(jwt.payload["path"]["to"]["element"].string ?? "not_found"))

// validate the signature
if JWT.VerifyAuthenticity(of: token_string, withCert: certData, using: .rsaSignatureMessagePKCS1v15SHA256) {
    print("token is valid")
} else {
    print("token is not valid")
}
```

a more complete example
```swift
import jsonwebtoken

/* an example token from jwt.io
header = {
    "alg": "HS256",
    "typ": "JWT"
}
payload = {
    "sub": "1234567890",
    "name": "John Doe",
    "iat": 1516239022
}
*/
let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"

func demonstrate() {
    // parse the token to access its contents
    guard let jwt = JWT.Parse(token) else {
        print("ERROR: failed to parse token")
        return
    }

    // access the headers in SwiftyJSON style
    if let type = jwt.header["typ"].string {
        // will print "found type: JWT"
        print("found type: \(type)") 
    } else {
        print("no 'typ' found in header")
    }

    // access the payload in SwiftyJSON style
    if let name = jwt.payload["name"].string {
        // will print "found type: JWT"
        print("found type: \(type)")
    } else {
        print("no 'typ' found in header")
    }
}
```

## Integration
### Swift Package Manager
Add the package dependency to Package.swift like so:
```swift
let package = Package(
    name: "server",
    dependencies: [
        .package(url: "https://github.com/whilesoftware/jsonwebtoken.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "server",
            dependencies: [
                "jsonwebtoken"
            ]
        ),
        .testTarget(
            name: "serverTests",
            dependencies: ["server"]),
    ]
)
```

