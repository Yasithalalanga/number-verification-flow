import ballerina/http;

service / on new http:Listener(9090) {

    resource function post verify(NumberVerificationRequest payload) returns NetworkVerification {
        return {
            url: "/verifications/123",
            sessionId: "abc123"
        };
    }

    resource function get verifications/[string id](@http:Header string? x\-operator) returns NetworkState {
        return {
            state: "verified",
            code: "1234",
            msisdn: "94777123456"
        };
    }

    resource function post verify\-number(NumberVerificationRequest payload) returns NumberVerification {
        return {
            devicePhoneNumberVerified: true
        };
    }
}

