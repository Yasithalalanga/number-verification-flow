import ballerina/http;

configurable string bridgeRegionalPlatformUrl = ?;
configurable string tokenUrl = ?;
configurable string clientId = ?;
configurable string clientSecret = ?;

final http:Client bridgeRegionalPlatformClient = check new (bridgeRegionalPlatformUrl,
    auth = {
        tokenUrl: tokenUrl,
        clientId: clientId,
        clientSecret: clientSecret
    }
);

service / on new http:Listener(9092) {

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
