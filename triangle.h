#ifndef __TRIANGLE_H_
#define __TRIANGLE_H_

#include <iostream>
#include <stdlib.h>

class Triangle {
	public:
		void sayHelloWorld(){
			std::cout << "I Say Hello World!" << std::endl;
		}

        int TypeOfTriangle(int a, int b, int c) {
            if (a < 0 || b < 0 || c < 0) return -1;
            if (!(a + b > c && b + c > a && a + c > b))
                return 0;
            else if (a == b && b == c)
                return 1;
            else if (a == b || b == c || c == a)
                return 2;
            else
                return 3;            
        }

		
};


#endif

