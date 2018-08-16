require 'hanami/interactor'

class Filter
  include Hanami::Interactor

  expose :relation

  def call(params)
    repository = params[:repository]
    filters = fetch_filters(params[:filters] || [])
    relation = repository.relations.first.last

    @relation = apply_filters(repository, filters, relation)
  end

  private

  def fetch_filters(filters)
    filters.reject { |_, value| value.length.zero? }
  end

  def apply_filters(repository, filters, relation)
    filters.each do |name, value|
      filter_name = "filter_by_#{name}"
      next unless repository.respond_to?(filter_name)
      relation = repository.send(filter_name, relation, value)
    end

    relation
  end
end
