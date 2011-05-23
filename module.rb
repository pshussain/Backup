class Module
  def f(name)
    b = ("_" + name.to_s).to_sym
    alias_method b, name
    define_method(name) do |*args|
      @mc ||= {}
      @mc[name] ||= {}
      @mc[name][args] ||= self.send b, *args
    end
  end
end

m=Module.new
m.f("name".length)