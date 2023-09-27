import ballerina/http;

service / on new http:Listener(9090) {

    resource function post verify(NumberVerificationRequest payload) returns NetworkVerification {
        return {
            url: "/verifications/123",
            sessionId: "abc123"
        };
    }

    resource function get verifications/[string id](@http:Header {name: "x-operator"} string? operator) returns NetworkState {
        return {
            state: "verified",
            code: "1234",
            msisdn: "94777123456"
        };
    }

    resource function post verifyNumber(NumberVerificationRequest payload) returns NumberVerification {
        return {
            devicePhoneNumberVerified: true
        };
    }
}

