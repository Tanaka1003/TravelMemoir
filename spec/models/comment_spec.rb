# frozen_string_literal: true

require 'rails_helper'

describe 'モデルのテスト' do
  it "有効なコメント内容の場合は保存されるか" do
    expect(FactoryBot.build(:comment)).to be_valid
  end
end