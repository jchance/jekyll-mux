# jekyll-mux

A Jekyll plugin that provides a `{% mux %}` Liquid tag for embedding [Mux](https://mux.com)-hosted videos with a responsive iframe wrapper.

## Installation

Add to your `Gemfile`:

```ruby
gem "jekyll-mux", "~> 0.1"
```

Add to your `_config.yml`:

```yaml
plugins:
  - jekyll-mux
```

Then run:

```
bundle install
```

## Usage

```liquid
{% mux YOUR_PLAYBACK_ID %}
```

With optional parameters:

```liquid
{% mux YOUR_PLAYBACK_ID accent-color=#ff0000 autoplay=false loop=false muted=false %}
```

With metadata for Mux Data analytics:

```liquid
{% mux YOUR_PLAYBACK_ID metadata-video-title="My Video" metadata-viewer-user-id=user-123 %}
```

The tag outputs a responsive 16:9 iframe wrapper:

```html
<div class="mux-embed" style="position:relative;padding-bottom:56.25%;height:0;overflow:hidden;">
  <iframe
    src="https://player.mux.com/YOUR_PLAYBACK_ID"
    frameborder="0"
    allow="accelerometer; gyroscope; autoplay; encrypted-media; picture-in-picture"
    allowfullscreen
    style="position:absolute;top:0;left:0;width:100%;height:100%;"
    loading="lazy">
  </iframe>
</div>
```

## Finding Your Playback ID

Your Mux playback ID is the alphanumeric string in your Mux dashboard video URL or from the Mux API. It's the value that goes after `https://player.mux.com/` in an embed URL.

## Supported Parameters

| Parameter | Values | Description |
|---|---|---|
| `accent-color` | CSS color value | Player accent color (default: Mux pink `#fa50b5`) |
| `autoplay` | `true`, `false` | Autoplay the video on load |
| `loop` | `true`, `false` | Loop playback |
| `muted` | `true`, `false` | Start muted |
| `playsinline` | `true`, `false` | Play inline on mobile (no forced fullscreen) |
| `preload` | `auto`, `metadata`, `none` | Preload behavior |
| `stream-type` | `on-demand`, `live` | Video stream type |
| `start-time` | number (seconds) | Start playback at this time |
| `metadata-video-id` | string | Custom video ID for Mux Data |
| `metadata-video-title` | string | Video title for Mux Data |
| `metadata-viewer-user-id` | string | Viewer ID for Mux Data |
| `metadata-player-name` | string | Player name for Mux Data |
| `metadata-page-type` | string | Page type for Mux Data |
| `metadata-sub-property-id` | string | Sub-property ID for Mux Data |

Parameters with spaces in values should be quoted: `metadata-video-title="My Great Video"`.

## Styling

The plugin outputs an unstyled `.mux-embed` wrapper div. Add bottom margin or other spacing in your site's CSS:

```css
.mux-embed {
  margin-bottom: 2rem;
}
```

## License

MIT — see [LICENSE.txt](LICENSE.txt).
