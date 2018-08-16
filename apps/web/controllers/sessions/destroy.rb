module Web::Controllers::Sessions
  class Destroy
    include Web::Action

    def call(_params)
      session[:user] = nil
      redirect_to routes.new_session_path
    end
  end
end
