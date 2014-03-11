class ShoesAppWrapper

  def self.url(path, method)
    @@urls ||= []
    @@urls << {:path => path, :method => method}
  end

  def initialize(shoes)
    @shoes  = shoes
    @panels = create_panels
    @panels['/'].show
    @current_panel = @panels['/']
  end

  private

  def create_panels
    panels = {}
    @@urls.each do |url|
      panel = @shoes.stack(:width => @shoes.width, :height => @shoes.height) do
        self.send(url[:method])
      end
      panel.top  = 0
      panel.left = 0
      panels[url[:path]] = panel
      panel.hide
    end
    return panels
  end

  def visit(panel_path)
    @current_panel.hide
    @current_panel = @panels[panel_path]
    @current_panel.show
  end


end
