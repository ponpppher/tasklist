require 'rails_helper'

RSpec.describe Task, type: :mode do
  it "titleが空であればバリデーションが通らない" do
    task = Task.new(title: "", content:"kyoumotodoketakute")
    expect(task).not_to be_valid
  end

  it "contentが空であればバリデーションが通らない" do
    task = Task.new(title: "utumukanaide", content:"")
    expect(task).not_to be_valid
  end

  it "titleとcontentが記載されていればバリテーションが通る" do
    task = Task.new(title: "kitto", content:"a-a-lov")
    expect(task).to be_valid
  end
end
