require 'tasks_repo'

DB = Sequel.connect("postgres://gschool_user:password@localhost:5432/tasks_test")

describe TasksRepo do
  before do
    DB.create_table! :tasks do
      primary_key :id
      String :description
      Boolean :completed, default: false
    end
  end


  it "can create tasks" do

    repository = TasksRepo.new(DB)

    description = "do #{rand(2..20)} things"
    repository.create(description: description)
    tasks = repository.all
    expect(tasks).to eq(
                         [
                             {id: 1, description: description, completed: false}
                         ]
                     )
  end


end