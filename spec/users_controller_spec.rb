require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  context "GET show" do
    let!(:user) {FactoryGirl.create(:user)}

    it "should redirect to sign in" do
      get :show, id: user.id
      expect(response).to redirect_to(new_user_session_path)
    end

    it "should render template show user" do
      sign_in user
      get :show, id: user.id
      expect(response).to render_template(:show)
    end

    it "should be param" do
      get :show, id: user.id
      expect(user).to be
    end

    it "should not be param" do
      sign_in FactoryGirl.create(:user)
      user.destroy
      get :show, id: user.id
      expect(flash[:danger]).to be_present
    end
  end
end
