require 'bcrypt'
require 'hanami/interactor'

module Users
  class Creator
    include Hanami::Interactor

    expose :user

    def initialize(repository: UserRepository.new)
      @repository = repository
    end

    def call(params)
      @user = @repository.create(
        params.merge(
          password: generate_password(
            params[:password]
          )
        )
      )
    end

    private

    def generate_password(str)
      BCrypt::Password.create(str)
    end
  end
end
