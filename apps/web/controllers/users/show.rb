module Web::Controllers::Users
  class Show
    include Web::Action

    expose :user

    def initialize(repository: UserRepository.new)
      @repository = repository
    end

    def call(_params)
      return redirect_to routes.users_path unless valid?
    end

    private

    def valid?
      IdValidator.new(params).validate.success? &&
        user
    end

    def user
      @user ||= @repository.find(params[:id])
    end
  end
end
