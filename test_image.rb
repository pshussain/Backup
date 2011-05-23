require 'RMagick'
anim = ImageList.new("start.gif", "middle.gif", "finish.gif")
anim.write("animated.gif")

