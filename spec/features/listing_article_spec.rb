require 'rails_helper'

RSpec.feature 'Listing Articles' do
  # 1st way to run before scenario
  # before do
  #   @article1 = Article.create(title: 'The first article', body: '1st lLorem ipsum dolor sit amet, consectetur adip')
  #   @article2 = Article.create(title: 'The second article', body: '2nd lLorem ipsum dolor sit amet, consectetur adip')
  # end

  # 2nd way to run before scenario
  let(:article1) { Article.create(title: 'The first article', body: '1st lLorem ipsum dolor sit amet, consectetur adip') }
  let(:article2) { Article.create(title: 'The second article', body: '2nd lLorem ipsum dolor sit amet, consectetur adip') }

  scenario 'A user lists all articles' do
    # Call to create article in test DB because `let` is lazy loaded
    article1
    article2

    visit '/'

    # If use before..do block
    # expect(page).to have_content(@article1.title)
    # expect(page).to have_content(@article1.body)
    # expect(page).to have_content(@article2.title)
    # expect(page).to have_content(@article2.body)

    # expect(page).to have_link(@article1.title)
    # expect(page).to have_link(@article2.title)

    expect(page).to have_content(article1.title)
    expect(page).to have_content(article1.body)
    expect(page).to have_content(article2.title)
    expect(page).to have_content(article2.body)

    expect(page).to have_link(article1.title)
    expect(page).to have_link(article2.title)
  end

  scenario 'A user has no articles' do
    visit '/'

    expect(page).not_to have_content(article1.title)
    expect(page).not_to have_content(article1.body)
    expect(page).not_to have_content(article2.title)
    expect(page).not_to have_content(article2.body)

    expect(page).not_to have_link(article1.title)
    expect(page).not_to have_link(article2.title)

    within('h1#no-articles') do
      expect(page).to have_content('No Articles Created')
    end
  end
end