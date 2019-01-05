# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    User.create(name: 'first_user', email: 'a@gmail.com', password_digest: 'aaaaaa')
    User.create(name: 'second_user', email: 'b@gmail.com', password_digest: 'aaaaaa')
    User.create(name: 'third_user', email: 'c@gmail.com', password_digest: 'aaaaaa')

    Task.create(title: 'first_task', content: 'testcontent', status: :waiting, limit_datetime: '20181130', user_id: 1)
    Task.create(title: 'second_task', content: 'testcontent', status: :working, limit_datetime: '20181201', user_id: 2)
    Task.create(title: 'third_task', content: 'testcontent', status: :complated, limit_datetime: '20181215', user_id: 3)
    Task.create(title: 'fourth_task', content: 'testcontent', limit_datetime: '20181220', user_id: 1)
  end

  it 'titleが空であればバリデーションが通らない' do
    task = Task.new(title: '', content: 'kyoumotodoketakute')
    expect(task).not_to be_valid
  end

  it 'contentが空であればバリデーションが通らない' do
    task = Task.new(title: 'utumukanaide', content: '')
    expect(task).not_to be_valid
  end
end
