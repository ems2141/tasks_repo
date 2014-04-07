require 'sequel'

class TasksRepo
  def initialize(db)
    @tasks_table = db[:tasks]
  end

  def create(attributes)
    @tasks_table.insert(attributes)
  end

  def all
    @tasks_table.to_a
  end

  def update(id, name)
    @tasks_table.where(:id => id).update(name)
  end

  def delete(id)
    @tasks_table.where(:id => id).delete
  end
end