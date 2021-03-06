require 'rails_helper'

feature 'Remove orders' do
  scenario 'can remove order from Dashboard' do
    group = create :group
    create :manager_example_com, group: group
    user = create :user, :groupped, group: group
    order = create :order, user: user, group: group

    sign_in_as 'manager@example.com'
    visit dashboard_path
    within 'li', text: user.email do
      click_link "delete_order_#{order.id}"
    end

    expect(page).not_to have_content user.email
  end
end
