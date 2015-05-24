package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Michael M
	 */
	public class TerrainObject extends MovieClip {
		protected var narrowRect:Rectangle;
		private var broadRect:Rectangle;
		
		public function TerrainObject() {
			super();
			narrowRect = new Rectangle(x - width / 2, y - height / 2, width, height);
			broadRect = new Rectangle(narrowRect.x - 30, narrowRect.y - 30, narrowRect.width + 60, narrowRect.height + 60);
			//Broadrect should cover max vel of objects
		}
		
		public function broadCheckPoint(px:Number, py:Number):Boolean {
			return broadRect.containsPoint(new Point(px, py));
		}
		
		public function broadCheck(body:Body):Boolean {
			return body.getBounds(Util.mainSprite).intersects(broadRect);
		}
		
		public function narrowCheckPoint(p:Point):Boolean {
			return false;
		}
		
		public function narrowCheck(body:Body):void {
		}
		
		private function checkPoint(p:Point, useHitTest:Boolean):Boolean {
			if (useHitTest) {
				return hitTestPoint(p.x, p.y, true);
			}
			return narrowRect.containsPoint(p);
		}
		
		protected function wallCheck(dir:uint, body:Body, projectedLoc:Point):Boolean {
			var pointA:Point;
			var pointB:Point;
			
			if (dir == Util.DOWN) { //Foot check
				pointA = new Point(body.hitBox_Y.left, body.hitBox_Y.bottom).add(projectedLoc);
				pointB = body.hitBox_Y.bottomRight.add(projectedLoc);
				
				if (narrowCheckPoint(pointA) || narrowCheckPoint(pointB)) {
					body.y = narrowRect.top - body.hitBox_Y.height / 2;
					body.checkBounce(false);
					body.botHit = true;
					return true;
				}
				
			} else if (dir == Util.UP) { // head check
				pointA = body.hitBox_Y.topLeft.add(projectedLoc);
				pointB = new Point(body.hitBox_Y.right, body.hitBox_Y.top).add(projectedLoc);
				
				if (narrowCheckPoint(pointA) || narrowCheckPoint(pointB)) {
					body.y = narrowRect.bottom + body.hitBox_Y.height / 2;
					body.checkBounce(false);
					body.topHit = true;
					return true;
				}
				
			} else if (dir == Util.RIGHT) { //right arm check
				pointA = new Point(body.hitBox_X.right, body.hitBox_X.top).add(projectedLoc);
				pointB = body.hitBox_X.bottomRight.add(projectedLoc);
				
				if (narrowCheckPoint(pointA) || narrowCheckPoint(pointB)) {
					body.x = narrowRect.left - body.hitBox_X.width / 2;
					body.checkBounce(true);
					body.rightHit = true;
					return true;
				}
				
			} else { // left arm check
				pointA = body.hitBox_X.topLeft.add(projectedLoc);
				pointB = new Point(body.hitBox_X.left, body.hitBox_X.bottom).add(projectedLoc);
				
				if (narrowCheckPoint(pointA) || narrowCheckPoint(pointB)) {
					body.x = narrowRect.right + body.hitBox_X.width / 2;
					body.checkBounce(true);
					body.leftHit = true;
					return true;
				}
				
			}
			return false;
		}
	}
}