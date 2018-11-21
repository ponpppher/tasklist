require 'rails_helper'

feature 'タスク管理機能', type: :feature do
  background do
    FactoryBot.create(:task, title:'testtitle', content: 'testcontent')
    FactoryBot.create(:task, title:'one', content: 'testcontent')
    FactoryBot.create(:task, title:'two', content: 'testcontent')
    FactoryBot.create(:task, title:'three', content: 'testcontent')
  end

  scenario 'タスク一覧のテスト' do
    visit root_path
    expect(page).to have_selector 'li.title', text:'testtitle'
    expect(page).to have_selector 'li.content', text:'testcontent'
  end

  scenario 'タスク作成のテスト' do
    visit new_task_path
    fill_in 'task_title', with: 'footitle'
    fill_in 'task_content', with: 'barcontent'
    click_button '登録する'
    expect(page).to have_selector 'li.title', text:'footitle'
    expect(page).to have_selector 'li.content', text:'barcontent'
  end

  scenario 'タスク詳細のテスト' do
    visit root_path
    task = Task.find_by(title: "testtitle")
    click_link '詳細', href: task_path(task)
    expect(page).to have_content 'タスク名:testtitle'
    expect(page).to have_content '内容:testcontent'
  end

  scenario 'タスクが作成日時の降順に並んでいるかのテスト' do
    visit root_path
    mach_str = ['testtitle', 'one', 'two', 'three'].reverse

    for i in 0..5 do
      expect(all('li.title')[i]).to have_text mach_str[i]
    end

  end
end
