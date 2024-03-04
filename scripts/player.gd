extends CharacterBody2D

@onready var name_label = $name
@onready var sprite = $sprite
var SPEED = 300.0
var JUMP_VELOCITY = -460

# Get the gravity from the project settings to be synced with RigidBody nodes.
#defailt gravity is 980
var gravity = 980
var coyote_timer = 0

func _ready():
    name_label.text = global.local_name
    sprite.self_modulate = global.local_color
    

func _physics_process(delta):
    # Add the gravity.
    if not is_on_floor():
        velocity.y += gravity * delta
        sprite.frame = 0
        coyote_timer += delta

    else:
        sprite.frame = 1
    
    print("c: " + str(coyote_timer))
    # Handle Jump.
    if Input.is_action_just_pressed("ui_accept") and is_on_floor() or Input.is_action_just_pressed("ui_accept") and coyote_timer >= 1:
        velocity.y = JUMP_VELOCITY
        coyote_timer = 0
        
    var direction = Input.get_axis("left", "right")
    if direction:
        velocity.x = direction * SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)

    move_and_slide()


    # This represents the player's inertia.
    var push_force = 2

    for i in get_slide_collision_count():
        var c = get_slide_collision(i)
        if c.get_collider() is RigidBody2D:
            c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
