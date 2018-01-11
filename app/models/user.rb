class User < ApplicationRecord
  has_many :answers, dependent: :nullify
  has_many :questions, dependent: :nullify

  has_many :likes, dependent: :destroy
  has_many :liked_questions, through: :likes, source: :question

  has_many :stars, dependent: :destroy
  has_many :starred_answers, through: :stars, source: :answer
  # `has_secure_password` is a built-in Rails method for models that
  # provides user authentication features:
  # 0. It will add two attribute accessors for `password` and
  #    `password_confirmation`.
  # 1. It will automatically add a presence validator for the password field
  # 2. When given a password, it will hash it with bcrypt and save it in
  #    the `password_digest` column.
  # 3. It will add the instance method `authenticate` which can be used to
  #    to verify a user's password. If the correct password is entered,
  #    it will return the authenticated user otherwise it will return `false`.
  has_secure_password

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  # validate the email field as format and if it's filled
  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX

  # `validates` can take multiple column names as its first arguments. All
  # validation rules provided will apply all given columns.
  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}" #put self if wants do write, not for reading
  end
end
