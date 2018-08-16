module Web
  module Authentication
    PUBLIC_CONTROLLERS = %w[Sessions Registrations].freeze

    def self.included(action)
      action.class_eval do
        expose :current_user
      end
    end

    private

    def authenticate!
      return if public_actions?
      redirect_to routes.new_session_path unless authenticated?
    end

    def public_actions?
      PUBLIC_CONTROLLERS.find do |controller|
        self.class.name.include?(controller)
      end
    end

    def authenticated?
      current_user
    end

    def current_user
      @current_user ||= session[:user]
    end
  end
end
