class Question < ApplicationRecord
  serialize :tags, coder: YAML
end
