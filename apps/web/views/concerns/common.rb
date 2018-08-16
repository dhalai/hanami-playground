module Web::Views
  module Concerns
    module Common
      include Hanami::Helpers

      def user_roles
        UserRepository::USER_ROLES
      end

      def errors
        fetch_errors.each_with_object([]) do |(field, msg), acc|
          acc << "#{field.capitalize} #{msg.join(', ')}"
        end
      end

      private

      def fetch_errors
        return remove_error_keys if form_errors.values.first.is_a?(Array)
        form_errors.values.first
      end

      def remove_error_keys
        form_errors.each_with_object({}) do |(_, msg), acc|
          acc[""] = msg
        end
      end
    end
  end
end
