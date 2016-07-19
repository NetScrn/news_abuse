require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let(:admin_user) { create(:user, :admin) }

  describe "GET #index" do
    it "returns correct users" do
      sign_in admin_user
      get :index
      expect(response).to render_template :index
      expect(assigns(:users).to_a).to eq User.all.limit(40).to_a
    end
  end

  # describe "GET #new" do
  #   it "returns http success" do
  #   end
  # end
  #
  # describe "GET #create" do
  #   it "returns http success" do
  #   end
  # end
  #
  # describe "GET #edit" do
  #   it "returns http success" do
  #   end
  # end
  #
  # describe "GET #update" do
  #   it "returns http success" do
  #   end
  # end
  #
  # describe "GET #archive" do
  #   it "returns http success" do
  #   end
  # end

end
