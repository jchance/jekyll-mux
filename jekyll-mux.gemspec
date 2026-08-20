# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "jekyll-mux"
  spec.version       = "0.1.0"
  spec.authors       = ["Jason Chance"]
  spec.email         = ["jason@jasonchance.com"]

  spec.summary       = "A Jekyll plugin that provides a {% mux %} Liquid tag for embedding Mux-hosted videos."
  spec.description   = "jekyll-mux provides a simple {% mux PLAYBACK_ID %} Liquid tag for embedding Mux-hosted videos with a responsive iframe wrapper and support for Mux Player embed parameters."
  spec.homepage      = "https://jasonchance.com/projects/jekyll-mux/"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 3.0"

  spec.metadata = {
    "homepage_uri"    => "https://jasonchance.com/projects/jekyll-mux/",
    "source_code_uri" => "https://github.com/jchance/jekyll-mux",
    "bug_tracker_uri" => "https://github.com/jchance/jekyll-mux/issues",
    "changelog_uri"   => "https://github.com/jchance/jekyll-mux/blob/main/CHANGELOG.md"
  }

  spec.files         = Dir["lib/**/*", "LICENSE.txt", "README.md", "CHANGELOG.md"]
  spec.require_paths = ["lib"]

  spec.add_dependency "jekyll", "~> 4.0"
end
