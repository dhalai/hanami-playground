module Web::Views::Users
  module Concerns
    module Common
      include Hanami::Helpers

      def form_errors
        errors[:user].each_with_object([]) do |(field, msg), acc|
          acc << "#{field.capitalize} #{msg.join(', ')}"
        end
      end
    end
  end
end
