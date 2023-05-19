extends Enemy

func attack():
	super()
	weapon.rotation = get_angle_to(player.position)
	weapon.start_attack()
