module Web::Views::Users
  class Index
    include Web::View
    include Hanami::Helpers

    def filter_form
      Form.new(
        :filters,
        routes.users_path,
        Hash[filters: filters],
        Hash[method: :get]
      )
    end

    def delete_link(user)
      form_for form(user) do
        submit 'delete'
      end
    end

    def user_roles
      UserRepository::USER_ROLES
    end

    private

    def form(user)
      Form.new(
        :user,
        routes.user_path(id: user.id),
        Hash[user: user],
        Hash[method: :delete]
      )
    end
  end
end
