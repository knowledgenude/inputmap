package arm;

import iron.object.Object;
import arm.inputmap.InputMap;
import armory.trait.physics.RigidBody;

class Test extends iron.Trait {

	var rb: RigidBody;

	var playerOneInput: InputMap;

	public function new() {
		super();

		notifyOnInit(function() {
			rb = object.getTrait(RigidBody);

			playerOneInput = new InputMap(0);

			playerOneInput.createAction("action1");
			playerOneInput.getAction("action1").addKeyboardComponent("Keyboard", "w", ["control"]);
			playerOneInput.getAction("action1").addKeyboardComponent("Keyboard", "up");
			playerOneInput.getAction("action1").addMouseComponent("Keyboard", "left");
			//playerOneInput.setCurrentTag("Keyboard"); // This is automatically done for the first action/axis added

			playerOneInput.createAxis("move");
			playerOneInput.getAxis("move").addKeyboardComponent("y", "Keyboard", "w", "s");
			playerOneInput.getAxis("move").addKeyboardComponent("x", "Keyboard", "d", "a");
			playerOneInput.getAxis("move").setScale(5.0, 5.0, 5.0);
			playerOneInput.getAxis("move").setNormalize(true, true, false);
		});

		notifyOnUpdate(function() {
			if (playerOneInput.isActionReleased("action1")) trace("action1");

			var moveVec = playerOneInput.getVec("move");
			rb.setLinearVelocity(moveVec.x, moveVec.y, moveVec.z);
		});
	}
}