import ballerina/http;

configurable int port = 9090;
configurable string hostName = "localhost";

listener http:Listener supplierBMOServiceEP = new (port, host = hostName);

service on supplierBMOServiceEP {

    resource function post verify(NumberVerificationRequest payload) returns NetworkVerification {
        return {
            url: string `${supplierBMOServiceEP.getConfig().host}:${supplierBMOServiceEP.getPort()}/verifications/123`,
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

