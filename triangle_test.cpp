#include "triangle.h"
#include <gtest/gtest.h>
namespace{
    TEST(Triangle, InvalideSides) {
        EXPECT_EQ(-1, TypeOfTriangle(-10, 20, 30));
        EXPECT_EQ(-1, TypeOfTriangle(10, -20, 30));
        EXPECT_EQ(-1, TypeOfTriangle(3, 4, -8));
    }
    TEST(TiangleTest, NonFormation){
        EXPECT_EQ(0, TypeOfTriangle(10, 20, 30));
        EXPECT_EQ(0, TypeOfTriangle(3, 4, 8));
    }
    TEST(TiangleTest, Equivalateral){
        EXPECT_EQ(1, TypeOfTriangle(10, 10, 10));
        EXPECT_EQ(1, TypeOfTriangle(5, 5, 5));
    }
    TEST(TiangleTest, Isosceles){
        EXPECT_EQ(2, TypeOfTriangle(10, 9, 15));
        EXPECT_EQ(2, TypeOfTriangle(15, 10, 10));
        EXPECT_EQ(2, TypeOfTriangle(10, 15, 10));
    }
    TEST(TiangleTest, Scalan){
        EXPECT_EQ(3, TypeOfTriangle(3, 4, 5));
        EXPECT_EQ(3, TypeOfTriangle(10, 12, 15));
        EXPECT_EQ(3, TypeOfTriangle(10, 25, 18));
    }
}   