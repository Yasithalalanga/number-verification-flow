import ballerina/http;
import ballerina/io;

configurable string enterpriseBEUrl = ?;
configurable string enterpriseBETokenUrl = ?;
configurable string enterpriseBEClientId = ?;
configurable string enterpriseBEClientSecret = ?;

final http:Client enterpriseBackendClient = check new (enterpriseBEUrl,
    auth = {
        tokenUrl: enterpriseBETokenUrl,
        clientId: enterpriseBEClientId,
        clientSecret: enterpriseBEClientSecret
    }
);

configurable string supplierBMOUrl = ?;
configurable string supplierBMOTokenUrl = ?;
configurable string supplierBMOClientId = ?;
configurable string supplierBMOClientSecret = ?;

final http:Client supplierBMOClient = check new (supplierBMOUrl,
    auth = {
        tokenUrl: supplierBMOTokenUrl,
        clientId: supplierBMOClientId,
        clientSecret: supplierBMOClientSecret
    }
);

public function main() returns error? {
    // Initiate request
    NumberVerificationRequest req = {
        phoneNumber: "1234567890"
    };

    NetworkVerification response = check enterpriseBackendClient->/initiate\-request.post(req);
    io:println(response);

    // Get network status
    NetworkState networkState = check supplierBMOClient->/[response.url];
    io:println(networkState);

    // Verify number
    NumberVerification verificationResponse = check enterpriseBackendClient->/'check\-result.post(req);
    io:println(verificationResponse);
}
