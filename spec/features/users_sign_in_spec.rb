require 'rails_helper'

RSpec.feature 'Users Signin' do
  let(:user) { User.create(email: 'user1@example.com', password: 'password') }

  scenario 'with valid credentials' do
    visit '/'

    click_link 'Sign in'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content("Signed in as #{user.email}")
    expect(page).not_to have_link('Sign in')
    expect(page).not_to have_link('Sign up')
  end

  # scenario 'with invalid credentials' do
  # end
end