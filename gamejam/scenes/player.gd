extends CharacterBody2D

const SPEED = 2000.0
const JUMP_VELOCITY = -6000.0
var current_inv = 0

var coin = 0

var is_near_well = false

var Inventory = [null,null,null]
var InventoryCapacity = 3
var currentarea
var is_watering = false

@onready var player: Sprite2D = $Sprite2D

@onready var timer_damage_cooldown: Timer = $TimerDamageCooldown

@onready var watering_can: Node2D = $WateringCan

@onready var WaterTimer: Timer = $WaterTimer

@onready var heart_1: TextureRect = $Ui/CanvasLayer/GridContainer3/Heart1

@onready var heart_2: TextureRect = $Ui/CanvasLayer/GridContainer3/Heart2

@onready var heart_3: TextureRect = $Ui/CanvasLayer/GridContainer3/Heart3

@onready var water_can: Sprite2D = $WateringCan/WaterCan

@onready var Item1T = $Item1Timer
@onready var Item2T = $Item2Timer
@onready var Item3T = $Item3Timer

var max_health = 3
var health = max_health
var can_take_damage = true

var touch_enemy = false

func _physics_process(delta: float) -> void:
	
	var direction := Input.get_axis("move_left", "move_right")
	
	if not is_on_floor():
		velocity += get_gravity()*10 * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Flip the sprite
	if direction > 0:
		player.flip_h = false
	elif direction < 0:
		player.flip_h = true
	
	if player.flip_h == false:
		$WateringCan.position.x=400
		water_can.flip_h = false
	else:
		$WateringCan.position.x=-400
		water_can.flip_h = true
	
	if Input.is_action_just_pressed("watering") and not is_watering:
		if is_near_well:
			watering_can.refill()
		elif watering_can.current > 0:
			watering_can.use()
			is_watering = true
			WaterTimer.start()


	
	if Input.is_action_just_pressed("Inventory1"):
		current_inv = 0
	if Input.is_action_just_pressed("Inventory2"):
		current_inv = 1
	if Input.is_action_just_pressed("Inventory3"):
		current_inv = 2
	if Input.is_action_just_pressed("UseItem"):
		if Inventory[current_inv] != null:
			var item = Inventory[current_inv].instantiate()
			var instance = item.spawn.instantiate()
			instance.position = self.global_position
			if direction > 0:
				instance.position.x -= 800
			else:
				instance.position.x += 800
			get_parent().add_child(instance)
			Inventory[current_inv] = null
	if Input.is_action_just_pressed("Interact"):
		collect(currentarea)
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
	
func collect(area):
	if area.Watered == true:
		for i in range(0,InventoryCapacity):
			if Inventory[i] == null:
				Inventory[i] = area.Collection
				area.Watered = false
				if i == 0:
					Item1T.start(area.rotTimer)
				elif i == 1:
					Item2T.start(area.rotTimer)
				elif i == 2:
					Item3T.start(area.rotTimer)
				return

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Coin"):
		coin = coin + 1
		print(coin)
		area.queue_free()
	elif area.is_in_group("Plant"):
		currentarea = area
	elif area.is_in_group("Enemy"):
		touch_enemy = true
	elif area.is_in_group("Baloon"):
		velocity.y = JUMP_VELOCITY
		area.get_parent().queue_free()
	elif area.is_in_group("Well"):
		is_near_well = true
		

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
	elif area.is_in_group("Plant"):
		currentarea = null
	elif area.is_in_group("Well"):
		is_near_well = false

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

func _on_item_1_timer_timeout() -> void:
	Inventory[0] = null

func _on_item_2_timer_timeout() -> void:
	Inventory[1] = null

func _on_item_3_timer_timeout() -> void:
	Inventory[2] = null
