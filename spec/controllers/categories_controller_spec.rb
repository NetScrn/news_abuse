require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe 'GET #show' do
    it 'assigns the requested through will_paginate articles' do
      category = create(:category_with_articles, articles_count: 20)
      get :show, params: {id: category, page: 2}
      expect(assigns(:articles)).to eq category.articles.last(10)
    end
  end
end
