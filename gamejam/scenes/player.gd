extends CharacterBody2D

const SPEED = 2000.0
const JUMP_VELOCITY = -4000.0
var current_inv = 0

var coin = 0

var Inventory = [null,null,null,null,null]
var InventoryCapacity = 5

var is_watering = false

@onready var player: Sprite2D = $Sprite2D

@onready var timer_damage_cooldown: Timer = $TimerDamageCooldown

@onready var watering_can: Node2D = $WateringCan

@onready var WaterTimer: Timer = $Timer

@onready var heart_1: TextureRect = $Ui/CanvasLayer/GridContainer3/Heart1

@onready var heart_2: TextureRect = $Ui/CanvasLayer/GridContainer3/Heart2

@onready var heart_3: TextureRect = $Ui/CanvasLayer/GridContainer3/Heart3

var max_health = 3
var health = max_health
var can_take_damage = true

var touch_enemy = false

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("watering") and not is_watering:
		watering_can.use()
	if Input.is_action_just_pressed("UseItem"):
		Inventory[current_inv].use()
		print("a")
	
	if not is_on_floor():
		velocity += get_gravity()*10 * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the sprite
	if direction > 0:
		player.flip_h = false
	elif direction < 0:
		player.flip_h = true
	
	# Play animations
	#if is_on_floor():
		#if direction == 0:
			#animated_sprite.play("idle")
		#else:
			#animated_sprite.play("run")
	#else:
		#animated_sprite.play("jump")
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	
	if touch_enemy == true:
		take_damage(1)
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Coin"):
		coin = coin + 1
		print(coin)
		area.queue_free()
	elif area.is_in_group("Plant"):
		if area.Watered == true:
			for i in range(0,InventoryCapacity):
				if Inventory[i] == null:
					Inventory[i] = area.Collection
					area.Watered = false
					return
	elif area.is_in_group("Enemy"):
		touch_enemy = true

func take_damage(amount):
	if can_take_damage:
		health -= amount
		can_take_damage = false
		update_hearts()
		print("Player hit! Health:", health)
		$TimerDamageCooldown.start()  # Timer node, 2 saniyelik cooldown için
		if health <= 0:
			die()

func die():
	print("Player died")
	# Buraya ölüm animasyonu, reset veya game over kodu

func _on_timer_timeout() -> void:
	is_watering = false
	watering_can.visible = false

func _on_timer_damage_cooldown_timeout() -> void:
	can_take_damage = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		touch_enemy = false 

func update_hearts():
	if  health == 3:
		heart_1.visible = true
		heart_2.visible = true
		heart_3.visible = true
	elif health == 2:
		heart_1.visible = false
		heart_2.visible = true
		heart_3.visible = true
	elif health == 1:
		heart_1.visible = false
		heart_2.visible = false
		heart_3.visible = true
	elif health <= 0:
		heart_1.visible = false
		heart_2.visible = false
		heart_3.visible = false
