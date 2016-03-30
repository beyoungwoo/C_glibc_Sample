#include "FUNC.h"

char* gstrstr(char *s, char *find)
{
    char c, sc;
    int len;

    if ((c = * find ++) != 0)
    {
        len = strlen (find);
        do
        {
            do
            {
                if ((sc = * s ++) == 0) return (NULL);
            }
            while (sc != c);
        }
        while (strncmp (s, find, len) != 0);
        s --;
    }
    return ((char *) s);
}

// reverse strstr
char* strrstr(const char *haystack, const char *needle)
{
    char *r = NULL;

    if (!needle[0])
        return (char*)haystack + strlen(haystack);
    while (1) {
        char *p = strstr(haystack, needle);
        if (!p)
            return r;
        r = p;
        haystack = p + 1;
    }
}
