class Task < ActiveRecord::Base
  belongs_to :user

  def set_defaults()

    self.priority = 2 
    self.workflow = "p"
    self.redundancy = 2
    self.resource = "www.google.com"
    self.resourcetype = "l"
    self.fields = '[{"Answer":"t"}]'
    self.save!

  end

  def set_defaults_if_null()

    self.priority = 2 if Task.not_set(self.priority)
    self.workflow = "p" if Task.not_set(self.workflow)
    self.redundancy = 2 if Task.not_set(self.redundancy)
    self.resource = "www.google.com" if Task.not_set(self.resource)
    self.resourcetype = "l" if Task.not_set(self.resourcetype)
    self.fields = '[{"Answer":"t"}]' if Task.not_set(self.fields)
    self.save!
  end

  def self.not_set(var)
    return (var.nil? or var == "")
  end

end
