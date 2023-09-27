# Validates the number verification request body. The request body should have either phoneNumber
# or hashedPhoneNumber
# 
# + body - The number verification request body
# + return - An error if the request body is invalid
public isolated function validateNumberVerificationRequest(NumberVerificationRequest body) returns error? {
    if body.hasKey("phoneNumber") && body.hasKey("hashedPhoneNumber") {
        return error("Request body should have either phoneNumber or hashedPhoneNumber");
    }

    if !body.hasKey("phoneNumber") && !body.hasKey("hashedPhoneNumber") {
        return error("Request body should have phoneNumber or hashedPhoneNumber");
    }
}

# Transforms the network verification response to the network verification result
# 
# + networkVerification - The network verification response
# + return - The network verification result
function transform(NetworkVerification networkVerification) returns NetworkVerificationBody => {
    url: networkVerification.url,
    sessionId: networkVerification.sessionId ?: networkVerification.token
};
