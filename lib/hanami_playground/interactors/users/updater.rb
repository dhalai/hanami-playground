require 'hanami/interactor'

module Users
  class Updater
    include Hanami::Interactor

    expose :user

    def initialize(repository: UserRepository.new, password_encryptor: Users::PasswordEncryptor.new)
      @repository = repository
      @password_encryptor = password_encryptor
    end

    def call(params)
      @user = @repository.update(
        params[:id],
        params[:user].merge(
          password: generate_password(
            params[:user][:password]
          )
        )
      )
    end

    private

    def generate_password(str)
      @password_encryptor.call(str).password
    end
  end
end
