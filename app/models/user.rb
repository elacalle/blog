class User < ApplicationRecord
  include ActiveModel::SecurePassword

  validates :email,
            presence: true,
            format: { :with => /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/ },
            length: { maximum: 140 },
            uniqueness: { case_sensitive: true }
  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true
  validates :name, presence: true, length: { maximum: 140 }

  has_many :posts

  has_secure_password

  def valid_password?(raw_password)
    hash = BCrypt::Password.new(password_digest)
    hash.is_password? raw_password
  end
end
