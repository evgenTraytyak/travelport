require 'active_support/all'
module Travelport::Model::AttributeMethods
  def attributes
    HashWithIndifferentAccess[instance_variables.map do |var|
      [var.to_s.gsub("@", ""), instance_variable_get(var)] unless instance_variable_get(var).nil?
    end.compact]
  end

  def update_keys(hash)
    new_hash = {}

    hash.each do |key, val|
      updated_value = val.is_a?(Hash) ? update_keys(val) : val

      updated_value = val.is_a?(Array) ?
        val.map{ |e| e.is_a?(Hash) ? update_keys(e) : e } :
        updated_value

      updated_key = "#{key.to_s.gsub('@', '')}".to_sym

      new_hash[updated_key] = updated_value
    end

    new_hash
  end

  def update_attributes(hash)
    hash.each do |key, val|
      attribute_setter = "#{key.to_s.gsub('@', '')}=".to_sym

      updated_value = val.is_a?(Hash) ? update_keys(val) : val

      if self.respond_to?(attribute_setter)
        self.send(attribute_setter, updated_value)
      else
        # unrecognised option
      end
    end
  end
end
