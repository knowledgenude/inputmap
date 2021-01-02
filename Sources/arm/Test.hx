package arm;

import iron.object.Object;
import arm.inputmap.InputMap;
import armory.trait.physics.RigidBody;

class Test extends iron.Trait {

	var rb: RigidBody;

	var input: InputMap;

	public function new() {
		super();

		notifyOnInit(function() {
			rb = object.getTrait(RigidBody);

			input = new InputMap(0);

			input.createAction("action1");
			input.getAction("action1").addKeyboardComponent("Keyboard", "w", ["control"]);
			input.getAction("action1").addKeyboardComponent("Keyboard", "up");
			input.getAction("action1").addMouseComponent("Keyboard", "left");
	
			input.createAxis("move");
			input.getAxis("move").addKeyboardComponent("y", "Keyboard", "w", "s");
			input.getAxis("move").addKeyboardComponent("x", "Keyboard", "d", "a");

			input.getAxis("move").addMouseComponent("x", "Keyboard", "right", "left");

			input.getAxis("move").setScale(5.0, 5.0);
			input.getAxis("move").enableNormalize();

			input.setCurrentTag("Keyboard");
		});

		notifyOnUpdate(function() {
			if (input.isActionReleased("action1")) trace("action1");

			var moveVec = input.getVec("move");
			rb.setLinearVelocity(moveVec.x, moveVec.y, moveVec.z);
		});
	}
}