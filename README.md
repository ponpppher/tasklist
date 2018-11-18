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
- state integer

## labes

- taks_id bigint
- name string

## task_groups

- task_id bigint
- label_id bigint
