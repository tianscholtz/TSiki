module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  # Method to convert markdown text to HTML using Redcarpet
  def render_markdown(text)
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(:no_links => true, :hard_wrap => true), :autolink => true, :space_after_hearders => true)
      markdown.render(text).html_safe
  end

  

end
