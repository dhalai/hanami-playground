module Web::Views::Users
  module Concerns
    module Edit
      include Hanami::Helpers

      def form
        Form.new(
          :user,
          routes.user_path(id: user.id),
          Hash[user: user],
          Hash[method: :patch]
        )
      end

      def submit_label
        "Update"
      end
    end
  end
end
