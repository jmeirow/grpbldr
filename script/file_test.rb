filename='/tmp/foo'
File.open(filename)
filehandle = File.open(filename)

# List all open File objects.
ObjectSpace.each_object(File) do |f|
  puts "%s: %d" % [f.path, f.fileno] unless f.closed?
end

# List the "dangling" File object which we didn't store in a variable.
ObjectSpace.each_object(File) do |f|
  unless f.closed?  
    printf "%s: %d\n", f.path, f.fileno unless f === filehandle
  end
end

# Close any dangling File objects. Ignore already-closed files, and leave
# the "accessible" object stored in *filehandle* alone.
ObjectSpace.each_object(File) {|f| f.close unless f === filehandle rescue nil}