class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_create :set_default_is_active
  has_many :addresses, dependent: :destroy
  has_many :orders

  private

  def set_default_is_active
    self.is_active ||= true
  end
end
