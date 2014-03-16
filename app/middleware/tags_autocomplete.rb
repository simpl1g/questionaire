class TagsAutocomplete
  def initialize(app)
    @app = app
  end

  def call(env)
    if env['REQUEST_PATH'] == '/tags_autocomplete'
      request = Rack::Request.new(env)
      term = request.params['term']
      tags = ActsAsTaggableOn::Tag.where("tags.name LIKE ?", "#{term}_%").limit(10).pluck(:name)
      ActiveRecord::Base.clear_active_connections!
      [200, {'Content-Type' => 'application/json'}, [tags.to_json]]
    else
      @app.call(env)
    end
  end

end