module Web::Controllers::Users
  class Edit
    include Web::Action

    expose :user, :form_errors

    def call(_params)
      return redirect_to routes.users_path unless valid?
      @user = user
    end

    private

    def valid?
      IdValidator.new(params).validate.success? &&
        user
    end

    def user
      @user ||= UserRepository.new.find(params[:id])
    end
  end
end
