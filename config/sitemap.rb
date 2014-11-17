# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.alec-pinteresting.com"
SitemapGenerator::Sitemap.create_index = true
SitemapGenerator::Sitemap.create do
  # Route enumeration sitemap generation borrowed and modified from http://hackingoff.com/blog/generate-rails-sitemap-from-routes/
  routes = Rails.application.routes.routes.map do |route|
    {:alias => route.name, :path => route.path.spec.to_s, :controller => route.defaults[:controller], :action => route.defaults[:action], :verb => route.verb}
  end

  # Set a list of controllers we want to generate routes for.
  # Basically, the controllers with static content.
  allowed_controllers = %w(application pages)
  routes.reject! { |route| !allowed_controllers.include?(route[:controller])}

  # Helper actions or unreleased pages that shouldn't be indexed.
  #disallowed_actions = %w(fbshare blog_menu goodbye forms)
  #routes.reject! { |route| disallowed_actions.include?(route[:action]) }

  # sitemap_generator includes root by default; prevent duplication
  routes.reject! {|route| route[:path] == '/'}

  # reject any non-GET routes (routes with no verb don't match either)
  routes.reject! {|route| route[:verb] !~ 'GET' }

  routes.each {|route| add route[:path][0..-11]} # Strips off '(.:format)

  # TODO: when/if list of questions gets too large, change this to be generated offline.
  #
  # I would set that up now, but we don't really need it, and I need a
  # change on another branch to make it work.
end
