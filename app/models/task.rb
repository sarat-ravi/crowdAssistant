class Task < ActiveRecord::Base
  belongs_to :user


  def handle_null_params()
    set_defaults_if_null()
  end

  def set_defaults()

    self.priority = 2 
    self.workflow = "p"
    self.redundancy = 2
    self.resource = "www.google.com"
    self.resourcetype = "l"
    self.fields = '[{"Answer":"t"}]'

  end

  def set_defaults_if_null()

    self.priority = 2 if not_set(self.priority)
    self.workflow = "p" if not_set(self.workflow)
    self.redundancy = 2 if not_set(self.redundancy)
    self.resource = "www.google.com" if not_set(self.resource)
    self.resourcetype = "l" if not_set(self.resourcetype)
    self.fields = '[{"Answer":"t"}]' if not_set(self.fields)

  end
  def not_set(var)
    return true if var.nil? or var == ""
    return false
  end

end
