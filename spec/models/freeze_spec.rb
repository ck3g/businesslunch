require 'rails_helper'

RSpec.describe Freeze, type: :model do
  it 'has a valid factory' do
    expect(create :freeze).to be_valid
  end

  describe '.after_create' do
    let(:freeze) { build :freeze, frozen_on: nil }
    it "set frozen_on" do
      expect {
        freeze.save
        freeze.reload
      }.to change { freeze.frozen_on }
    end
  end

  describe '.frozen_now?' do
    subject { Freeze.frozen_now? }

    context 'when frozen_on for today exists' do
      let!(:freeze) { create :freeze }
      it { is_expected.to be_truthy }
    end

    context 'when frozen_on for today is not exists' do
      it { is_expected.to be_falsey }
    end
  end
end