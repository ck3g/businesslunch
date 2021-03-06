require 'rails_helper'

RSpec.describe UserDecorator, type: :decorator do
  describe '#balance' do
    subject { UserDecorator.new(user).balance('Balance: ') }

    context 'when balance is more than lunch price' do
      let(:group) { double currency_unit: 'MDL' }
      let(:user) { double balance: 100, current_group: group }

      it do
        is_expected.to eq '<span class="text-success">Balance: 100 MDL</span>'
      end
    end

    context 'when balance is less than lunch price' do
      let(:group) { double currency_unit: 'MDL' }
      let(:user) { double balance: 30, current_group: group }

      it do
        is_expected.to eq '<span class="text-danger">Balance: 30 MDL</span>'
      end
    end
  end

  describe '#full_name' do
    context "when user's email is john.doe@example.com" do
      subject do
        UserDecorator.new(double email: 'john.doe@example.com').full_name
      end

      it { is_expected.to eq 'John Doe' }
    end
  end
end
