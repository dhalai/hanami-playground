module Web::Views::Users
  class Update
    include Web::View
    include Web::Views::Users::Concerns::Common
    include Web::Views::Users::Concerns::Edit

    template 'users/edit'
  end
end
