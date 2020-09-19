class User < ApplicationRecord
  validates(:email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i })
  validates(:password, presence: true, length: { minimum: 8, maximum: 20 }, confirmation: true,  on: :create)
  validates(:nickname, presence: true, length: { maximum: 10 })
  validates(:family_name, presence: true, length: { maximum: 10 })
  validates(:first_name, presence: true, length: { maximum: 10 })
  validates(:postal_code, presence: true, format: { with: /\d{7}/ })
  validates(:address, presence: true, length: { maximum: 50 })

  include(ActiveModel::Validations)
  validates_with(ImageExtensionValidator)

  has_secure_password
  has_one_attached(:image)

  belongs_to(:prefecture)
end
