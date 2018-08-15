module Web::Controllers::Users
  class New
    include Web::Action

    expose :form_errors

    def call(_params); end
  end
end
