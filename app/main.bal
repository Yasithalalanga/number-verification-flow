import ballerina/http;
import ballerina/io;

final http:Client enterpriseBackendClient = check new("localhost:9093");

public function main() returns error? {
    // Initiate request
    NumberVerificationRequest req = {
        phoneNumber: "1234567890"
    };

    NetworkVerification response = check enterpriseBackendClient->/initiate\-request.post(req);
    io:println(response);

    // Get network status
    http:Client supplierBMOClient = check new(response.url);
    NetworkState networkState = check supplierBMOClient->/;
    io:println(networkState);

    // Verify number
    NumberVerificationResponse verificationResponse = check enterpriseBackendClient->/'check\-result.post(req);
    io:println(verificationResponse);
}
