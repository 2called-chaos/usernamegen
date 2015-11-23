require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = "test/*_test.rb"
end

task :default => [:test]

desc "Gives you 10 random names (5 with default/5 with custom format)"
task :example do
  require 'usernamegen'
  instance = Usernamegen.new
  5.times { puts instance.one }
  instance = Usernamegen.new {|a| a.join("-").downcase }
  puts instance.some(5)
end

desc "Gives you ALL names"
task :all_names do
  require 'usernamegen'
  Usernamegen.new.all.each{|n| puts n }
end

desc "Run performance benchmarks with benchmark-ips tests"
task :benchmark do
  require 'usernamegen'
  require 'benchmark'
  require 'benchmark/ips'

  # initial load
  instance = nil
  Benchmark.benchmark do |x|
    x.report("initial load") { instance = Usernamegen.new }
  end

  # misc
  Benchmark.ips do |x|
    x.time = 5
    x.warmup = 2

    # loading files (cached since we loaded already once)
    x.report("::new") do |times|
      i = 0
      while i < times
        Usernamegen.new
        i += 1
      end
    end
  end ; puts

  # one
  Benchmark.ips do |x|
    x.time = 5
    x.warmup = 2

    x.report("::one") do |times|
      i = 0
      while i < times
        Usernamegen.one
        i += 1
      end
    end

    x.report("#one") do |times|
      i = 0
      while i < times
        instance.one
        i += 1
      end
    end

    x.compare!
  end ; puts

  # instance compare
  Benchmark.ips do |x|
    x.time = 5
    x.warmup = 2

    x.report("#one") do |times|
      i = 0
      while i < times
        instance.one
        i += 1
      end
    end

    x.report("#some(1)") do |times|
      i = 0
      while i < times
        instance.some(1)
        i += 1
      end
    end

    x.report("#some(10)") do |times|
      i = 0
      while i < times
        instance.some(10)
        i += 1
      end
    end

    x.report("#all") do |times|
      i = 0
      while i < times
        instance.all
        i += 1
      end
    end

    x.report("#all_for_thing") do |times|
      i = 0
      while i < times
        instance.all_for_thing("foo")
        i += 1
      end
    end

    x.report("#all_for_desc") do |times|
      i = 0
      while i < times
        instance.all_for_desc("bar")
        i += 1
      end
    end

    x.compare!
  end ; puts
end


desc "test benchmark (for while developing)"
task :testbench do
  require 'usernamegen'
  require 'benchmark'
  require 'benchmark/ips'

  # initial load
  Benchmark.ips do |x|
    x.time = 5
    x.warmup = 2
    instance = Usernamegen.new

    x.report("#one") do |times|
      i = 0
      while i < times
        instance.one
        i += 1
      end
    end

    x.report("#some(1)") do |times|
      i = 0
      while i < times
        instance.some(1)
        i += 1
      end
    end

    x.report("#some(10)") do |times|
      i = 0
      while i < times
        instance.some(10)
        i += 1
      end
    end

    x.compare!
  end ; puts
end


desc "test benchmark (for while developing)"
task :testbench do
  require 'usernamegen'
  require 'benchmark'
  require 'benchmark/ips'

  # initial load
  instance = nil
  Benchmark.benchmark do |x|
    x.report("initial load") { instance = Usernamegen.new }
  end

  Benchmark.ips do |x|
    x.time = 5
    x.warmup = 2

    x.report("???") do |times|
      i = 0
      while i < times
        ###
        i += 1
      end
    end

    x.compare!
  end
end
