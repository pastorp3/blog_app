require 'rails_helper'

RSpec.feature "PostsIndex", type: :feature do
  let(:user) { create(:user) }
  let!(:user_post) { create(:post, user: user, title: "User's Post", content: "This is a post by the user.") }
  let!(:another_post) { create(:post, title: "Another Post", content: "This is another post.") }

  scenario "User views the posts index page" do
    visit posts_path

    expect(page).to have_content("User's Post")
    expect(page).to have_content("This is a post by the user.")
    expect(page).to have_content("Another Post")
    expect(page).to have_content("This is another post.")
  end

  scenario "Signed-in user sees the 'New Post' button" do
    sign_in_user(user)
    visit posts_path

    expect(page).to have_link("New Post", href: new_post_path)
  end

  scenario "Non-signed-in user does not see the 'New Post' button" do
    visit posts_path

    expect(page).not_to have_link("New Post", href: new_post_path)
  end

  scenario "User sees pagination controls when there are many posts" do
    create_list(:post, 15)

    visit posts_path

    expect(page).to have_selector(".pagination")
  end

  def sign_in_user(user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end
end
