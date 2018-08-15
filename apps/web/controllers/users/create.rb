module Web::Controllers::Users
  class Create
    include Web::Action

    expose :user, :form_errors

    def initialize(interactor: Users::Creator.new)
      @interactor = interactor
    end

    def call(_params)
      if valid?
        @interactor.call(params[:user])
        redirect_to routes.users_path
      else
        @form_errors = validation_result.messages
        self.status = 422
      end
    end

    private

    def valid?
      validation_result.success?
    end

    def validation_result
      @validation_result ||= validator.validate
    end

    def validator
      CreateUserValidator.new(params)
    end
  end
end
