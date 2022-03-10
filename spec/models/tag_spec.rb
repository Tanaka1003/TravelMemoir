# frozen_string_literal: true

require 'rails_helper'

describe 'モデルのテスト' do
  it "有効なタグ名の場合は保存されるか" do
    expect(FactoryBot.build(:tag)).to be_valid
  end
end