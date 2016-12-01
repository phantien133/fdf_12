require "rails_helper"

RSpec.describe Shop, type: :model do
  subject {FactoryGirl.create(:shop)}

  context "associations" do
    it {is_expected.to belong_to :owner}
    it {is_expected.to have_many :users}
    it {is_expected.to have_many :reviews}
    it {is_expected.to have_many :comments}
    it {is_expected.to have_many :shop_managers}
    it {is_expected.to have_many :orders}
    it {is_expected.to have_many :order_products}
    it {is_expected.to have_many :tags}
    it {is_expected.to have_many :events}
  end

  describe "validates" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
    it {is_expected.to validate_presence_of :description}

    context "validates name" do
      it {is_expected.to validate_presence_of :name}
      it "is not valid with too long name" do
        subject.name = Faker::Name.name * 51
        is_expected.to_not be_valid
      end
    end
  end

  describe ".is_owner? user" do
    it "owner user" do
      expect(subject.is_owner? subject.owner).to be_truthy
    end
    it "not owner user" do
      expect(subject.is_owner? subject.owner).to be_truthy
    end
  end

  describe ".get_shop_manager_by user" do
    it "should get user" do
      shop_manager = subject.shop_managers.first
      expect(subject.get_shop_manager_by shop_manager.user).to eq(shop_manager)
    end
  end

  describe ".all_tags" do
    it "should get unique tags" do
      expect(subject.all_tags).to eq(subject.tags.uniq)
    end
  end

  describe ".create" do
    it "should create ShopManager after create" do
      expect{[FactoryGirl.create(:shop)]}.to change{ShopManager.count}
    end
  end

  describe ".update" do
    it "should update attributes" do
      new_name = Faker::Name.name
      subject.update_attributes name: new_name, status: Shop.statuses[:rejected]
      expect(subject.name).to eq(new_name)
    end
  end
end
