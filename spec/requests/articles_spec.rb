require 'rails_helper'

RSpec.describe "Articles", type: :request do
  let!(:user1) { User.create(email: 'user1@example.com', password: 'password') }
  let!(:user2) { User.create(email: 'user2@example.com', password: 'password') }
  let!(:article) { Article.create!(title: 'Title one', body: 'Body of article one', user: user1) }

  # describe "GET /index" do
  #   it "returns http success" do
  #     get "/articles/index"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe 'GET /articles/:id/edit' do
    context 'with non-signed in user' do
      before { get "/articles/#{article.id}/edit" }

      it 'redirects to the signin page' do
        expect(response.status).to eq(302)
        flash_message = 'You need to sign in or sign up before continuing.'
        expect(flash[:alert]).to eq(flash_message)
      end
    end

    context 'with signed in user who is non-owner' do
      before do
        login_as(user2)
        get "/articles/#{article.id}/edit"
      end

      it 'redirects to the home page' do
        expect(response.status).to eq(302)
        flash_message = 'You can only edit your own article.'
        expect(flash[:alert]).to eq(flash_message)
      end
    end

    context 'with signed in user as owner successfull edit' do
      before do
        login_as(user1)
        get "/articles/#{article.id}/edit"
      end

      it 'successfully edits article' do
        expect(response.status).to eq(200)
      end
    end
  end

  describe "GET /article/:id" do
    context 'with existing article' do
      before { get "/articles/#{article.id}" }

      it 'handles exisitng article' do
        expect(response.status).to eq 200
      end
    end

    context 'with non-existing article' do
      before { get "/articles/xxxx" }

      it 'handles non-exisitng article' do
        expect(response.status).to eq 302
        flash_message = 'The article you are looking for could not be found'
        expect(flash[:alert]).to eq(flash_message)
      end
    end
  end
end
