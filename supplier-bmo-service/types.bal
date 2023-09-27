# Number verification request
public type NumberVerificationRequest record {
    # Phone number
    string phoneNumber?;
    # Hashed phone number with sha256
    string hashedPhoneNumber?;
};

# Number verification response
type NetworkVerification record {|
    # Verification URL
    string url;
    # Optional Session ID
    string sessionId?;
    # Optional token
    string token?;
|};

# Network verification state
type NetworkState record {|
    # Verification state
    string state;
    # Verification code
    string code;
    # MSISDN
    string msisdn;
|};

# Number verification status
public type NumberVerification record {
    # Device verification status
    boolean devicePhoneNumberVerified;
};
