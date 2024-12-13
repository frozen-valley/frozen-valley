extends VBoxContainer


func _on_stargazing_tutorial_set_completion(group: int, star: int) -> void:
	
	if group == 0:
		$Label.modulate = Color.WHITE
		$Label.text = "- Find all Cassiopeia stars (" + str(star) + "/5)"
	else:
		$Label.modulate = Color(1, 1, 0.5, 0.5)
		$Label.text = "- Find all Cassiopeia stars (5/5)"
		
		if group == 1:
			$Label2.modulate = Color.WHITE
			$Label2.text = "- Find all Little Dipper stars (" + str(star) + "/7)"
		else:
			$Label2.modulate = Color(1, 1, 0.5, 0.5)
			$Label2.text = "- Find all Little Dipper stars (7/7)"
			
			if group == 2:
				$Label3.modulate = Color.WHITE
				$Label3.text = "- Find all Big Dipper stars (" + str(star) + "/7)"
			else:
				$Label3.modulate = Color(1, 1, 0.5, 0.5)
				$Label3.text = "- Find all Big Dipper stars (7/7)"
				
				if group == 3:
					$Label4.modulate = Color.WHITE
					$Label4.text = "- Find the North Star"
				else:
					$Label4.modulate = Color(1, 1, 0.5, 0.5)
					$Label4.text = "- Find the North Star"
					
