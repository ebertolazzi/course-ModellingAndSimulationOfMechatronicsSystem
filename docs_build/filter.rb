require 'fileutils'

index='./sphinx/_build/html/genindex.html'
system("sed -i .bak 's/(C\+\+ class)/(class)/g' #{index}");
system("sed -i .bak 's/(C\+\+ function)/(function)/g' #{index}");
FileUtils.rm "#{index}.bak"

to_be_removed  = '<span class="pre">in<\/span> *<em><span class="pre">self<\/span><\/em>,*'
to_be_removed2 = '<span class="pre">(in<\/span> *<span class="pre">self)<\/span>'
to_be_removed0 = ' *<span class="pre">in<\/span> *'
to_be_removed1 = '<em><span class="pre">self<\/span><\/em>,* *'
to_be_removed2 = '<span class="pre">self)<\/span>'
to_be_removed3 = '<span class="pre">(in<\/span> *)'

subs3 = '<span class="sig-paren">()<\/span>'

Dir.glob("./sphinx/_build/html/api/*.html").each do |f|
  system("sed -i .bak 's/#{to_be_removed0}//g' #{f}");
  system("sed -i .bak 's/#{to_be_removed1}//g' #{f}");
  system("sed -i .bak 's/#{to_be_removed2}/)/g' #{f}");
  system("sed -i .bak 's/#{to_be_removed3}/#{subs3}/g' #{f}");
  FileUtils.rm "#{f}.bak"
end
