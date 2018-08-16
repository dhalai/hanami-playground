module Web
  module Authorization
    private

    def authorize!
      redirect_to routes.root_path if denied?
    end

    def denied?
      self.class.name.include?("Users") &&
        !current_user.admin?
    end
  end
end
