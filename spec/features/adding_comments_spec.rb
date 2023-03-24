require 'rails_helper'

RSpec.feature 'Adding comments to Articles' do
  let(:user1) { User.create(email: 'user1@example.com', password: 'password') }
  let(:user2) { User.create(email: 'user2@example.com', password: 'password') }

  let!(:article) { Article.create(title: 'The first article', body: '1st lLorem ipsum dolor sit amet, consectetur adip', user: user1) }

  scenario 'permit a signed in user to write a comment' do
    login_as(user1)
    visit '/'

    click_link article.title
    fill_in 'New Comment', with: 'An amazing article.'
    click_button 'Add Comment'

    expect(page).to have_content('Comment has been created')
    expect(page).to have_content('An amazing article.')
    expect(current_path).to eq(article_path(article.id))
  end
end