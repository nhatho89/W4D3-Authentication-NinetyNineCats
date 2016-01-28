
class User < ActiveRecord::Base

  validates :username, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  # validate :custom_validator

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def password
    @password
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credential(username,password)
    found_user = User.find_by( username: username)
    return nil unless found_user
    if found_user.is_password?(password)
      found_user
    else
      nil
    end
  end

end

u = User.new(username: "bob", password: "pw")
