require 'rails_helper'

RSpec.describe "Articles", type: :request do
  let(:article) { Article.create(title: 'Title one', body: 'Body of article one') }

  # describe "GET /index" do
  #   it "returns http success" do
  #     get "/articles/index"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

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
