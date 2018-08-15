module Web::Controllers::Users
  class Index
    include Web::Action

    expose :paginator, :filters

    def initialize(repository: UserRepository.new, paginator: Paginator.new, filter: Filter.new)
      @repository = repository
      @paginator = paginator
      @filter = filter
    end

    def call(params)
      @filters = params[:filters]

      @paginator = @paginator.call(
        relation: filtered_relation,
        params: params
      )
    end

    private

    def filtered_relation
      @filter.call(
        repository: @repository, filters: params[:filters]
      ).relation
    end
  end
end
