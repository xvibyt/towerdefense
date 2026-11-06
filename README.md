# towerdefense
A Tower Defense-style game template.
It currently does NOT feature anything beyond placing paths and making a sprite follow it, I took my time here.

How?
Everything is scripted in GDScript inside of Godot.
It has a system for building automatically connecting paths, and choosing the correct route automatically from start to finish:
- Placed paths connect with each other texture-wise when placed near each other.
- Finds the correct way from start to finish on user-input if there is a way. Ignores dead-ends and handles loops.

Why?
I will use this system for game ideas I have, which are closely related to the Tower Defense genre. I want to make these ideas come to life someday, and this is my first step.

You can try this system right now on itch.io:
https://xvibyt.itch.io/towerdefense

Or download the Windows or Linux (no arm64) executable located at:
-  Releases on Github
-  also itch: https://xvibyt.itch.io/towerdefense

The whole Godot project is in the folder called "towerdefense" here on Github.


# Controls:

1. SPAWN: Press spawn/despawn to start. This makes two path starting-points appear: One at the top and one at the bottom.

2. CREATE: Draw your path from one end to the other by clicking with the left mouse button. There is an invisible boundary, so make sure to click in the general area between the start-path and end-path.

3. FOLLOW: Press "s" on your keyboard to let a little Godot svg follow your path from start to finish if your built path is connects the start-path and end-path. Dead-ends are fine, but there has to be a way leading from start to finish.

# Problems:

# How to restart: Press the spawn/despawn button to make the start-path and end-path disappear (besides the Godot svg, oops) ​and press again to make them reappear. Start with step 1 after this.

Pressing "s" before the start-path and end-path are connected breaks the game and you have to restart as shown above.

If any other problems arise, restart as shown above.

<img width="333" height="254" alt="towerdefense2" src="https://github.com/user-attachments/assets/ce6ef3e1-2780-43ff-899c-daccf31c6fd0" />
