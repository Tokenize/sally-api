class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  before_save :ensure_authentication_token

  has_many :trips

  validates :first_name, :last_name, presence: true
  validates_associated :trips

  def self.find_for_authentication_token(conditions)
    user = User.where(authentication_token: conditions[:auth_token]).first
    user
  end
end
