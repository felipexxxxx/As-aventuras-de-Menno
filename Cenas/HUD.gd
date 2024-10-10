extends CanvasLayer

func _on_HUD_script_changed():
	if Global.life == 4:
		$vidaperdida1.hide()
		$vidaperdida2.hide()
		$vidaperdida3.hide()
		$vidaperdida4.hide()
		
	if Global.life == 3:
		$vidaperdida1.hide()
		$vidaperdida2.hide()
		$vidaperdida3.hide()
		$vida4.hide()
		$vidaperdida4.show()
		
	if Global.life == 2:
		$vidaperdida1.hide()
		$vidaperdida2.hide()
		$vida3.hide()
		$vidaperdida3.show()
		$vida4.hide()
		$vidaperdida4.show()
		
	if Global.life == 1:
		$vidaperdida1.hide()
		$vida2.hide()
		$vidaperdida2.show()
		$vida3.hide()
		$vidaperdida3.show()
		$vida4.hide()
		$vidaperdida4.show()
