module ApplicationHelper
  def beautify_date(date)
    date.strftime("%Y-%m-%d %T")
  end
  def pagination(current_page, total_count, options = nil, &block)
    options ||= {}
    page_size = options.key?(:page_size) ? options[:page_size] : Kuli::Application::PAGE_SIZE
    max_shown_pages = options.key?(:max_shown_pages) ? options[:max_shown_pages] : Kuli::Application::MAX_SHOWN_PAGES

    pages_count = total_count / page_size
    pages_count += 1 if total_count % page_size != 0

    half = max_shown_pages / 2
    current_page += 1
    start_pos = current_page - half + 1
    start_pos = 1 if start_pos < 1

    end_pos = start_pos + max_shown_pages - 1
    end_pos = pages_count if end_pos > pages_count

    html = StringIO.new
    html << '<nav class="container-pagination"><ul class="pagination">'
    for i in start_pos..end_pos
      if i == current_page
        html << '<li class="active">'
      else
        html << '<li>'
      end
      href = yield i - 1
      html << "<a href=\"#{href}\">#{i}</a>"
      html << '</li>'
    end
    html << '</ul></nav>'

    html.string.html_safe
  end
end
