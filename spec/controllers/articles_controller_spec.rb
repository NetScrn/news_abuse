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

  describe 'PUTCH #update' do
    before(:each) do
      @article = create(:article, title: "Hello World")
    end

    context 'valid attributes' do
      it 'locates requested article' do
        patch :update, id: @article, article: attributes_for(:article)
        expect(assigns(:article)).to eq(@article)
      end

      it 'changes @article attributes' do
        patch :update, id: @article, article: attributes_for(:article,
          title: "Goodbuy world")
        @article.reload
        expect(@article.title).to eq("Goodbuy world")
      end

      it 'redirects to updated article' do
        patch :update, id: @article, article: attributes_for(:article)
        expect(response).to redirect_to @article
      end
    end

    context 'with invalid attributes' do
      it 'does not change article\'s attributes' do
        patch :update, id: @article, article: attributes_for(:article,
          title: nil,
          description: "This is invalid description")
        @article.reload
        expect(@article.title).to eq("Hello World")
        expect(@article.description).not_to eq "This is invalid description"
      end

      it 're-renders edit template' do
        patch :update, id: @article, article: attributes_for(:invalid_article)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      @article = create(:article)
    end

    it 'deletes the article' do
      expect{
        delete :destroy, id: @article
      }.to change(Article, :count).by(-1)
    end

    it 'redirects to articles#index' do
      delete :destroy, id: @article
      expect(response).to redirect_to categories_url
    end
  end
end
