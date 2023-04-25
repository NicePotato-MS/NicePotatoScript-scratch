Syntax Index
============

Contains all of the syntax/keywords of PotatoScratchScript (PSS)

Basics
======

Comments are declared like C/C++ with ``//`` and ``/**/`` for multiline comments.
.. code-block::
    // This is a comment! The compiler will shave it off like it doesn't exist.

    /* This is a multiline comment!
    Here is still part of the comment
    */ NOT HERE! this end part will result in an error!

    /*You can also use this in one line!*/

Indentation is optional! Unlike a language like Python, you don't need to use a single tab anywhere.

Classes
-------

PSS uses a class-like system for many things. A big example is the ``Sprite`` class.



Operators
=========

``include`` - Include a library
-------------------------------

``include`` can be used to include a builtin library, or an external one

``on`` - Similar to recieving a broadcast
-----------------------------------------

``on`` takes one argument, which is a trigger
.. code-block::
    on <TRIGGER> {
        // do stuff
    }

An example usage would be with ``trigger.flag``, a trigger that fires when the green flag is pressed
.. code-block::
    trigger = include Trigger

    on trigger.flag {
        // do stuff after green flag pressed
    }

Using the on operator will allow be triggered no matter what!
Similar to function declaration in Lua, the on operator will trigger at any time.

``wait`` - Wait for x seconds
-----------------------------

``wait`` works exactly like in scratch



Sprite Library
==============

Variables
---------

``local`` - returns the local sprite
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Functions
---------

Classes
-------

``Sprite`` - Contains data of a sprite
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

``Sprite.x`` - X coordinate of a sprite

``Sprite.y`` - Y coordinate of a sprite

``Sprite.size`` - Size of a sprite

``Sprite.direction`` - Direction/Rotation of a sprite

``Sprite.volume`` - Volume of a sprite

``Sprite.costumeNumber`` - Costume number of a sprite

``Sprite.costumeName`` - Costume name of a sprite

Trigger Library
===============

Variables
---------

``flag`` - fires whenever green flag is clicked
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

