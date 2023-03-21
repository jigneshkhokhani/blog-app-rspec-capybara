require 'rails_helper'

RSpec.feature 'Showing an article' do
  let(:user1) { User.create(email: 'user1@example.com', password: 'password') }
  before do
    login_as(user1)
  end
  let!(:article) { Article.create(title: 'The first article', body: '1st lLorem ipsum dolor sit amet, consectetur adip', user: user1) }

  scenario 'A user shows an article' do
    visit '/'

    click_link article.title

    expect(page).to have_content(article.title)
    expect(page).to have_content(article.body)

    expect(current_path).to eq(article_path(article))
  end
end