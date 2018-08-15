require 'bcrypt'
require 'hanami/interactor'

module Users
  class PasswordEncryptor
    include Hanami::Interactor

    expose :password

    def call(string)
      @password = BCrypt::Password.create(string)
    end
  end
end
