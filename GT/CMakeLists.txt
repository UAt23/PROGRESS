include_directories(${PROJECT_SOURCE_DIR}/gtest/include)
include_directories(${PROJECT_SOURCE_DIR}/
gtest/)
add_library(gtest src/gtest-all.cc)
add_library(gtest_main src/gtest_main.cc)
target_link_libraries(gtest_main gtest)
