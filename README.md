This testcase demonstrates a situation where the MemorySanitizer does not respect the blacklist provided.

Given the `1.blacklist` file ignoring `main` I would expect no output and a zero return code from Memory Sanitizer.

Instead an error is displayed. To replicate install clang++ and run `make`.


```
export MSAN_OPTIONS=verbosity=3
make
./a.out 
==23370==MemorySanitizer: failed to intercept '__isoc99_printf'
==23370==MemorySanitizer: failed to intercept '__isoc99_sprintf'
==23370==MemorySanitizer: failed to intercept '__isoc99_snprintf'
==23370==MemorySanitizer: failed to intercept '__isoc99_fprintf'
==23370==MemorySanitizer: failed to intercept '__isoc99_vprintf'
==23370==MemorySanitizer: failed to intercept '__isoc99_vsprintf'
==23370==MemorySanitizer: failed to intercept '__isoc99_vsnprintf'
==23370==MemorySanitizer: failed to intercept '__isoc99_vfprintf'
__msan_init 0x00000043d970
app-1: 0 - ffffffffff
shadow-2: 10000000000 - fffffffffff
invalid: 100000000000 - 10ffffffffff
origin-2: 110000000000 - 1fffffffffff
shadow-3: 200000000000 - 2fffffffffff
origin-3: 300000000000 - 3fffffffffff
invalid: 400000000000 - 4fffffffffff
shadow-1: 500000000000 - 50ffffffffff
app-2: 510000000000 - 5fffffffffff
origin-1: 600000000000 - 60ffffffffff
invalid: 610000000000 - 6fffffffffff
app-3: 700000000000 - 7fffffffffff
==23370==Using llvm-symbolizer found at: /wagyu/mason_packages/linux-x86_64/llvm/3.9.0/bin//llvm-symbolizer
MemorySanitizer init done
==23370==WARNING: MemorySanitizer: use-of-uninitialized-value
    #0 0x52c91e in std::_Rb_tree<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, std::pair<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const, Catch::Ptr<Catch::IReporterFactory> >, std::_Select1st<std::pair<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const, Catch::Ptr<Catch::IReporterFactory> > >, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > >, std::allocator<std::pair<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const, Catch::Ptr<Catch::IReporterFactory> > > >::_M_get_insert_unique_pos(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&) (/msan-blacklist-testcase/a.out+0x52c91e)
    #1 0x52c407 in std::_Rb_tree<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, std::pair<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const, Catch::Ptr<Catch::IReporterFactory> >, std::_Select1st<std::pair<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const, Catch::Ptr<Catch::IReporterFactory> > >, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > >, std::allocator<std::pair<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const, Catch::Ptr<Catch::IReporterFactory> > > >::_M_insert_unique(std::pair<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const, Catch::Ptr<Catch::IReporterFactory> > const&) (/msan-blacklist-testcase/a.out+0x52c407)
    #2 0x52bd13 in std::map<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, Catch::Ptr<Catch::IReporterFactory>, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > >, std::allocator<std::pair<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const, Catch::Ptr<Catch::IReporterFactory> > > >::insert(std::pair<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const, Catch::Ptr<Catch::IReporterFactory> > const&) (/msan-blacklist-testcase/a.out+0x52bd13)
    #3 0x52b9c1 in Catch::ReporterRegistry::registerReporter(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, Catch::Ptr<Catch::IReporterFactory> const&) (/msan-blacklist-testcase/a.out+0x52b9c1)
    #4 0x4b6afb in Catch::(anonymous namespace)::RegistryHub::registerReporter(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, Catch::Ptr<Catch::IReporterFactory> const&) (/msan-blacklist-testcase/a.out+0x4b6afb)
    #5 0x4cb240 in Catch::ReporterRegistrar<Catch::JunitReporter>::ReporterRegistrar(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&) (/msan-blacklist-testcase/a.out+0x4cb240)
    #6 0x41e752 in __cxx_global_var_init.66 (/msan-blacklist-testcase/a.out+0x41e752)
    #7 0x41ee8c in _GLOBAL__sub_I_test.cc (/msan-blacklist-testcase/a.out+0x41ee8c)
    #8 0x62792c in __libc_csu_init (/msan-blacklist-testcase/a.out+0x62792c)
    #9 0x7f6e516837be in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x207be)
    #10 0x41eec8 in _start (/msan-blacklist-testcase/a.out+0x41eec8)

SUMMARY: MemorySanitizer: use-of-uninitialized-value (/msan-blacklist-testcase/a.out+0x52c91e) in std::_Rb_tree<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, std::pair<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const, Catch::Ptr<Catch::IReporterFactory> >, std::_Select1st<std::pair<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const, Catch::Ptr<Catch::IReporterFactory> > >, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > >, std::allocator<std::pair<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const, Catch::Ptr<Catch::IReporterFactory> > > >::_M_get_insert_unique_pos(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&)
Exiting
```