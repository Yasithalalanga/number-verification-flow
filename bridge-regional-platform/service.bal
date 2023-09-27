import ballerina/http;

configurable string supplierBMOServiceURL = ?;
configurable string tokenUrl = ?;
configurable string clientId = ?;
configurable string clientSecret = ?;

final http:Client supplierBMOClient = check new (supplierBMOServiceURL,
    auth = {
        tokenUrl: tokenUrl,
        clientId: clientId,
        clientSecret: clientSecret
    }
);

service /number\-verification/v0 on new http:Listener(9091) {

    isolated resource function post initRequest(NumberVerificationRequest payload) returns NetworkVerificationResponse|InternalServerError {
        do {
            NetworkVerification response = check supplierBMOClient->/verify.post(payload);
            return {
                body: response
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

    isolated resource function post verify(@http:Header {name: "x-correlator"} string? correlator, NumberVerificationRequest payload) returns
            OkNumberVerification|BadRequest|InternalServerError {

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
        do {
            NumberVerification response = check supplierBMOClient->/verifyNumber.post(payload);
            return {
                body: response
            };
        } on fail error err {
            return <InternalServerError>{
                body: {
                    status: http:STATUS_INTERNAL_SERVER_ERROR,
                    code: "NUMBER_VERIFICATION.INTERNAL_SERVER_ERROR",
                    message: err.message()
                }
            };
        }
    }

}
