module Web::Views::Users
  class New
    include Web::View
    include Web::Views::Users::Concerns::Common
    include Web::Views::Users::Concerns::Create
  end
end
