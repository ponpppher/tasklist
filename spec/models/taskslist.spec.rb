require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    Task.create( title:'not_yet_started_title', content: 'testcontent', status: '未着手', limit_datetime: '20181130')
    Task.create( title:'start_title', content: 'testcontent', status: '着手', limit_datetime: '20181201')
    Task.create( title:'complete_title', content: 'testcontent', status: '完了', limit_datetime: '20181215')
    Task.create( title:'three', content: 'testcontent', limit_datetime: '20181220')
  end

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

  it "未着手で検索できる" do
    task = Task.not_yet_started
    expect(task.pluck(:title)[0]).to eq 'not_yet_started_title'
  end

  it "開始で検索できる" do
    task = Task.start
    expect(task.pluck(:title)[0]).to eq 'start_title'
  end

  it "完了で検索できる" do
    task = Task.complete
    expect(task.pluck(:title)[0]).to eq 'complete_title'
  end
end
