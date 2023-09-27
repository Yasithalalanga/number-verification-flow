import ballerina/http;
import ballerina/io;

final http:Client enterpriseBackendClient = check new ("localhost:9093");
final http:Client supplierBMOClient = check new ("localhost:9090");

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
