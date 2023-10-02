import ballerina/log;
import ballerina/http;

# The URL of the Bridge Regional Platform
configurable string bridgeRegionalPlatformUrl = ?;
# The URL of the oauth2 token endpoint of the Bridge Regional Platform
configurable string tokenUrl = ?;
# The oauth2 client id of the Bridge Regional Platform
configurable string clientId = ?;
# The oauth2 client secret of the Bridge Regional Platform
configurable string clientSecret = ?;

# The client to connect to the Bridge Regional Platform
@display {
    label: "bridge regional platform",
    id: "bridge-regional-platform-000"
}
final http:Client bridgeRegionalPlatformClient = check new (bridgeRegionalPlatformUrl,
    auth = {
        tokenUrl: tokenUrl,
        clientId: clientId,
        clientSecret: clientSecret
    }
);

# Security Service Provider Service
@display {
    label: "security service provider",
    id: "security-service-provider-000"
}
service / on new http:Listener(9092) {

    # Handles the phone number initiation request
    #
    # + payload - number verification request with phone number
    # + return - network verification with verification url and optional sessionId
    resource function post initRequest(NumberVerificationRequest payload)
            returns NetworkVerification|error {
        log:printInfo("received initiation request", payload = payload);
        NetworkVerification|error response = bridgeRegionalPlatformClient->/initRequest.post(payload);
        return response;
    }

    # Verifies the phone number
    #
    # + payload - number verification request with phone number
    # + correlator - optional correlator header
    # + return - number verification with verification status
    resource function post verify(NumberVerificationRequest payload, @http:Header {name: "x-correlator"} string? correlator)
            returns NumberVerification|error {
        log:printInfo("received verification request", payload = payload, correlator = correlator);
        map<string|string[]> headers = {};
        if correlator is string {
            headers["x-correlator"] = [correlator];
        }
        NumberVerification|error response = bridgeRegionalPlatformClient->/verify.post(payload, headers);
        return response;
    }
}
