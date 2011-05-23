class String

    require 'iconv' 
    require 'open-uri'
    
    UTF8REGEX = /\A(?:                               # ?: non-capturing group (grouping with no back references)
                 [\x09\x0A\x0D\x20-\x7E]            # ASCII
               | [\xC2-\xDF][\x80-\xBF]             # non-overlong 2-byte
               |  \xE0[\xA0-\xBF][\x80-\xBF]        # excluding overlongs
               | [\xE1-\xEC\xEE\xEF][\x80-\xBF]{2}  # straight 3-byte
               |  \xED[\x80-\x9F][\x80-\xBF]        # excluding surrogates
               |  \xF0[\x90-\xBF][\x80-\xBF]{2}     # planes 1-3
               | [\xF1-\xF3][\x80-\xBF]{3}          # planes 4-15
               |  \xF4[\x80-\x8F][\x80-\xBF]{2}     # plane 16
               )*\z/mnx

    
    
    def utf8?
     self =~ UTF8REGEX
   end


    def unicode_to_utf8
      return self if self =~ /\A[[:space:]]*\z/m
      str = ""
      #scan(/U\+([0-9a-fA-F]{4,5}|10[0-9a-fA-F]{4})/) { |u| str << [u.first.hex].pack("U*") }
      #scan(/U\+([[:digit:][:xdigit:]]{4,5}|10[[:digit:][:xdigit:]]{4})/) { |u| str << [u.first.hex].pack("U*") }
      scan(/(U\+(?:[[:digit:][:xdigit:]]{4,5}|10[[:digit:][:xdigit:]]{4})|.)/mu) do        # for mixed strings such as "U+00bfHabla espaU+00f1ol?"
         c = $1
         if c =~ /^U\+/
            str << [c[2..-1].hex].pack("U*")
         else
            str << c
         end       
      end
      str.utf8? ? str : nil
   end

    
     def utf16le_to_utf8
       ret = Iconv.iconv('UTF-8//IGNORE', 'UTF-16LE', (self[0,(self.length/2*2)] + "\000\000") ).first[0..-2]
       ret =~ /\x00\z/ ?  ret.sub!(/\x00\z/, '') : ret
       ret.utf8? ? ret : nil
      end

    
    def utf8_to_unicode
      return nil unless self.utf8?
      str = ""
      scan(/./mu) { |c| str << "U+" << sprintf("%04X", c.unpack("U*").first) }
      str
   end
   un="Hello, world!".utf8_to_unicode
   p un
   puts un.unicode_to_utf8


    str_in_utf16le = "c\000a\000f\000\351\000"
    
    a="c\0097"
    
    puts str_in_utf16le.utf16le_to_utf8




end