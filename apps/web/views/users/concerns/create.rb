module Web::Views::Users
  module Concerns
    module Create
      include Hanami::Helpers

      def form
        Form.new(:user, routes.users_path)
      end

      def submit_label
        "Create"
      end
    end
  end
end
