module Web::Controllers::Users
  class Destroy
    include Web::Action

    def initialize(repository: UserRepository.new)
      @repository = repository
    end

    def call(params)
      @repository.delete(params[:id]) if valid?
      redirect_to routes.users_path
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
