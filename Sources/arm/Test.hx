package arm;

import arm.MyInputList;

class Test extends iron.Trait {

	var myInputs = new MyInputList();
	var debugAxis = false;

	public function new() {
		super();

		notifyOnInit(function() {
			myInputs.setMoveForwardScale(5);
		});

		notifyOnUpdate(function() {
			if (myInputs.getTraceSomething1()) trace("You pressed SPACE or ENTER!");
			if (myInputs.getTraceSomething2()) trace("You pressed CONTROL + ALT!");
			if (myInputs.getTraceWithMouse()) {
				trace("You pressed LMB!");
				debugAxis = !debugAxis;
			}

			if (debugAxis) 
				trace(myInputs.getMoveForward() * myInputs.getMoveForwardScale());
		});
	}
}
