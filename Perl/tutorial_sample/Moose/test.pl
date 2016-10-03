#!/usr/bin/perl

package Foo;
use Moose;

has 'message' => (
    is      => 'rw',
    isa     => 'Str',
    default => 'Hello, I am a Foo'
);

package My::Foo;
use Moose;

extends 'Foo';

has '+message' => (default => 'Hello I am My::Foo');
