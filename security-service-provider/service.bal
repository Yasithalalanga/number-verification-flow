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

    isolated resource function post initRequest(NumberVerificationRequest payload)
            returns NetworkVerification|error {

        NetworkVerification|error response = bridgeRegionalPlatformClient->/initRequest.post(payload);
        return response;
    }

    isolated resource function post verify(NumberVerificationRequest payload, @http:Header {name: "x-correlator"} string? correlator)
            returns NumberVerification|error {

        map<string|string[]> headers = {};
        if correlator is string {
            headers["x-correlator"] = [correlator];
        }
        NumberVerification|error response = bridgeRegionalPlatformClient->/verify.post(payload, headers);
        return response;
    }
}
