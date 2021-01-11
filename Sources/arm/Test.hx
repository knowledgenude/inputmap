package arm;

import libraries.InputMap;

class Test extends iron.Trait {
	var input = new InputMap();

	public function new() {
		super();

		notifyOnInit(function() {
			var action1 = input.addAction("action1");
			action1.addKeyboard("space", null, null, "SPACE");
			action1.addKeyboard("w", null, null, "W KEY");
			trace(action1.getDisplay(""));
		});

		notifyOnUpdate(function() {
			if (input.started("action1")) trace("action pressed!");
		});
	}
}
