import ballerina/http;

listener http:Listener securityServiceProvideEP = new (9092);

final http:Client bridgeRegionalPlatformClient = check new ("localhost:9091/number-verification/v0");

service / on securityServiceProvideEP {

    isolated resource function post init\-request(NumberVerificationRequest payload)
            returns NetworkVerification|error {

        NetworkVerification|error response = bridgeRegionalPlatformClient->/init\-request.post(payload);
        return response;
    }

    isolated resource function post verify(NumberVerificationRequest payload, @http:Header string? x\-correlator)
            returns NumberVerificationResponse|error {

        map<string|string[]> headers = {};
        if x\-correlator is string {
            headers["x-correlator"] = [x\-correlator];
        }
        NumberVerificationResponse|error response = bridgeRegionalPlatformClient->/verify.post(payload, headers);
        return response;
    }
}
