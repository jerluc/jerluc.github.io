class HTMLCompressFilter < Nanoc::Filter
  requires 'html_press'

  identifier :html_compress
  type :text

  def run(content, params={})
    HtmlPress.press(content)
  end
end
