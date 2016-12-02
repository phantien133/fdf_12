require "rails_helper"

RSpec.describe "users/show.html.erb", type: :view do

  let!(:user) {FactoryGirl.create(:user)}

  it "displays user correctly" do
    assign :user, user
    render
    expect(rendered).to include(user.name)
  end

  it "displays edit path on current user view" do
    sign_in user
    assign :user, user
    render
    expect(rendered).to include(edit_user_registration_path)
  end
end
