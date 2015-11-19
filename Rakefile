require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = "test/*_test.rb"
end

task :default => [:test]

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

  # all
  Benchmark.ips do |x|
    x.time = 5
    x.warmup = 2

    x.report("::all") do |times|
      i = 0
      while i < times
        Usernamegen.all
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

    x.compare!
  end ; puts

  # all_for_thing
  Benchmark.ips do |x|
    x.time = 5
    x.warmup = 2

    x.report("::all_for_thing") do |times|
      i = 0
      while i < times
        Usernamegen.all_for_thing("foo")
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

    x.compare!
  end ; puts

  # all_for_desc
  Benchmark.ips do |x|
    x.time = 5
    x.warmup = 2

    x.report("::all_for_desc") do |times|
      i = 0
      while i < times
        Usernamegen.all_for_desc("bar")
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
