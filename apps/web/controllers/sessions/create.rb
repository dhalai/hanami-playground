module Web::Controllers::Sessions
  class Create
    include Web::Action

    expose :form_errors

    def call(_params)
      if valid?
        session[:user] = user
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
      CreateSessionValidator.new(params)
    end

    def user
      UserRepository.new.find_by_email(
        validation_result.output[:session][:email]
      )
    end
  end
end
