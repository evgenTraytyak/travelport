require 'active_support/all'
module Travelport::Model::AttributeMethods
  def attributes
    HashWithIndifferentAccess[instance_variables.map do |var|
      [var.to_s.delete("@"), instance_variable_get(var)] unless instance_variable_get(var).nil?
    end.compact]
  end

  def update_keys(hash)
    new_hash = {}

    hash.each do |key, val|
      if (val.is_a?(Hash))
        updated_value = update_keys(val)
      elsif (val.is_a?(Array))
        updated_value = val.map{ |e| e.is_a?(Hash) ? update_keys(e) : e }
      else
        updated_value = val
      end

      updated_key = key.to_s.delete('@').to_sym

      new_hash[updated_key] = updated_value
    end

    new_hash
  end

  def update_attributes(hash)
    hash.each do |key, val|
      attribute_setter = "#{key.to_s.delete('@')}=".to_sym

      updated_value = val.is_a?(Hash) ? update_keys(val) : val

      if respond_to?(attribute_setter)
        send(attribute_setter, updated_value)
      else
        # unrecognised option
      end
    end
  end
end
