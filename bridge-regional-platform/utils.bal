public isolated function validateNumberVerificationRequest(NumberVerificationRequest body) returns error? {
    if body.hasKey("phoneNumber") && body.hasKey("hashedPhoneNumber") {
        return error("Request body should have either phoneNumber or hashedPhoneNumber");
    }

    if !body.hasKey("phoneNumber") && !body.hasKey("hashedPhoneNumber") {
        return error("Request body should have phoneNumber or hashedPhoneNumber");
    }
}

function transform(NetworkVerification networkVerification) returns NetworkVerificationBody => {
    url: networkVerification.url,
    sessionId: networkVerification.sessionId ?: networkVerification.token
};
