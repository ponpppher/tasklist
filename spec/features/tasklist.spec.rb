require 'rails_helper'

feature 'タスク管理機能', type: :feature do
  background do
    Task.create!(title:'testtitle', content:'testcontent')
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
    click_button 'Create Task'
    expect(page).to have_selector 'li.title', text:'footitle'
    expect(page).to have_selector 'li.content', text:'barcontent'
  end

  background do
    Task.create!(title:'komeda', content:'coffiee')
  end

  scenario 'タスク詳細のテスト' do
    visit root_path
    task = Task.find_by(title: "komeda")
    click_link 'show', href: task_path(task)
    expect(page).to have_content 'title:komeda'
    expect(page).to have_content 'content:coffiee'
  end
end
