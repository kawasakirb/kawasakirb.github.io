module Jekyll
  class IconTag < Liquid::Tag
    def initialize(tag_name, url, tokens)
      super
      @url = url
    end

    def render(context)
      "<img src=\"#{@url}\" width=480px />"
    end
  end
end

Liquid::Template.register_tag('icon', Jekyll::IconTag)
