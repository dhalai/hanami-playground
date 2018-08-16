module Web::Views::Users
  class Create
    include Web::View
    include Web::Views::Concerns::Common
    include Web::Views::Users::Concerns::Create

    template 'users/new'
  end
end
