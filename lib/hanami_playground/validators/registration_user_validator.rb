require 'hanami/validations'

class RegistrationUserValidator
  include Hanami::Validations

  EMAIL_FORMAT = URI::MailTo::EMAIL_REGEXP

  predicate :unique_user?, message: "User with this email has already existed" do |current|
    UserRepository.new.find_by_email(current[:email]).nil?
  end

  validations do
    required(:user).schema do
      required(:email) { filled? & str? & format?(EMAIL_FORMAT) }
      required(:password) { filled? & str? & min_size?(8) }
    end

    rule(user: [:user], &:unique_user?)
  end
end
