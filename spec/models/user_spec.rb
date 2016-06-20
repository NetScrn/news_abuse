require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has increace #articles when creates Articles' do
    user = create(:user)
    users_articles = create_list(:article, 5, author: user)

    expect(user.articles).to match_array users_articles
  end
end
