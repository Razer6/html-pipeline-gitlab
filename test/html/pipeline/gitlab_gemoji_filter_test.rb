require 'test_helper'
require 'html/pipeline/gitlab/gitlab_emoji_filter'

class HTML::Pipeline::GitLabEmojiFilterTest < Minitest::Test
  GitLabEmojiFilter = HTML::Pipeline::GitLabEmojiFilter
  
  def test_emojify
    filter = GitLabEmojiFilter.new("<p>:heart:</p>", {:asset_root => 'https://foo.com'})
    doc = filter.call
    assert_match "https://foo.com/emoji/heart.png", doc.search('img').attr('src').value
  end

  def test_unsupported_emoji
    block = "<p>:sheep:</p>"
    filter = GitLabEmojiFilter.new(block, {:asset_root => 'https://foo.com'})
    doc = filter.call
    assert_match block, doc.to_html
  end
  
  def test_uri_encoding
    filter = GitLabEmojiFilter.new("<p>:+1:</p>", {:asset_root => 'https://foo.com'})
    doc = filter.call
    assert_match "https://foo.com/emoji/%2B1.png", doc.search('img').attr('src').value
  end
  
  def test_required_context_validation
    exception = assert_raises(ArgumentError) { 
      GitLabEmojiFilter.call("", {}) 
    }
    assert_match /:asset_root/, exception.message
  end

  def test_custom_asset_path
    filter = GitLabEmojiFilter.new("<p>:+1:</p>", {:asset_path => ':file_name', :asset_root => 'https://foo.com'})
    doc = filter.call
    assert_match "https://foo.com/%2B1.png", doc.search('img').attr('src').value
  end
end
