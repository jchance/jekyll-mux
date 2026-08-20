# frozen_string_literal: true

require "test_helper"

class MuxTagTest < Minitest::Test
  PLAYBACK_ID = "61zK4LlhV9P00tpGpsH7Fc00T58eR7m63b"

  def render(markup)
    template = Liquid::Template.parse("{% mux #{markup} %}")
    template.render!
  end

  def test_basic_embed
    output = render(PLAYBACK_ID)
    assert_includes output, "https://player.mux.com/#{PLAYBACK_ID}"
    refute_includes output, "?"
  end

  def test_wrapper_class
    output = render(PLAYBACK_ID)
    assert_includes output, 'class="mux-embed"'
  end

  def test_responsive_styles
    output = render(PLAYBACK_ID)
    assert_includes output, "padding-bottom:56.25%"
    assert_includes output, "position:absolute"
    assert_includes output, "width:100%"
    assert_includes output, "height:100%"
  end

  def test_iframe_attributes
    output = render(PLAYBACK_ID)
    assert_includes output, "allowfullscreen"
    assert_includes output, "loading=\"lazy\""
    assert_includes output, "picture-in-picture"
  end

  def test_accent_color_param
    output = render("#{PLAYBACK_ID} accent-color=#ff0000")
    assert_includes output, "accent-color=%23ff0000"
  end

  def test_autoplay_param
    output = render("#{PLAYBACK_ID} autoplay=true")
    assert_includes output, "autoplay=true"
  end

  def test_loop_param
    output = render("#{PLAYBACK_ID} loop=true")
    assert_includes output, "loop=true"
  end

  def test_muted_param
    output = render("#{PLAYBACK_ID} muted=true")
    assert_includes output, "muted=true"
  end

  def test_playsinline_param
    output = render("#{PLAYBACK_ID} playsinline=true")
    assert_includes output, "playsinline=true"
  end

  def test_preload_param
    output = render("#{PLAYBACK_ID} preload=none")
    assert_includes output, "preload=none"
  end

  def test_stream_type_param
    output = render("#{PLAYBACK_ID} stream-type=on-demand")
    assert_includes output, "stream-type=on-demand"
  end

  def test_start_time_param
    output = render("#{PLAYBACK_ID} start-time=30")
    assert_includes output, "start-time=30"
  end

  def test_metadata_video_title_quoted
    output = render("#{PLAYBACK_ID} metadata-video-title=\"My Video\"")
    assert_includes output, "metadata-video-title=My+Video"
  end

  def test_metadata_viewer_user_id
    output = render("#{PLAYBACK_ID} metadata-viewer-user-id=user-007")
    assert_includes output, "metadata-viewer-user-id=user-007"
  end

  def test_multiple_params
    output = render("#{PLAYBACK_ID} autoplay=false loop=false muted=true")
    assert_includes output, "autoplay=false"
    assert_includes output, "loop=false"
    assert_includes output, "muted=true"
  end

  def test_unknown_param_ignored
    output = render("#{PLAYBACK_ID} fake_param=oops")
    refute_includes output, "fake_param"
    assert_includes output, "player.mux.com/#{PLAYBACK_ID}"
  end

  def test_missing_playback_id_raises
    assert_raises(RuntimeError) { render("") }
  end

  def test_embed_url_structure
    output = render(PLAYBACK_ID)
    assert_match %r{https://player\.mux\.com/#{Regexp.escape(PLAYBACK_ID)}}, output
  end
end
