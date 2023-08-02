require 'rails_helper'
RSpec.describe 'User Index Page', type: :feature do
  before(:each) do
    @user = User.create(
      name: 'Tom Jenkins',
      photo: 'https://www.freepik.com/free-photo/closeup-photo-young-lady-looking-down-hedshot-high-quality-photo_3.htm#from_view=detail_alsolike',
      bio: 'the Narrator ',
      posts_counter: 5
    )
  end
  it 'displays the username of each user' do
    visit users_path
    User.all.limit(10).each do |user| # because of pagination only 100 user aare displayed on a page
      expect(page).to have_content(user.name)
    end
  end
  it 'displays the photos of each user' do
    visit users_path
    User.all.each do |user|
      expect(page.has_xpath?("//img[@src = '#{user.photo}' ]"))
    end
  end
  it 'shows the number of posts of each user' do
    visit users_path
    User.all.each do |user|
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end
  end
  it "is redirected to that user's show page" do
    visit users_path
    first(:link, @user.name).click
    expect(page).to have_current_path(/users\/\d+/)
  end
end

RSpec.describe 'User Index Page', type: :feature do
  it 'displays pagination if there are more users than fit on the view' do
    # Create additional 5 users for pagination
    25.times do |i|
      User.create(
        name: "User #{i + 2}",
        photo: "https://www.example.com/user#{i + 2}.jpg",
        bio: "Bio for User #{i + 2}",
        posts_counter: 5
      )
    end

    visit users_path
    expect(page).to have_selector('.pagination')
  end
end
