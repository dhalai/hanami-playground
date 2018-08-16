class UserRepository < Hanami::Repository
  USER_ROLES = %w[user admin].freeze

  def filter_by_email(relation, value)
    relation.where { email.ilike("%#{value}%") }
  end

  def filter_by_role(relation, value)
    return relation if USER_ROLES & value.values == USER_ROLES
    relation.where { role.in(value.values) }
  end

  def find_by_email(email)
    users.where(email: email).map_to(User).one
  end
end
