# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :user_name, :password_digest, presence: true
  validates :user_name, :session_token, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}

  attr_reader :password

  has_many :cats
  has_many :cat_rental_requests

  after_initialize do
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def self.find_by_credentials(user_params)
    user_name = user_params[:user_name]
    password = user_params[:password]

    user = User.find_by(user_name: user_name)
    return unless user

    if user.valid_password?(password)
      return user
    end
  end

  def self.current_user(session_token)
    User.find_by(session_token: session_token)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def valid_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

end
