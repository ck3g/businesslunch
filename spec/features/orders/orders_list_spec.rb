require 'rails_helper'

feature 'Orders list' do
  context 'when user didnt make orders yet' do
    scenario 'can see make order button' do
      create :user_example_com, :groupped

      sign_in_as 'user@example.com'
      visit orders_path

      expect(page).to have_selector 'a', text: 'Order Now!'
    end
  end

  scenario 'user be able to see his orders' do
    user = create :user_example_com, :groupped
    order = create :order, user: user, group: user.current_group

    sign_in_as 'user@example.com'

    expect(current_path).to eq orders_path
    expect(page).to have_content 'Orders'
    expect(page).to have_selector 'a', text: 'Make another order'
    within "li#order_#{order.id}" do
      expect(page).to have_content order.menu_set_name
    end
  end

  scenario 'user be able to see frozen message' do
    user = create :user_example_com, :groupped
    create :freeze, group: user.current_group

    sign_in_as 'user@example.com'
    visit orders_path

    expect(page).to have_content I18n.t('orders.frozen')
    expect(page).not_to have_selector 'a', text: 'Order Now!'
  end
end
