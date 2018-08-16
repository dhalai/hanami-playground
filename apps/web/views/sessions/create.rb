module Web::Views::Sessions
  class Create
    include Web::View
    include Web::Views::Concerns::Common
    include Web::Views::Sessions::Concerns::Create

    template 'sessions/new'
  end
end
