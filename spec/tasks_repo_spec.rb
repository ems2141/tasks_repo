require 'tasks_repo'

DB = Sequel.connect("postgres://gschool_user:password@localhost:5432/tasks_test")

describe TasksRepo do
  before do
    DB.create_table! :tasks do
      primary_key :id
      String :name
      Boolean :complete, default: false
    end
    @tasks = TasksRepo.new(DB)
  end

  it "can create tasks" do
    @tasks.create(name: 'gSchool homework')
    @tasks.create(name: 'grocery store')
    expect(@tasks.all).to eq(
                              [{:id => 1, :name => 'gSchool homework', :complete => false},
                               {:id => 2, :name => 'grocery store', :complete => false}])
  end

  it "can update tasks" do
    @tasks.create(name: 'gSchool homework')
    @tasks.update(1, name: 'walk dog', complete: false)
    expect(@tasks.all).to eq [{:id => 1, :name => 'walk dog', :complete => false}]
  end

  it "can delete tasks" do
    @tasks.create(name: 'gSchool homework')
    @tasks.create(name: 'grocery store')
    @tasks.delete(2)
    expect(@tasks.all).to eq [{:id => 1, :name => 'gSchool homework', :complete => false}]
  end

  it "can find a task by id" do
    @tasks.create(name: 'walk dog')
    expect(@tasks.find(1)).to eq [{:id => 1, :name => 'walk dog', :complete => false}]
  end

end