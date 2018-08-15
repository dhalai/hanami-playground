module Web::Views
  class Paginator
    include Web::View

    def page_link(page)
      link_to (page + 1), "#{request_path}?page=#{page + 1}"
    end
  end
end
