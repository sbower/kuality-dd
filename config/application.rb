require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module KualityDd
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib/jobs)
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
  end
end
