require 'rails_helper'

RSpec.feature "User adds a new reward to the database" do
  context "user can fill out a form and generate a new reward" do



    it "can create rewards" do
      user = create(:user)
      project = create(:project)
      user.projects <<  project
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit new_reward_path

      fill_in "reward[title]", with: "Raw Denim Romphim"
      fill_in "reward[description]", with: "24 ounce Kahari Mills left-hand twill denim"
      fill_in "reward[pledge_amount]", with: 475
      fill_in "reward[limit]", with: 1

      click_on "Save and Continue"

      expect(current_path).to eq(project_path(project))
      expect(Reward.last.title).to eq("Raw Denim Romphim")
      expect(Reward.last.description).to eq("24 ounce Kahari Mills left-hand twill denim")
      expect(Reward.last.pledge_amount).to eq(475)
      expect(Reward.last.limit).to eq(1)
      expect(page).to have_content("Raw Denim Romphim")
    end
  end
end
