class User < ApplicationRecord
  has_one :company, dependent: :destroy
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  before_create :generate_auth_token!
  validates :email, :presence => true, :uniqueness => true
  
  def generate_auth_token!
    self.auth_token = Devise.friendly_token
  end
end
