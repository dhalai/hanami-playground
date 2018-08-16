module Web
  module Authentication
    def self.included(action)
      action.class_eval do
        expose :current_user
      end
    end

    private

    def authenticate!
      return if session_actions?
      redirect_to routes.new_session_path unless authenticated?
    end

    def session_actions?
      self.class.name.include?("Sessions")
    end

    def authenticated?
      current_user
    end

    def current_user
      @current_user ||= session[:user]
    end
  end
end
