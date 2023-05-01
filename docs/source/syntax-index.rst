Syntax Index
============

Contains all of the syntax/keywords of NicePotatoScript (NPS)

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

NPS uses a class-like system for many things. A big example is the ``Sprite`` class.



Operators
=========

``include`` - Include a library
-------------------------------

``include`` can be used to include a builtin library or file

``on fire`` - Similar to recieving a broadcast
-----------------------------------------

``fire`` will activate, or fire, a trigger which can be picked up by ``on``


``on`` takes one argument, which is a trigger or a string
.. code-block::
    on <TRIGGER> {
        // do stuff
    }

An example usage would be with ``trigger.flag``, a trigger that fires when the green flag is pressed
Note: You may instead want to use ``trigger.init`` which is a synchronous version of ``trigger.flag`` (``trigger.init`` will be fired before anything else in the project runs)
.. code-block::
    trigger = include Trigger

    on trigger.flag {
        // do stuff after green flag pressed
    }

Similar to how functions are defined in lua, you can define an ``on`` anywhere in the script, and it can be triggered before or after its declaration.

``wait`` - Wait for x seconds
-----------------------------

``wait`` works exactly like in Scratch. Takes one argument, the wait time in seconds.
.. code-block::
    wait(1) // waits 1 second
    wait(0.1) // waits 0.1 second (WARNING: just like in Scratch, too low of values may not work as expected!)

``if else elseif``
------------------

``switch-case`` - Similar to C/C++'s switch-case
------------------------------------------------

``switch`` and ``case`` are two independent instructions. They can be used like many ifelses, but it is a lot neater.
.. code-block::
    var = "Example"
    switch var { // Also works with any literal declaration (e.g. switch "String")
        case "Example" { // Run code in {} if var == "Example"
            // var == "Example" so run code
        }
        case "Never" {
            // var != "Never" so do not run this code
        }
        case { // If switch matches no case, run this code
            // Code
        }
    }

Variables can also be used as a ``case``
.. code-block::
    var = "Example"
    match = "Example"
    nomatch = "Never"
    switch var {
        case match {
            // Code here will run, var == match ("Example" == "Example")
        }
        case nomatch {
            // Code here will never run, var != nomatch ("Example" != "Never")
        }
    }

You cannot have multiple of the same cases as it compiles into many ifelse blocks on Scratch

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

``init`` - triggers once on startup. Runs synchronously
``flag`` - fires whenever green flag is clicked
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
``tick`` - fires every frame (NPS handles this for you)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

