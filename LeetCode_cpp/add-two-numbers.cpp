/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */
class Solution {
    public:
        ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {
            if (l1 == NULL || l2 == NULL) {
                return NULL;
            }

            int carry = 0;
            ListNode* output = new ListNode(0);
            ListNode* cur = output;

            while (true) {

                if (l1 != NULL) {
                    carry += l1->val;
                    l1 = l1->next;
                }

                if (l2 != NULL) {
                    carry += l2->val;
                    l2 = l2->next;
                }

                cur->val = carry % 10;
                carry /= 10;

                /* 'carry != 0' check for this exception
                 * 
                 *    [1,2,3,4,5]
                 * +  [9,8,8,8,8]
                 * ------------------
                 *    [0,1,2,3,4,1]
                 *               _
                 */
                if (l1 != NULL || l2 != NULL || carry != 0) {
                    cur = (cur->next = new ListNode(0));
                }
                else {
                    break;
                }
            }

            return output;
        }
};
