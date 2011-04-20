# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ludy}
  s.version = "0.1.15"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Lin Jen-Shin (godfat)"]
  s.date = %q{2011-04-20}
  s.description = %q{Aims to extend Ruby standard library, providing some useful tools that's not existed in the standard library, especially for functional programming.}
  s.email = ["godfat (XD) godfat.org"]
  s.executables = ["ludy"]
  s.extra_rdoc_files = ["CHANGES", "LICENSE", "TODO"]
  s.files = [".gitignore", "CHANGES", "LICENSE", "NOTICE", "README", "Rakefile", "TODO", "bin/ludy", "lib/ludy.rb", "lib/ludy/all.rb", "lib/ludy/array.rb", "lib/ludy/array/body.rb", "lib/ludy/array/choice.rb", "lib/ludy/array/combine.rb", "lib/ludy/array/combos.rb", "lib/ludy/array/count.rb", "lib/ludy/array/filter.rb", "lib/ludy/array/foldl.rb", "lib/ludy/array/foldr.rb", "lib/ludy/array/head.rb", "lib/ludy/array/map_with_index.rb", "lib/ludy/array/pad.rb", "lib/ludy/array/product.rb", "lib/ludy/array/rotate.rb", "lib/ludy/array/tail.rb", "lib/ludy/blackhole.rb", "lib/ludy/class.rb", "lib/ludy/class/undef_all_methods.rb", "lib/ludy/deprecated/aspect.rb", "lib/ludy/deprecated/callstack.rb", "lib/ludy/deprecated/curry.rb", "lib/ludy/deprecated/rambda.rb", "lib/ludy/deprecated/this.rb", "lib/ludy/deprecated/untranspose.rb", "lib/ludy/deprecated/unzip.rb", "lib/ludy/dices.rb", "lib/ludy/hash.rb", "lib/ludy/hash/reverse_merge.rb", "lib/ludy/helpers/check_box.rb", "lib/ludy/kernel.rb", "lib/ludy/kernel/deep_copy.rb", "lib/ludy/kernel/defun.rb", "lib/ludy/kernel/ergo.rb", "lib/ludy/kernel/id.rb", "lib/ludy/kernel/if_else.rb", "lib/ludy/kernel/m.rb", "lib/ludy/kernel/maybe.rb", "lib/ludy/kernel/public_send.rb", "lib/ludy/kernel/singleton_method.rb", "lib/ludy/kernel/tap.rb", "lib/ludy/lazy.rb", "lib/ludy/list.rb", "lib/ludy/message_dispatcher.rb", "lib/ludy/namespace.rb", "lib/ludy/paginator.rb", "lib/ludy/pattern_matcher.rb", "lib/ludy/proc.rb", "lib/ludy/proc/bind.rb", "lib/ludy/proc/chain.rb", "lib/ludy/proc/compose.rb", "lib/ludy/proc/curry.rb", "lib/ludy/symbol.rb", "lib/ludy/symbol/curry.rb", "lib/ludy/symbol/to_msg.rb", "lib/ludy/symbol/to_proc.rb", "lib/ludy/tasks.rb", "lib/ludy/tasks/common.rb", "lib/ludy/tasks/preprocess_cpp.rb", "lib/ludy/tasks/preprocess_cpp/attr_builder.rb", "lib/ludy/tasks/preprocess_cpp/debug_hook.rb", "lib/ludy/tasks/preprocess_cpp/header_guard.rb", "lib/ludy/tasks/preprocess_cpp/template_forward_parameters.rb", "lib/ludy/timer.rb", "lib/ludy/variable.rb", "lib/ludy/version.rb", "lib/ludy/y_combinator.rb", "lib/ludy/z_combinator.rb", "lib/puzzle_generator.rb", "lib/puzzle_generator/chain.rb", "lib/puzzle_generator/chained_map.rb", "lib/puzzle_generator/colored_map.rb", "lib/puzzle_generator/map.rb", "lib/puzzle_generator/misc.rb", "lib/puzzle_generator/puzzle.rb", "ludy.gemspec", "spec/ludy_spec.rb", "spec/spec_helper.rb", "task/gemgem.rb", "tasks/ann.rake", "tasks/bones.rake", "tasks/gem.rake", "tasks/git.rake", "tasks/manifest.rake", "tasks/notes.rake", "tasks/post_load.rake", "tasks/rdoc.rake", "tasks/rubyforge.rake", "tasks/setup.rb", "tasks/spec.rake", "tasks/svn.rake", "tasks/test.rake", "test/deprecated/callstack.rb", "test/deprecated/curry.rb", "test/deprecated/rambda.rb", "test/deprecated/this.rb", "test/deprecated/ts_ludy.rb", "test/deprecated/unzip_and_untranspose.rb", "test/example_puzzle.rb", "test/helper.rb", "test/ludy/test_array.rb", "test/ludy/test_class.rb", "test/ludy/test_defun.rb", "test/ludy/test_dices.rb", "test/ludy/test_hash.rb", "test/ludy/test_kernel.rb", "test/ludy/test_lazy.rb", "test/ludy/test_paginator.rb", "test/ludy/test_proc.rb", "test/ludy/test_require_all.rb", "test/ludy/test_symbol.rb", "test/ludy/test_variable.rb", "test/ludy/test_y_combinator.rb", "test/ludy/test_z_combinator.rb", "test/multiruby.sh"]
  s.homepage = %q{http://github.com/godfat/}
  s.rdoc_options = ["--main", "README"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.7.2}
  s.summary = %q{Aims to extend Ruby standard library, providing some useful tools that's not existed in the standard library, especially for functional programming.}
  s.test_files = ["test/ludy/test_array.rb", "test/ludy/test_class.rb", "test/ludy/test_defun.rb", "test/ludy/test_dices.rb", "test/ludy/test_hash.rb", "test/ludy/test_kernel.rb", "test/ludy/test_lazy.rb", "test/ludy/test_paginator.rb", "test/ludy/test_proc.rb", "test/ludy/test_require_all.rb", "test/ludy/test_symbol.rb", "test/ludy/test_variable.rb", "test/ludy/test_y_combinator.rb", "test/ludy/test_z_combinator.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
