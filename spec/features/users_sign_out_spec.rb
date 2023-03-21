require 'rails_helper'

RSpec.feature 'Sign out signed-in users' do
  let(:user) { User.create(email: 'user1@example.com', password: 'password') }

  # Sign in before check sign out test
  before do
    visit '/'
    click_link 'Sign in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  scenario 'Able to sign out successfully' do
    visit '/'

    click_link 'Sign out'
    expect(page).to have_content('Signed out successfully.')
    expect(page).not_to have_link('Sign out')
  end
end