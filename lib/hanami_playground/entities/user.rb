class User < Hanami::Entity
  def admin?
    role == "admin"
  end
end
