if(EXISTS "/mnt/d/WORK/WORK-LOG/build/hello_test[1]_tests.cmake")
  include("/mnt/d/WORK/WORK-LOG/build/hello_test[1]_tests.cmake")
else()
  add_test(hello_test_NOT_BUILT hello_test_NOT_BUILT)
endif()