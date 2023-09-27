import ballerina/http;

# The URL of the supplier BMO service
configurable string supplierBMOServiceURL = ?;
# The URL of the oauth2 token endpoint of the supplier BMO service
configurable string tokenUrl = ?;
# The oauth2 client id of the supplier BMO service
configurable string clientId = ?;
# The oauth2 client secret of the supplier BMO service
configurable string clientSecret = ?;

# The client to connect to the supplier BMO service
@display {
    label: "supplier BMO service",
    id: "supplier-bmo-service-000"
}
final http:Client supplierBMOClient = check new (supplierBMOServiceURL,
    auth = {
        tokenUrl: tokenUrl,
        clientId: clientId,
        clientSecret: clientSecret
    }
);

# Bridge Regional Platform Service
@display {
    label: "bridge regional platform",
    id: "bridge-regional-platform-000"
}
service /number\-verification/v0 on new http:Listener(9091) {

    # Handles the phone number initiation request
    # 
    # + payload - number verification request with phone number
    # + return - network verification with verification url and optional sessionId and Internal 
    # Server Error when the verification request fails
    resource function post initRequest(NumberVerificationRequest payload) returns NetworkVerificationResponse|InternalServerError {

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

    # Verifies the phone number
    # 
    # + payload - number verification request with phone number
    # + correlator - optional correlator header
    # + return - number verification with verification status. If the verification request is incompatible,
    # then a Bad Request is returned. If the verification request fails, then an Internal Server Error is returned
    resource function post verify(@http:Header {name: "x-correlator"} string? correlator, NumberVerificationRequest payload) returns
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
