extends CharacterBody2D

const constspeed = 3000.0
var SPEED = 3000.0
const JUMP_VELOCITY = -6000.0
var current_inv = 0
var jumpAvailable = false
var TeleportLocations:Array = []
var LastTeleport = 0
var UsingTeleport = 0
var fly = false
var BuyingItem

var coin = 15

var is_near_well = false

var Inventory = [null,null,null]
var InventoryCapacity = 3
var currentarea
var is_watering = false

@onready var player: AnimatedSprite2D = $Sprite2D

@onready var timer_damage_cooldown: Timer = $TimerDamageCooldown

@onready var watering_can: Node2D = $WateringCan

@onready var Coyote = $CoyoteTime
@onready var WaterTimer: Timer = $WaterTimer

@onready var heart_1: TextureRect = $Ui/CanvasLayer/GridContainer3/Heart1
@onready var heart_2: TextureRect = $Ui/CanvasLayer/GridContainer3/Heart2
@onready var heart_3: TextureRect = $Ui/CanvasLayer/GridContainer3/Heart3

@onready var drop_1: TextureRect = $Ui/CanvasLayer/GridContainer5/Drop1
@onready var drop_2: TextureRect = $Ui/CanvasLayer/GridContainer5/Drop2
@onready var drop_3: TextureRect = $Ui/CanvasLayer/GridContainer5/Drop3


@onready var water_can: Sprite2D = $WateringCan/WaterCan

@onready var Item1T = $Item1Timer
@onready var Item2T = $Item2Timer
@onready var Item3T = $Item3Timer

var max_health = 3
var health = max_health
var can_take_damage = true

var touch_enemy = false

func _ready():
	TeleportLocations.insert(0,global_position)
	

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	
	if not is_on_floor() and !fly:
		if Coyote.time_left <= 0:
			Coyote.start()
		velocity += get_gravity()*10 * delta
	
	if fly == true:
		velocity.y = 0
		jumpAvailable = false
		position.y -= 20
		SPEED = constspeed/2
	
	if is_on_floor():
		jumpAvailable = true
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and jumpAvailable:
		velocity.y = JUMP_VELOCITY
		jumpAvailable = false
	
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
			update_drops()
		elif watering_can.current > 0:
			watering_can.use()
			update_drops()
			is_watering = true
			WaterTimer.start()
	
	if current_inv < 0:
		current_inv = 2
	elif current_inv > 2:
		current_inv = 0
	
	if Input.is_action_just_pressed("Inventory1"):
		current_inv = 0
	if Input.is_action_just_pressed("Inventory2"):
		current_inv = 1
	if Input.is_action_just_pressed("Inventory3"):
		current_inv = 2
	if Input.is_action_just_pressed("InventoryScrollUp"):
		current_inv += 1
	if Input.is_action_just_pressed("InventoryScrollDown"):
		current_inv -= 1
	if Input.is_action_just_pressed("UseItem"):
		if Inventory[current_inv] != null:
			if current_inv == 0:
				Item1T.stop()
			elif current_inv == 1:
				Item2T.stop()
			elif current_inv == 2:
				Item3T.stop()
			var item = Inventory[current_inv].instantiate()
			var instance = item.spawn.instantiate()
			instance.position = self.global_position
			if player.flip_h == true:
				instance.position.x -= item.distance
				instance.side = true
			else:
				instance.position.x += item.distance
				instance.side = false
			get_parent().add_child(instance)
			Inventory[current_inv] = null
	if Input.is_action_just_pressed("Interact"):
		if currentarea != null:
			if currentarea.Watered == true:
				collect(currentarea)
				var place = true
				for i in range(0,LastTeleport):
					if currentarea.global_position == TeleportLocations[i]:
						place = false
				if place == true:
					LastTeleport += 1
					TeleportLocations.insert(LastTeleport,currentarea.global_position)
					UsingTeleport = LastTeleport
		if BuyingItem != null:
			if coin >= BuyingItem.Price:
				coin -= BuyingItem.Price
				collect(BuyingItem)
	if Input.is_action_just_pressed("GoBack"):
		global_position = TeleportLocations[UsingTeleport]
		if UsingTeleport > 0:
			UsingTeleport -= 1
		$GoBackResetTimer.start()
			
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			player.play("idle")
		else:
			player.play("walk")
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
		area.queue_free()
	elif area.is_in_group("Plant"):
		currentarea = area
	elif area.is_in_group("Enemy"):
		touch_enemy = true
		velocity = -velocity
	elif area.is_in_group("Baloon"):
		fly = true
		$FlyTimer.start()
	elif area.is_in_group("Trampoline"):
		if area.get_parent().prepared == true:
			velocity.y = JUMP_VELOCITY*2
			area.get_parent().queue_free()
	elif area.is_in_group("Well"):
		is_near_well = true
	elif area.is_in_group("FallBlock"):
		area.get_parent().fall()
	elif area.is_in_group("Buy"):
		BuyingItem = area

func take_damage(amount):
	if can_take_damage:
		health -= amount
		can_take_damage = false
		update_hearts()
		$TimerDamageCooldown.start()
		if health <= 0:
			die()

func die():
	UsingTeleport = LastTeleport
	global_position = TeleportLocations[LastTeleport]
	health = max_health
	update_hearts()

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

func update_drops():
	if  $WateringCan.current == 3:
		drop_1.visible = true
		drop_2.visible = true
		drop_3.visible = true
	elif $WateringCan.current == 2:
		drop_1.visible = false
		drop_2.visible = true
		drop_3.visible = true
	elif $WateringCan.current == 1:
		drop_1.visible = false
		drop_2.visible = false
		drop_3.visible = true
	elif $WateringCan.current <= 0:
		drop_1.visible = false
		drop_2.visible = false
		drop_3.visible = false
		

func _on_coyote_time_timeout() -> void:
	jumpAvailable = false


func _on_go_back_reset_timer_timeout() -> void:
	UsingTeleport = LastTeleport


func _on_fly_timer_timeout() -> void:
	fly = false
	SPEED = constspeed
