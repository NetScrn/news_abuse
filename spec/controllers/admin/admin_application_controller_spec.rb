require 'rails_helper'

RSpec.describe Admin::ApplicationController, type: :controller do
  let(:admin_user) { create(:user, :admin) }
  let(:not_admin_user) { create(:user) }

    it 'not admin user cannot access to admin pages' do
      sign_in not_admin_user
      get :index
      expect(response).to redirect_to root_url
    end

    it "admin user can access to admin page" do
      sign_in admin_user
      get :index
      expect(response).to render_template :index
    end
end
