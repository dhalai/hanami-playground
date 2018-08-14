module Web::Controllers::Users
  class Update
    include Web::Action

    expose :user, :errors

    def call(_params)
      return redirect_to routes.users_path unless valid?
      update_user
    end

    private

    def valid?
      IdValidator.new(params).validate.success? &&
        user
    end

    def user
      @user ||= repository.find(params[:id])
    end

    def repository
      @repository ||= UserRepository.new
    end

    def update_user
      if validation_result.success?
        repository.update(params[:id], params[:user])
        redirect_to routes.users_path
      else
        @errors = validation_result.messages
        self.status = 422
      end
    end

    def validation_result
      @validation_result ||= validator.validate
    end

    def validator
      CreateUserValidator.new(params)
    end
  end
end
