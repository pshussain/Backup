class Account
    def calculate
        @calculate ||= begin
            sleep 10
            5
        end
    end
end

a=Account.new
p a.calculate
p a.calculate
p a.calculate
p a.calculate
p a.calculate