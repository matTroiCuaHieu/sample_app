class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.user.email_regex

  validates :name, presence: true,
    length: Settings.user.username_max

  validates :email, presence: true,
    length: Settings.user.email_max,
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: true

  validates :password, presence: true,
    length: {minimum: Settings.user.password_min}

  has_secure_password

  before_save :email_downcase

  private

  def email_downcase
    self.email = email.downcase
  end
end
