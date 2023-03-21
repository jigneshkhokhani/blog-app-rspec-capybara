require 'rails_helper'

RSpec.feature 'Showing an article' do
  let(:article) { Article.create(title: 'The first article', body: '1st lLorem ipsum dolor sit amet, consectetur adip') }

  scenario 'A user shows an article' do
    article

    visit '/'

    click_link article.title

    expect(page).to have_content(article.title)
    expect(page).to have_content(article.body)

    expect(current_path).to eq(article_path(article))
  end
end