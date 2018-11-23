#### 本アプリは以下の通りのスキーマにて開発予定です。
## users

- name string
- email string
- password-digest string

## tasks

- user_id bigint
- title string
- content string
- priority integer
- limit datetime

## states

- task_id bigint
- name string

## labes

- name string

## labeling

- task_id bigint
- label_id bigint

#### デプロイ方法 

```
git clone https://github.com/ponpppher/tasklist.git
cd tasklist
rails db:create
rails db:migrate
sudo service postgresql start
rails s
```

#### 各種バージョンなど

- rails (5.2.1)
- rspec-core (3.8.0)
- ruby 2.5.0p0
