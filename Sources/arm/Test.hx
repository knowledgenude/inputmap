package arm;

class Test extends iron.Trait {

	var action1: InputAction;

	public function new() {
		super();

		notifyOnInit(function() {
			action1 = new InputAction();
			action1.addKeyboardInput("w", ["alt", "shift"]);
			action1.addKeyboardInput("up", ["alt"]);
			action1.addMouseInput("left");
		});

		notifyOnUpdate(function() {
			if (action1.pressed()) trace("action1");
		});
	}
}
