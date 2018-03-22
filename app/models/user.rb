class User < ApplicationRecord
  has_many :answers, dependent: :nullify
  has_many :questions, dependent: :nullify

  has_many :likes, dependent: :destroy
  has_many :liked_questions, through: :likes, source: :question

  has_many :stars, dependent: :destroy
  has_many :starred_answers, through: :stars, source: :answer

  has_many :votes, dependent: :destroy
  has_many :voted_questions, through: :votes, source: :question


  geocoded_by :address
  after_validation :geocode


  extend FriendlyId
  # friendly_id :slug_candidates, use: [:slugged, :history, :finders]
  friendly_id :full_name, use: [:slugged, :history, :finders]

  # def slug_candidates
  #   [[:first_name, :last_name]]
  # end


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
  # The following validations verifies that emails exists and are unique.
  # As well, it veries using a regular expression that email respects a certain
  # format meaning that the beginning email should have valid characters
  # (e.g. alphabet, +, -, numbers, .), the middle has a `@` and that the end
  # also only contains valid characters.

  # validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX
  validates :email,
    presence: true,
    uniqueness: true,
    format: VALID_EMAIL_REGEX,
    unless: :from_oauth?

  # `validates` can take multiple column names as its first arguments. All
  # validation rules provided will apply all given columns.
  validates :first_name, presence: true
  validates :last_name, presence: true, unless: :from_oauth?
  # validates :first_name, :last_name, presence: true

  # `serialize` takes a column name which will change the behaviour
  # when writing and reading to that column.
  # When writing, the value will first be serialize (or encoded
  # as text in such a way that the data structure can be preserved)
  # When reading, the value will be deserialized allowing to read
  # not as text but as the original data structure that was saved.
  serialize :oauth_raw_data
  before_create :generate_api_key


  def full_name
    "#{first_name} #{last_name}"
  end

  def to_props
    ActiveRecord::Base.include_root_in_json = true
    json = to_json(
      only: [:id, :first_name, :last_name],
      methods: [:full_name]
    )
    ActiveRecord::Base.include_root_in_json = false
    json
  end

  def self.create_from_oauth(oauth_data)
    first_name, last_name =
      oauth_data["info"]["name"]&.split || [oauth_data["info"]["nickname"]]
    first_name, last_name = oauth_data["info"]["name"].split
    # const [firstName, lastName] = [1, 2]

    User.create(
      uid: oauth_data["uid"],
      provider: oauth_data["provider"],
      first_name: first_name,
      last_name: last_name,
      oauth_token: oauth_data["credentials"]["token"],
      oauth_raw_data: oauth_data,
      password: SecureRandom.hex(32)
    )
  end

  def self.find_by_oauth(oauth_data)
    self.find_by(
      provider: oauth_data["provider"],
      uid: oauth_data["uid"]
    )
  end

  def from_oauth?
    uid.present? && provider.present?
  end

  private
  def generate_api_key
    # We may accidently generate an api key that a user already owns.
    # To prevent from saving a duplicate key, we'll loop until
    # we can't find any users with that key.
    loop do
      # SecureRandom.hex(32) will generate a large string of random hex
      # characters (i.e A-F & 0-9)
      # We'll use this as user's api key for authentication with our
      # web api.
      self.api_key = SecureRandom.hex(32)
      break unless User.exists?(api_key: api_key)
    end
  end

end
