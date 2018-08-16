module Web::Views::Registrations
  class New
    include Web::View
    include Web::Views::Registrations::Concerns::Create
  end
end
