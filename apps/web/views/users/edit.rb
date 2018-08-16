module Web::Views::Users
  class Edit
    include Web::View
    include Web::Views::Concerns::Common
    include Web::Views::Users::Concerns::Edit
  end
end
