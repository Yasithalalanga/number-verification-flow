import ballerina/http;

configurable int port = 9092;
configurable string bridgeRegionalPlatformUrl = "localhost:9091/number-verification/v0";

listener http:Listener securityServiceProvideEP = new (port);

final http:Client bridgeRegionalPlatformClient = check new (bridgeRegionalPlatformUrl);

service / on securityServiceProvideEP {

    isolated resource function post init\-request(NumberVerificationRequest payload)
            returns NetworkVerification|error {

        NetworkVerification|error response = bridgeRegionalPlatformClient->/init\-request.post(payload);
        return response;
    }

    isolated resource function post verify(NumberVerificationRequest payload, @http:Header string? x\-correlator)
            returns NumberVerification|error {

        map<string|string[]> headers = {};
        if x\-correlator is string {
            headers["x-correlator"] = [x\-correlator];
        }
        NumberVerification|error response = bridgeRegionalPlatformClient->/verify.post(payload, headers);
        return response;
    }
}
