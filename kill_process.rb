system("ps ux | awk '/sync/ && !/awk/ {print $2}' > a.txt")
file = File.new("a.txt", "r")
while (line = file.gets)
	puts line.inspect
	#system("kill -9 "+line.strip)
	Process.kill("KILL",line.strip.to_i)
end
