package {
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Body extends MovieClip {
		public var velocity:Point;
		
		public var hitBox_X:Rectangle;
		public var hitBox_Y:Rectangle;
		
		private const hitWidth:uint = 50;
		private const hitHeight:uint = 50;
		
		private const terminalX:uint = 10;
		private const terminalY:uint = 15;
		
		public var topHit:Boolean = false;
		public var botHit:Boolean = false;
		public var rightHit:Boolean = false;
		public var leftHit:Boolean = false;
		
		public var wallFriction:Number;
		public var groundFriction:Number = 0.0;
		public var airFriction:Number;
		public var isMoving:Boolean = true;
		public var bounce:Number = 0.0;
		public var gravity:Number = 1.5;
		
		public function Body() {
			velocity = new Point(-24 + Math.random() * 48, 0);
			
			hitBox_X = new Rectangle(-hitWidth / 2, -hitHeight / 2 + terminalY, hitWidth, hitHeight - 2 * terminalY);
			hitBox_Y = new Rectangle(-hitWidth / 2 + terminalX, -hitHeight / 2, hitWidth - 2 * terminalX, hitHeight);
			
		}
		
		protected function drawDebug():void {
			var rectangle:Shape = new Shape;
			rectangle.graphics.beginFill(0xFF0000);
			rectangle.graphics.drawRect(hitBox_X.x, hitBox_X.y, hitBox_X.width, hitBox_X.height);
			rectangle.graphics.endFill();
			addChild(rectangle);
			
			rectangle.graphics.beginFill(0xFF0000);
			rectangle.graphics.drawRect(hitBox_Y.x, hitBox_Y.y, hitBox_Y.width, hitBox_Y.height);
			rectangle.graphics.endFill();
			addChild(rectangle);
		}
		
		public function checkBounce(isX:Boolean):void {
			if (isX) {
				if (bounce > 0) {
					velocity.x *= -bounce;
					if (Math.abs(velocity.x) < 2) {
						velocity.x = 0;
					}
				} else {
					velocity.x = 0;
				}
				
			} else {
				if (bounce > 0) {
					velocity.y *= -bounce;
					if (Math.abs(velocity.y) < 2) {
						velocity.y = 0;
					}
				} else {
					velocity.y = 0;
				}
				//animateBounce();
			}
		}
		
		public function checkBounceSlope(isLeft:Boolean):void {
			if (bounce > 0) {
				if (isLeft && velocity.x < 0) {
					velocity.x *= -bounce;
					
				}
				if (!isLeft && velocity.x > 0) {
					velocity.x *= -bounce;
					
				}
				if (Math.abs(velocity.x) < 1) {
					velocity.x = 0;
				}
			}
		}
		
		public function update():void {
			
			velocity.y += gravity;
			velocity.x = velocity.x < -terminalX ? -terminalX : velocity.x > terminalX ? terminalX : velocity.x;
			velocity.y = velocity.y < -terminalY ? -terminalY : velocity.y > terminalY ? terminalY : velocity.y;
			if (botHit) {
				
				if (velocity.x != 0) {
					var endVel:Number;
					if (velocity.x > 0) {
						endVel = velocity.x - groundFriction;
						if (endVel > 0) {
							velocity.x = endVel;
						} else {
							velocity.x = 0;
						}
					} else {
						endVel = velocity.x + groundFriction;
						if (endVel < 0) {
							velocity.x = endVel;
						} else {
							velocity.x = 0;
						}
					}
				} else {
					isMoving = false
				}
				
			}
			for each (var t:TerrainObject in Util.terrain) {
				if (t.broadCheck(this)) {
					
					if (t.narrowCheck(this)) {
						//alpha = 0.5;
					}
				}
			}
			if (botHit && velocity.y > 1) {
				botHit = false;
			}
			if (topHit && velocity.y < 0) {
				topHit = false;
			}
			if (rightHit && velocity.x > 0) {
				rightHit = false;
			}
			if (leftHit && velocity.x < 0) {
				leftHit = false;
			}
			y += velocity.y;
			x += velocity.x;
		
		}
	}

}
