require 'rails_helper'


feature 'タスク管理機能', type: :feature do
  background do
    FactoryBot.create(:task, title:'testtitle', content: 'testcontent', limit_datetime: '20181130')
    FactoryBot.create(:task, title:'one', content: 'testcontent', priority: "high", limit_datetime: '20181201')
    FactoryBot.create(:task, title:'two', content: 'testcontent', priority: "high", limit_datetime: '20181215')
    FactoryBot.create(:task, title:'three', content: 'testcontent', priority: "low", limit_datetime: '20181220')
  end

  scenario 'タスク一覧のテスト' do
    visit root_path
    expect(page).to have_selector 'p.title', text:'testtitle'
    expect(page).to have_selector 'p.content', text:'testcontent'
  end

  scenario 'タスク作成のテスト' do
    visit new_task_path
    fill_in 'タスク名', with: 'footitle'
    fill_in '内容', with: 'barcontent'
    select '低', from: '優先度'
    date_str = '2018-12-25 00:00:00 +0900'
    fill_in '終了期限', with: DateTime.parse(date_str)
    click_button('登録する')
    expect(page).to have_selector 'p.title', text:'footitle'
    expect(page).to have_selector 'p.content', text:'barcontent'
    expect(page).to have_selector 'p.priority', text:'低'
    expect(page).to have_selector 'span.limit_datetime', text:'2018-12-25 00:00:00 +0900'
  end

  scenario 'タスク詳細のテスト' do
    visit root_path
    task = Task.find_by(title: "testtitle")
    click_link '詳細', href: task_path(task)
    expect(page).to have_content 'タスク名:testtitle'
    expect(page).to have_content '内容:testcontent'
    expect(page).to have_content '終了期限:2018-11-30 00:00:00 +0900'
  end

  scenario 'タスクが作成日時の降順に並んでいるかのテスト' do
    visit root_path
    mach_str = ['testtitle', 'one', 'two', 'three'].reverse

    for i in 0..5 do
      expect(all('p.title')[i]).to have_text mach_str[i]
    end
  end

  scenario 'タスクが終了期限が降順かのテスト' do
    visit root_path
    match_date = [
      '2018-12-20 00:00:00 +0900',
      '2018-12-15 00:00:00 +0900',
      '2018-12-01 00:00:00 +0900',
      '2018-11-30 00:00:00 +0900',
    ]

    click_link '終了期限でソートする'

    for i in 0..5 do
      expect(all('span.limit_datetime')[i]).to have_text match_date[i]
    end
  end

  scenario '優先度でのソート' do
    match_date = [
      'two','one','testtitle','three'
    ]
    visit root_path

    click_link '優先順位でソートする'

    for i in 0..3 do
      expect(all('p.title')[i]).to have_text match_date[i]
    end
  end
end
