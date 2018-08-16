module Web::Views::Users
  class New
    include Web::View
    include Web::Views::Concerns::Common
    include Web::Views::Users::Concerns::Create
  end
end
