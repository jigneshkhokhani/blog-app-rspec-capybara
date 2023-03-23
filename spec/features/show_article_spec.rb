require 'rails_helper'

RSpec.feature 'Showing an article' do
  let(:user1) { User.create(email: 'user1@example.com', password: 'password') }
  let(:user2) { User.create(email: 'user2@example.com', password: 'password') }

  let!(:article) { Article.create(title: 'The first article', body: '1st lLorem ipsum dolor sit amet, consectetur adip', user: user1) }

  scenario 'to non-signed in user hide the Edit and Delete buttons' do
    visit '/'

    click_link article.title

    expect(page).to have_content(article.title)
    expect(page).to have_content(article.body)

    expect(current_path).to eq(article_path(article))

    expect(page).not_to have_link('Edit Article')
    expect(page).not_to have_link('Delete Article')
  end

  scenario 'to non-owner hide the Edit and Delete buttons' do
    login_as(user2)
    visit '/'

    click_link article.title

    expect(page).to have_content(article.title)
    expect(page).to have_content(article.body)

    expect(current_path).to eq(article_path(article))

    expect(page).not_to have_link('Edit Article')
    expect(page).not_to have_link('Delete Article')
  end

  scenario 'to signed in owner sees the Edit and Delete buttons' do
    login_as(user1)
    visit '/'

    click_link article.title

    expect(page).to have_content(article.title)
    expect(page).to have_content(article.body)

    expect(current_path).to eq(article_path(article))

    expect(page).to have_link('Edit Article')
    expect(page).to have_link('Delete Article')
  end
end