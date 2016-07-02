require 'rails_helper'

RSpec.describe ArticlesController do

  shared_examples 'public access to articles' do
    describe 'GET #show' do
      let(:article) { create(:article) }

      it 'assigns the requested article to @article' do
        get :show, params: {id: article}
        expect(assigns(:article)).to eq article
      end

      it 'renders the show template' do
        get :show, params: {id: article}
        expect(response).to render_template :show
      end
    end
  end


  shared_examples 'full access to articles' do
    let(:user) { create(:user) }
    let(:article) { create(:article, author: user) }
    let!(:category) { create(:category) }

    before(:each) do
      sign_in user
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        it 'save the new article in the database' do
          expect{
            post :create, params: { article: attributes_for(:article),
              categories: {"category 1" => "#{category.id}"} }
          }.to change(Article, :count).by(1)
        end

        it 'redirect to article#show' do
          post :create, params: { article: attributes_for(:article),
            categories: {"category 1" => "#{category.id}"}}
          expect(response).to redirect_to article_path(assigns(:article))
        end

        it 'articles created with information about the user who created it' do
          sign_in user

          post :create, params: { article: attributes_for(:article, title: "Hallo User"),
            categories: {"category 1" => "#{category.id}"}}
          article = Article.find_by(title: "Hallo User")
          expect(article.author).to eq user
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new article in the database' do
          expect{
            post :create, params: {article: attributes_for(:invalid_article)}
          }.to_not change(Article, :count)
        end

        it 're-renders the :new template' do
          post :create, params: {article: attributes_for(:invalid_article)}
          expect(response).to render_template :new
        end
      end
    end

    describe 'PUTCH #update' do
      let!(:category) { create(:category) }

      context 'valid attributes' do
        it 'locates requested article' do
          patch :update, params: { id: article, article: attributes_for(:article) }
          expect(assigns(:article)).to eq(article)
        end

        it 'changes @article attributes' do
          patch :update, params: { id: article, article: attributes_for(:article,
            title: "Goodbuy world"), categories: {"category 1" => "#{category.id}"}}
          article.reload
          expect(article.title).to eq("Goodbuy world")
        end

        it 'redirects to updated article' do
          patch :update, params: {id: article, article: attributes_for(:article),
            categories: {"category 1" => "#{category.id}"}}
          expect(response).to redirect_to article
        end
      end

      context 'with invalid attributes' do
        it 'does not change article\'s attributes' do
          patch :update, params: {id: article, article: attributes_for(:invalid_article)}
          article.reload
          expect(article.title).to eq(article.title)
          expect(article.description).not_to eq "This is invalid description"
        end

        it 're-renders edit template' do
          patch :update, params: {id: article, article: attributes_for(:invalid_article)}
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      let!(:article) { create(:article, author: user) }
      it 'deletes the article' do
        expect{
          delete :destroy, params: { id: article }
        }.to change(Article, :count).by(-1)
      end

      it 'redirects to articles#index' do
        delete :destroy, params: { id: article }
        expect(response).to redirect_to categories_url
      end
    end
  end

  describe 'guest access to articles' do
    it_behaves_like 'public access to articles'

    context 'requires login' do
      it 'GET #new' do
        get :new
        expect(response).to require_login
      end

      it 'POST #create' do
        post :create
        expect(response).to require_login
      end

      it 'GET #edit' do
        get :edit, params: { id: create(:article) }
        expect(response).to require_login
      end

      it 'PATCH #update' do
        patch :update, params: { id: create(:article) }
        expect(response).to require_login
      end

      it 'DELETE #destroy' do
        delete :destroy, params: { id: create(:article) }
        expect(response).to require_login
      end
    end
  end

  describe 'user access to articles' do
    it_behaves_like 'public access to articles'
    it_behaves_like 'full access to articles'
  end

  describe 'not author access to articles' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:category) { create(:category) }
    let(:article) { create(:article, author: user) }

    before(:each) do
      sign_in other_user
    end

    describe '#GET edit' do
      it 'redirects to root url' do
        get :edit, params: { id: article }
        expect(response).to redirect_to root_url
      end
    end

    describe '#PUTCH update' do
      it 'redirects to root url' do
        patch :edit, params: { id: article, article: attributes_for(:article),
          categories: {"category 1" => "#{category.id}"}}
        expect(response).to redirect_to root_url
      end
    end

    describe '#DELETE destroy' do
      it 'redirects to root url' do
        delete :edit, params: { id: article }
        expect(response).to redirect_to root_url
      end
    end
  end
end
