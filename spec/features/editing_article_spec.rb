require 'rails_helper'

RSpec.feature 'Editign an article' do
  let(:user) { User.create(email: 'user1@example.com', password: 'password') }
  before do
    login_as(user)
  end
  let!(:article) { Article.create(title: 'Title one', body: 'Body of article one', user: user) }

  scenario 'A user update an article' do
    visit '/'

    click_link article.title
    click_link 'Edit Article'

    fill_in 'Title', with: 'Updated title'
    fill_in 'Body', with: 'Updated body of article'

    click_button 'Update Article'

    expect(page).to have_content('Article has been updated')
    expect(page.current_path).to eq(article_path(article))
  end

  scenario 'A user fails to update an article' do
    visit '/'

    click_link article.title
    click_link 'Edit Article'

    fill_in 'Title', with: ''
    fill_in 'Body', with: 'Updated body of article'

    click_button 'Update Article'

    expect(page).to have_content('Article has not been updated')
    expect(page.current_path).to eq(article_path(article))
  end
end