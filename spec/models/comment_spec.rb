require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:article) { create(:article) }
  it 'crate valid' do
    comment = Comment.new(content: "sakfjdaslkfjas", article: article)
    expect(comment).to be_valid
  end
end
