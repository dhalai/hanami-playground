module Web::Controllers::Users
  class Create
    include Web::Action

    expose :user, :errors

    def call(params)
      if validation_result.success?
        UserRepository.new.create(params[:user])
        redirect_to routes.users_path
      else
        @errors = validation_result.messages
        self.status = 422
      end
    end

    private

    def validation_result
      @validation_result ||= validator.validate
    end

    def validator
      CreateUserValidator.new(params)
    end
  end
end
