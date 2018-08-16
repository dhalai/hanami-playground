module Web::Views::Registrations
  class Create
    include Web::View
    include Web::Views::Concerns::Common
    include Web::Views::Registrations::Concerns::Create

    template 'registrations/new'
  end
end
