import ballerina/http;

listener http:Listener supplierBMOServiceEP = new (9090);

service on supplierBMOServiceEP {

    resource function post verify(NumberVerificationRequest payload) returns NetworkVerification {
        return {
            url: "localhost:9090/verifications/123",
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
}

