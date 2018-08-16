module Web::Controllers::Registrations
  class Create
    include Web::Action

    DEFAULT_ROLE = "user".freeze

    expose :form_errors

    def initialize(interactor: Users::Creator.new)
      @interactor = interactor
    end

    def call(_params)
      if valid?
        session[:user] = new_user
        redirect_to routes.root_path
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
      RegistrationUserValidator.new(params)
    end

    def new_user
      @interactor.call(
        validation_result.output[:user].merge(role: DEFAULT_ROLE)
      ).user
    end
  end
end
