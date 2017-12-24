require 'elasticsearch/model'

class Entry < ApplicationRecord
  belongs_to :feed
  
  #elastic
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :title, analyzer: 'english', index_options: 'offsets'
      indexes :content, analyzer: 'english'
    end
  end

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['title^10', 'content']
          }
        }
      }
    )
  end
end

# Delete the previous Entrys index in Elasticsearch
Entry.__elasticsearch__.client.indices.delete index: Entry.index_name rescue nil

# Create the new index with the new mapping
Entry.__elasticsearch__.client.indices.create \
  index: Entry.index_name,
  body: { settings: Entry.settings.to_hash, mappings: Entry.mappings.to_hash }

# Index all Entry records from the DB to Elasticsearch
Entry.import

