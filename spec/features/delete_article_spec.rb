require 'rails_helper'

RSpec.feature 'Deleting an article' do
  let!(:article) { Article.create(title: 'Title one', body: 'Body of article one') }

  scenario 'User deletes an article' do
    visit '/'

    click_link article.title
    click_link 'Delete Article'

    expect(page).to have_content('Article has been deleted')
    expect(current_path).to eq(root_path)
  end
end