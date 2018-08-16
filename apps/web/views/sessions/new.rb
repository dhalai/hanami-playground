module Web::Views::Sessions
  class New
    include Web::View
    include Web::Views::Sessions::Concerns::Create
  end
end
