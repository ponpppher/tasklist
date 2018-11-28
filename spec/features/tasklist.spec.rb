require 'rails_helper'


feature 'タスク管理機能', type: :feature do
  background do
    FactoryBot.create(:task, title:'testtitle', content: 'testcontent', limit_datetime: '20181130')
    FactoryBot.create(:task, title:'one', content: 'testcontent', priority: "high", limit_datetime: '20181201')
    FactoryBot.create(:task, title:'two', content: 'testcontent', priority: "high", limit_datetime: '20181215')
    FactoryBot.create(:task, title:'three', content: 'threecontent', status: "完了", priority: "low", limit_datetime: '20181220')
  end

  scenario 'タスク一覧のテスト' do
    visit root_path
    expect(page).to have_selector 'td.title', text:'three'
    expect(page).to have_selector 'td.content', text:'threecontent'
    expect(page).to have_selector 'td.status', text:'完了'
    expect(page).to have_selector 'td.priority', text:'低'
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
    expect(page).to have_selector 'td.title', text:'footitle'
    expect(page).to have_selector 'td.content', text:'barcontent'
    expect(page).to have_selector 'td.status', text:'着手'
    expect(page).to have_selector 'td.priority', text:'低'
    expect(page).to have_selector 'span.limit_datetime', text:'2018-12-25 00:00:00 +0900'
  end

  scenario 'タスク詳細のテスト' do
    visit root_path
    task = Task.find_by(title: "three")
    click_link '詳細', href: task_path(task)
    expect(page).to have_content 'three'
    expect(page).to have_content 'threecontent'
    expect(page).to have_content '完了'
    expect(page).to have_content '低'
    expect(page).to have_content '2018-12-20 00:00:00 +0900'
  end

  scenario 'タスクが作成日時の降順に並んでいるかのテスト' do
    visit root_path
    mach_str = ['testtitle', 'one', 'two', 'three'].reverse
    page_index = 2

    for i in 0..page_index do
      expect(all('td.title')[i]).to have_text mach_str[i]
    end

    click_link 'Next'

    nextpage=page_index+1
    expect(all('td.title')[0]).to have_text mach_str[nextpage]
  end

  scenario 'タスクが終了期限が降順かのテスト' do
    visit root_path
    match_date = [
      '2018-12-20 00:00:00 +0900',
      '2018-12-15 00:00:00 +0900',
      '2018-12-01 00:00:00 +0900',
      '2018-11-30 00:00:00 +0900',
    ]
    page_index=2

    click_link '終了期限でソートする'

    for i in 0..page_index do
      expect(all('span.limit_datetime')[i]).to have_text match_date[i]
    end

    click_link 'Next'

    nextpage=page_index+1
    expect(all('span.limit_datetime')[0]).to have_text match_date[nextpage]

  end

  scenario '優先度でのソート' do
    match_date = [
      'two','one','testtitle','three'
    ]
    visit root_path
    page_index = 2

    click_link '優先順位でソートする'

    for i in 0..page_index do
      expect(all('td.title')[i]).to have_text match_date[i]
    end

    click_link 'Next'

    nextpage=page_index+1
    expect(all('td.title')[0]).to have_text match_date[nextpage]

  end
end
