module Web::Views::Sessions
  module Concerns
    module Create
      include Hanami::Helpers

      def form
        Form.new(:session, routes.sessions_path)
      end
    end
  end
end
