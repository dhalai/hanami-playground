module Web::Views::Registrations
  module Concerns
    module Create
      include Hanami::Helpers

      def form
        Form.new(:user, routes.registrations_path)
      end
    end
  end
end
