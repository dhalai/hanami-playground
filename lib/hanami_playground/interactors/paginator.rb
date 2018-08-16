require 'hanami/interactor'

class Paginator
  include Hanami::Interactor

  expose :result, :pagination

  def initialize(limit: 10)
    @limit = limit
  end

  def call(params)
    relation = params[:relation]
    @template_data = {
      count_pages: fetch_count(relation),
      request_path: params[:params].env["REQUEST_PATH"]
    }

    @result = paginate(relation, params[:params])
    @pagination = pagination
  end

  private

  def fetch_count(relation)
    (relation.count.to_f / @limit).ceil
  end

  def paginate(relation, params)
    page = params[:page].to_i <= 0 ? 1 : params[:page].to_i
    offset = (page - 1) * @limit
    relation.limit(@limit).offset(offset).to_a
  end

  def pagination
    Web::Views::Paginator.new(template, @template_data).render
  end

  def template
    Hanami::View::Template.new(template_path)
  end

  def template_path
    Hanami::View.configuration.root.join("apps/web/templates/paginator.html.erb")
  end
end
