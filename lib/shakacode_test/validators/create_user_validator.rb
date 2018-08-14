require 'hanami/validations'

class CreateUserValidator
  include Hanami::Validations

  validations do
    required(:user).schema do
      required(:email).filled(:str?)
      required(:password).filled(:str?)
      required(:role).filled(:str?)
    end
  end
end
