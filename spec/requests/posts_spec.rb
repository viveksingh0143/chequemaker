require 'spec_helper'

describe "Posts" do
  it "cannot edit post as non-admin" do
    log_in admin: false
    topic = create(:topic)
    visit edit_topic_path(topic)
    page.should have_content("Not authorized")
  end
end
