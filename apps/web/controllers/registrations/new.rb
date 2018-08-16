module Web::Controllers::Registrations
  class New
    include Web::Action

    expose :form_errors

    def call(_params)
      redirect_to routes.root_path if current_user
    end
  end
end
