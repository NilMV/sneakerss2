require 'rails_helper'

RSpec.describe Entry, type: :model do
  subject { described_class.new }

  it "is valid with attributes" do
    subject.title = 'TestTitle'
    subject.published = Date.current
    subject.content = "some content"
    subject.url = 'Test.url'
    subject.author = "SomeOne"
    expect(subject).to be_valid
  end  
end