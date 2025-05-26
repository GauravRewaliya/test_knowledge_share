class JsonProcessing
  def self.extract_first_array(json_body)
    if json_body.is_a?(Hash)
      json_body.each do |key, value|
        if value.is_a?(Array)
          if value.all? { |item| [String, Integer, Float, TrueClass, FalseClass].any? { |cls| item.is_a?(cls) } }
            json_body[key] = value.any? ? [value.first] : []
          elsif value.all? { |item| item.is_a?(Hash) }
            json_body[key] = value.any? ? [JsonProcessing.extract_first_array(value.first)] : []
          else
            raise "Invalid JSON structure"+value.type 
          end
        elsif value.is_a?(Hash)
          json_body[key] = JsonProcessing.extract_first_array(value)
        end
      end
    elsif json_body.is_a?(Array)
      json_body = json_body.any? ? [JsonProcessing.extract_first_array(json_body.first)] : []
    end
    return json_body
  end
  def self.extract_first_object(json_body) # v2
    if json_body.is_a?(String) || json_body.is_a?(Integer) || json_body.is_a?(Float) || json_body.is_a?(TrueClass) || json_body.is_a?(FalseClass)
      return json_body
    elsif json_body.is_a?(Array)
      return [JsonProcessing.extract_first_object(json_body.first)]
    elsif json_body.is_a?(Hash)
      for key, value in json_body
        json_body[key] = JsonProcessing.extract_first_object(value)
      end
      return JSON.parse(json_body.to_json)
    end
  end

  def clean_response(response, json_filter)
    
  end
end