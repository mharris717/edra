require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Association" do
  
  describe 'simple association' do
    let(:assoc) do
      EDRA::Association.new(:name => "author", :type => "belongsTo")
    end
  
    it 'to_ember' do
      assoc.to_ember.should == "author: DS.belongsTo('App.Author')"
    end
  end
  
  describe 'other name association' do
    let(:assoc) do
      EDRA::Association.new(:name => "Author", :type => "Belongs_to")
    end
  
    it 'to_ember' do
      assoc.to_ember.should == "author: DS.belongsTo('App.Author')"
    end
  end
  
  describe "ember type" do
    types = {}
    types['belongsTo'] = %w(belongsTo BelongsTo belongs_to) + [:belongs_to]
    types['hasMany'] = %w(hasMany HasMany has_many)
    
    types.each do |ember_type,raw_types|
      raw_types.each do |raw_type|
        it "ember_type of #{raw_type}" do
          EDRA::Association.new(:type => raw_type).ember_type.should == ember_type
        end
      end
    end
  end
  
  
end
