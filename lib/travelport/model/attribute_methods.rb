require 'active_support/all'
module Travelport::Model::AttributeMethods
	def attributes
		HashWithIndifferentAccess[instance_variables.map do |var|
			[var.to_s.gsub("@", ""), instance_variable_get(var)] unless instance_variable_get(var).nil?
		end.compact]
	end

  def update_attributes(hash)
    hash.each do |key, val|
      attribute_setter = "#{key.to_s.gsub('@', '')}=".to_sym
      if self.respond_to?(attribute_setter)
        self.send(attribute_setter, val)
      else
        # unrecognised option
      end
    end
  end
end