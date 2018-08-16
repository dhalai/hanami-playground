require 'hanami/validations'

class CreateSessionValidator
  include Hanami::Validations

  EMAIL_FORMAT = URI::MailTo::EMAIL_REGEXP

  predicate :valid_user?, message: "Email or password is invalid" do |current|
    user = UserRepository.new.find_by_email(current[:email])
    return unless user

    BCrypt::Password.new(user.password) == current[:password]
  end

  validations do
    required(:session).schema do
      required(:email) { filled? & str? & format?(EMAIL_FORMAT) }
      required(:password) { filled? & str? }
    end

    rule(valid_user: [:session], &:valid_user?)
  end
end
