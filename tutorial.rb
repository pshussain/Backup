module Tutorial
  class Person < ::Protobuf::Message
    required :string, :name, 1
    required :int32, :id, 2
    optional :string, :email, 3
  end
end