class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname,         presence: true
  validates :birthday,         presence: true

  validates :password, presence: true, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: "is invalid. Include both letters and numbers" }

  with_options presence: true, format:  { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "is invalid. Input full-width characters" } do
    validates :first_name
    validates :family_name
  end
  
  with_options presence: true, format:  { with: /\A[\p{katakana} ー－&&[^ -~｡-ﾟ]]+\z/, message: "is invalid. Input full-width katakana characters" } do
    validates :read_first
    validates :read_family
  end

end