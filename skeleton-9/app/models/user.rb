class User < ApplicationRecord
    validates :username, session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true 
    validates :password, length: {allow_nill: true}
    after_initialize: ensure_session_token

    def self.find_by_credential(username, password)
        user = User.find_by(username: username)
        if user && user.password_is?(password)
            user 
        else 
            nil
        end
    end

    attr_reader :password

    def reset_session_token!
        session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    def password_is?(password)
        password_obj = BCrypt::Password.new(password_digest)
        password_obj.is_password?(password)
    end

end
