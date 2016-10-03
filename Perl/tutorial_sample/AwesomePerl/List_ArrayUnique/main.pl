#!/usr/bin/perl

use Array::Unique;

tie @a, 'Array::Unique';

Now use @a as a regular array.
