require 'rails_helper'

RSpec.describe Admin::ArticlesController, type: :controller do
  let(:user) { create(:user) }
  let!(:unconfirmed_article) { create(:article, :unconfirmed, author: user) }
  let(:admin) { create(:user, :admin) }

  describe '#POST confirm' do
    it 'confirms article' do
      sign_in admin

      @request.env['HTTP_REFERER'] = 'http://test.com/en/admin/articles'
      post :confirm, id: unconfirmed_article
      unconfirmed_article.reload
      expect(unconfirmed_article.confirmed?).to be_truthy
      expect(flash[:success]).to eq "Article has been confirmed"
    end
  end

  describe '#DELETE reject' do
    it 'reject and delete article' do
      sign_in admin

      @request.env['HTTP_REFERER'] = 'http://test.com/en/admin/articles'
      expect {
        delete :reject, id: unconfirmed_article
      }.to change(Article, :count).by(-1)
      expect(flash[:success]).to eq "Article has been rejected and deleted"
    end
  end
end
