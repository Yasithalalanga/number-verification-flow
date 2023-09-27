# Number verification response
public type NumberVerification record {
    # Device verification result
    boolean devicePhoneNumberVerified;
};

# Number verification request
public type NumberVerificationRequest record {
    # Phone number
    string phoneNumber?;
    # Hashed phone number with sha256
    string hashedPhoneNumber?;
};

# Network verification response
public type NetworkVerification record {|
    # Verification URL
    string url;
    # Optional Session ID
    string sessionId?;
|};
