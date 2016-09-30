#include <iostream>
#include <cstring>
#include <vector>
#include <map>

using std::vector;
using std::map;

class Solution {
    public:
        vector<int> twoSum(vector<int> &nums, int target) {  
            map<int, int> mapping;  
            vector<int> result;  

            for (int i =0; i< nums.size(); i++)  
            {  
                mapping[nums[i]]=i;  
            }

            for (int i =0; i< nums.size(); i++)  
            {  
                int searched = target - nums[i];  
                if (mapping.find(searched) != mapping.end())  
                {
                    result.push_back(i);  
                    result.push_back(mapping[searched]);  
                    break;  
                }  
            }  
            return result;  
        }  
};

int main() {

    Solution *so;
     
    std::vector<int> nums = {2,3,7,9};
    int target = 11;

    vector<int> ret;
    ret = so->twoSum(nums, target);

    for(int n : ret) {
        std::cout << n << '\n';
    }

    return 0;
}

