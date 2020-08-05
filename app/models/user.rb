class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.user.email_regex
  USER_PARAMS = %i(name email password password_confirmation).freeze

  attr_accessor :remember_token

  validates :name, presence: true,
    length: {maximum: Settings.user.username_maximum}
  validates :email, presence: true,
    length: {maximum: Settings.user.email_maximum},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: true
  validates :password, presence: true,
    length: {minimum: Settings.user.password_minimum}

  has_secure_password

  before_save :email_downcase

  class << self
    def User.digest string
      cost =
        if ActiveModel::SecurePassword.min_cost
          BCrypt::Engine::MIN_COST
        else
          BCrypt::Engine.cost
        end
      BCrypt::Password.create string, cost: cost
    end

    def User.new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update remember_digest: User.digest(remember_token)
  end

  def forget
    update remember_digest: nil
  end

  def authenticated? remember_token
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  private

  def email_downcase
    email.downcase!
  end
end
