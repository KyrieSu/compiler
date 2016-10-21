#include <iostream>
#include <fstream>
#include <string>
using namespace std;

int main(int argc,char* argv[]){
    /* ./a.out filename1(argv[1]) filename2(argv[2]) */
    string s1,s2;
    ifstream o1(argv[1],ios::in);
    ifstream o2(argv[2],ios::in);
    if(!o1 || !o2){
        cout <<  "file can't be opened " << endl;
        return -1;
    }
    int line = 1;
    while(getline(o1,s1,'\n')){
        getline(o2,s2,'\n');
        if(s1.size()!=s2.size()){
            cout << "Line : " << line << endl << s1 << "\t" << s2 << endl;
        }
        line++;
    }
    o1.close();
    o2.close();
    return 0;
}
