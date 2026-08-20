# frozen_string_literal: true

require "cgi"
require "liquid"

module Jekyll
  class MuxTag < Liquid::Tag
    EMBED_BASE = "https://player.mux.com/"

    # Supported query parameters for the Mux iframe embed player.
    # These mirror the Mux Player web component attributes as URL query params.
    VALID_PARAMS = %w[
      accent-color autoplay loop muted playsinline preload
      metadata-video-id metadata-video-title metadata-viewer-user-id
      metadata-player-name metadata-page-type metadata-sub-property-id
      stream-type start-time
    ].freeze

    def initialize(tag_name, markup, tokens)
      super
      parts = markup.strip.split(/\s+/, 2)
      @playback_id = parts[0]
      @params = parse_params(parts[1] || "")
    end

    def render(_context)
      raise "Mux tag requires a playback ID" if @playback_id.nil? || @playback_id.strip.empty?

      src = EMBED_BASE + @playback_id
      unless @params.empty?
        src += "?" + @params.map { |k, v| "#{CGI.escape(k)}=#{CGI.escape(v.to_s)}" }.join("&")
      end

      <<~HTML.strip
        <div class="mux-embed" style="position:relative;padding-bottom:56.25%;height:0;overflow:hidden;">
          <iframe
            src="#{src}"
            frameborder="0"
            allow="accelerometer; gyroscope; autoplay; encrypted-media; picture-in-picture"
            allowfullscreen
            style="position:absolute;top:0;left:0;width:100%;height:100%;"
            loading="lazy">
          </iframe>
        </div>
      HTML
    end

    private

    def parse_params(raw)
      params = {}
      raw.scan(/(\S+?)=(?:"([^"]*?)"|'([^']*?)'|(\S+))/) do |key, dq, sq, bare|
        value = dq || sq || bare
        if VALID_PARAMS.include?(key)
          params[key] = value
        else
          warn "jekyll-mux: Unknown param '#{key}' ignored"
        end
      end
      params
    end
  end
end

Liquid::Template.register_tag("mux", Jekyll::MuxTag)
