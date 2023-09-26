import ballerina/http;

listener http:Listener bridgeReginalPlatformEP = new (9091);

service /number\-verification/v0 on bridgeReginalPlatformEP {

    isolated resource function post init\-request(NumberVerificationRequest payload) returns NetworkVerificationResponse|InternalServerError {
        do {
            http:Client supplierBMOClient = check new ("localhost:9090");
            NetworkVerification networkVerification = check supplierBMOClient->/verify.post(payload);
            return {
                body: networkVerification
            };
        } on fail error err {
            return {
                body: {
                    status: http:STATUS_INTERNAL_SERVER_ERROR,
                    code: "NUMBER_VERIFICATION.INTERNAL_SERVER_ERROR",
                    message: err.message()
                }
            };
        }
    }

    isolated resource function post verify(@http:Header string? x\-correlator, NumberVerificationRequest payload) returns
            OkNumberVerificationMatchResponse|BadRequest|Unauthorized|Forbidden|InternalServerError|ServiceUnavailable|GatewayTimeout {

        do {
            check validateNumberVerificationRequest(payload);
        } on fail error err {
            return <BadRequest>{
                body: {
                    status: http:STATUS_BAD_REQUEST,
                    code: "NUMBER_VERIFICATION.INVALID_REQUEST",
                    message: err.message()
                }
            };
        }
        return {
            body: {
                devicePhoneNumberVerified: true
            }
        };
    }

}
