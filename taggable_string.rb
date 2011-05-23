require 'set' 

class TaggableString < String
	  include Taggable
	  def initialize(*args)
	    super
	    taggable_setup
	  end
    def tell
        test
    end
	end
module Taggable
	  attr_accessor :tags

	  def taggable_setup
	    @tags = Set.new
	  end

	  def add_tag(tag)
	    @tags << tag
	  end

	  def remove_tag(tag)
	    @tags.delete(tag)
	  end
    def test
        "Test"
    end
	end
s = TaggableString.new('It was the best of times, it was the worst of times.')
	s.add_tag 'dickens'
	s.add_tag 'quotation'
	puts s.tell