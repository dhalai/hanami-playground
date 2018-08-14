require 'hanami/validations'

class CreateUserValidator
  include Hanami::Validations

  EMAIL_FORMAT = URI::MailTo::EMAIL_REGEXP

  validations do
    required(:user).schema do
      required(:email) { filled? & str? & format?(EMAIL_FORMAT) }
      required(:password) { filled? & str? & min_size?(8) }
      required(:role) { filled? & str? & included_in?(%w[User Admin]) }
    end
  end
end
