class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_create :set_default_is_active
  has_many :addresses, dependent: :destroy

  def full_name
    self.last_name + "" + self.first_name
  end

  def full_name_kana
    self.last_name_kana + "" + self.first_name_kana
  end

  private

  def set_default_is_active
    self.is_active ||= true
  end
end
