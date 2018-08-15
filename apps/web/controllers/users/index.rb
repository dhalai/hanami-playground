module Web::Controllers::Users
  class Index
    include Web::Action

    expose :paginator

    def initialize(relation: UserRepository.new.users, paginator: Paginator.new)
      @relation = relation
      @paginator = paginator
    end

    def call(params)
      @paginator = @paginator.call(
        relation: @relation,
        params: params
      )
    end
  end
end
