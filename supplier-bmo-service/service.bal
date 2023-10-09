import ballerina/log;
import ballerina/http;

# Supplier BMO Service for Number Verification
@display {
    label: "supplier BMO service",
    id: "supplier-bmo-service-000"
}
service / on new http:Listener(9090) {

    # Returns the network verification url for the given number
    # 
    # + payload - number verification request with phone number
    # + return - network verification with verification url and optional sessionId/token
    resource function post verify(NumberVerificationRequest payload) returns NetworkVerification {
        log:printInfo("received number verification request", payload = payload);
        return {
            url: "/verifications/123",
            sessionId: "abc123"
        };
    }

    # Returns the network verification state of the given number
    # 
    # + id - verification id unique to the phone number
    # + operator - optional network operator name
    # + return - network verification state with verification status, code and msisdn
    resource function get verifications/[string id](@http:Header {name: "x-operator"} string? operator) returns NetworkState {
        log:printInfo("received network verification state request", id = id, operator = operator);
        return {
            state: "verified",
            code: "1234",
            msisdn: "94777123456"
        };
    }

    # Returns the device verification state of the given number
    # 
    # + payload - number verification request with phone number
    # + return - device verification state with verification status
    resource function post verifyNumber(NumberVerificationRequest payload) returns NumberVerification {
        log:printInfo("received device verification request", payload = payload);
        return {
            devicePhoneNumberVerified: true
        };
    }
}

