# frozen_string_literal: true

require 'rails_helper'

feature 'タスク管理機能', type: :feature do
  background do
    # labes
    label_luckey = FactoryBot.create(:label, name: 'ラッキー')
    label_coil = FactoryBot.create(:label, name: 'コイル')
    label_butterfree = FactoryBot.create(:label, name: 'バタフリー')

    # user
    user_min = FactoryBot.create(:user, name: 'mincon', email: 'ppp@gmail.com', password: 'aaaaaa', password_confirmation: 'aaaaaa')

    # task
    task_test = FactoryBot.create(:task, title: 'testtitle', user: user_min, content: 'testcontent', limit_datetime: '20181130')
    FactoryBot.create(:labeling, task: task_test, label: label_luckey)

    FactoryBot.create(:task, title: 'one', user: user_min, content: 'testcontent', priority: 'high', limit_datetime: '20181201')
    FactoryBot.create(:task, title: 'two', user: user_min, content: 'testcontent', priority: 'high', limit_datetime: '20181215')

    task_three = FactoryBot.create(:task, title: 'three', user: user_min, content: 'threecontent', status: '完了', priority: 'low', limit_datetime: '20181220')
    FactoryBot.create(:labeling, task: task_three, label: label_butterfree)
    FactoryBot.create(:labeling, task: task_three, label: label_coil)

    visit new_session_path
    fill_in 'Email', with: 'ppp@gmail.com'
    fill_in 'Password', with: 'aaaaaa'
    click_button '保存する'
  end

  scenario 'タスク一覧のテスト' do
    visit root_path
    expect(page).to have_selector 'td.title', text: 'three'
    expect(page).to have_selector 'td.content', text: 'testcontent'
    expect(page).to have_selector 'td.status', text: '完了'
    expect(page).to have_selector 'td.priority', text: '低'
  end

  scenario 'タスク作成のテスト' do
    visit new_task_path
    fill_in 'タスク名', with: 'footitle'
    fill_in '内容', with: 'barcontent'
    select '着手', from: '状態'
    select '低', from: '優先度'
    date_str = '2018-12-25 00:00:00 +0900'
    fill_in '終了期限', with: DateTime.parse(date_str)
    click_button('登録する')
    expect(page).to have_selector 'td.title', text: 'footitle'
    expect(page).to have_selector 'td.content', text: 'barcontent'
    expect(page).to have_selector 'td.status', text: '着手'
    expect(page).to have_selector 'td.priority', text: '低'
    expect(page).to have_selector 'span.limit_datetime', text: '2018-12-25 00:00:00 +0900'
  end

  scenario 'タスク詳細のテスト' do
    visit root_path
    task = Task.find_by(title: 'three')
    click_link '詳細', href: task_path(task)
    expect(page).to have_content 'three'
    expect(page).to have_content 'threecontent'
    expect(page).to have_content '完了'
    expect(page).to have_content '低'
    expect(page).to have_content 'コイル'
    expect(page).to have_content 'バタフリー'
    expect(page).to have_content '2018-12-20 00:00:00 +0900'
  end

  scenario 'タスクが作成日時の降順に並んでいるかのテスト' do
    visit root_path
    mach_str = %w[testtitle one two three].reverse
    page_index = 2

    for i in 0..page_index do
      expect(all('td.title')[i]).to have_text mach_str[i]
    end

    click_link 'Next'

    nextpage = page_index + 1
    expect(all('td.title')[0]).to have_text mach_str[nextpage]
  end

  scenario 'タスクが終了期限が降順かのテスト' do
    visit root_path
    match_date = [
      '2018-12-20 00:00:00 +0900',
      '2018-12-15 00:00:00 +0900',
      '2018-12-01 00:00:00 +0900',
      '2018-11-30 00:00:00 +0900'
    ]
    page_index = 2

    click_link '終了期限でソートする'

    for i in 0..page_index do
      expect(all('span.limit_datetime')[i]).to have_text match_date[i]
    end

    click_link 'Next'

    nextpage = page_index + 1
    expect(all('span.limit_datetime')[0]).to have_text match_date[nextpage]
  end

  scenario '優先度でのソート' do
    match_date = %w[
      two one testtitle three
    ]
    visit root_path
    page_index = 2

    click_link '優先順位でソートする'

    for i in 0..page_index do
      expect(all('td.title')[i]).to have_text match_date[i]
    end

    click_link 'Next'

    nextpage = page_index + 1
    expect(all('td.title')[0]).to have_text match_date[nextpage]
  end

  scenario 'ラベルで検索' do
    visit root_path
    choose 'コイル'
    click_on 'ラベル検索'

    expect(page).to have_selector 'td.title', text: 'three'
    expect(page).not_to have_selector 'td.title', text: 'testtitle'
  end
end
