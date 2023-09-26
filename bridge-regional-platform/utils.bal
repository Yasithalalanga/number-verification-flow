public isolated function validateNumberVerificationRequest(NumberVerificationRequest body) returns error? {
    if body.hasKey("phoneNumber") && body.hasKey("hashedPhoneNumber") {
        return error("Request body should have either phoneNumber or hashedPhoneNumber");
    }

    if !body.hasKey("phoneNumber") && !body.hasKey("hashedPhoneNumber") {
        return error("Request body should have phoneNumber or hashedPhoneNumber");
    }
}
