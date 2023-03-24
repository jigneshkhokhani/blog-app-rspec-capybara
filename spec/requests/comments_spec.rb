require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user1) { User.create(email: 'user1@example.com', password: 'password') }
  let(:user2) { User.create(email: 'user2@example.com', password: 'password') }
  let(:article) { Article.create!(title: 'Title one', body: 'Body of article one', user: user1) }

  describe "POST /articles/:id/comments" do
    context 'with a non signed-in user' do
      before { post "/articles/#{article.id}/comments", params: { comment: {body: 'Awesome blog'} } }

      it 'redirect user to the signin page' do
        flash_message = 'You need to sign in or sign up before continuing.'
        expect(response).to redirect_to(new_user_session_path)
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq(flash_message)
      end
    end

    context 'with a logged in user' do
      before do
        login_as(user2)
        post "/articles/#{article.id}/comments", params: { comment: {body: 'Awesome blog'} }
      end

      it 'create athe comment sucessfully' do
        flash_message = 'Comment has been created'
        expect(response).to redirect_to(article_path(article.id))
        expect(response.status).to eq(302)
        expect(flash[:notice]).to eq(flash_message)
      end
    end
  end
end
