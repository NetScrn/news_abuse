require 'rails_helper'

RSpec.describe ArticlesController do
  describe 'GET #show' do
    it 'assigns the requested article to @article' do
      article = create(:article)
      get :show, id: article
      expect(assigns(:article)).to eq article
    end

    it 'renders the show template' do
      article = create(:article)
      get :show, id: article
      expect(response).to render_template :show
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'save the new article in the database' do
        expect{
          post :create, article: attributes_for(:article)
        }.to change(Article, :count).by(1)
      end

      it 'redirect to article#show' do
        post :create, article: attributes_for(:article)
        expect(response).to redirect_to article_path(assigns(:article))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new article in the database' do
        expect{
          post :create, article: attributes_for(:invalid_article)
        }.to_not change(Article, :count)
      end

      it 're-renders the :new template' do
        post :create, article: attributes_for(:invalid_article)
        expect(response).to render_template :new
      end
    end
  end
end
