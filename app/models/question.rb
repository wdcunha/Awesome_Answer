class Question < ApplicationRecord
  # We can define validations here that'll be checked before a model is saved
  # to the database. If any of the rules fail, ActiveRecord will prevent saving
  # it by doing a rollback and will also add error message to the model instance.
  # You can access these error message with the `error` method. You can
  # nicer print out of those message by using `error.full_messages`.
  # For example:
  # q = Question.new
  # q.save
  # q.errors.full_messages

  # You can also check if a model instance is valid without trying to save to the
  # database by using the method `valid?`
  validates(
    :title,
    presence: {message: "must be given"},
    uniqueness: true
  )


  validates :body, presence: true, length: {minimum: 5, maximum: 2000}
  validates :view_count, numericality: {greater_than_or_equal_to: 0}

  # When writing your custom validation method instead use the `validate` method.
    # Note that it is not plural. Its first argument is a symbol that is the name
    # of a method inside of your model (whatever name you want).
    # This method will be run during the validation phase and if it adds
    # any error to the model instance it will fail the validation.
    validate :no_monkey

    private
    def no_monkey
      if title.present? && title.downcase.include?('monkey')
        errors.add(:title, "should not have a monkey! ð")
      end

      if body.present? && body.downcase.include?('monkey')
        errors.add(:body, "should not have a monkey! ð")
      end
    end
  end






  # bump
