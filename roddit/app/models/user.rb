# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  session_token   :string           not null
#  password_digest :string           not null
#

class User < ApplicationRecord
    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6, allow_nil: true}

    after_initialize :ensure_session_token
    attr_reader :password

    has_many :subs,
        primary_key: :id,
        foreign_key: :moderator_id,
        class_name: :Sub
    
    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    def is_password?(password)
        pw_digest=BCrypt::Password.new(password_digest)
        pw_digest.is_password?(password)
    end

    def self.find_by_credentials(username,password)
        u = User.find_by(username: username)
        if u && u.is_password?(password)
            u 
        else
            nil
        end
    end

    def self.generate_session_token
        SecureRandom::urlsafe_base64
    end

    def ensure_session_token
        self.session_token ||= self.class.generate_session_token
    end

    def reset_session_token!
        self.session_token = self.class.generate_session_token
        self.save
        self.session_token
    end
end
