package {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Square extends TerrainObject {
		public function Square() {
			// constructor code
			super();
		
		}
		override public function narrowCheckPoint(p:Point):Boolean {
			return narrowRect.containsPoint(p);
		}
		override public function narrowCheck(body:Body):void {
			var projectedLoc:Point = new Point(body.x, body.y).add(body.velocity);
			if (body.velocity.y > 0) { //Foot hit
				wallCheck(Util.DOWN, body, projectedLoc);
			} else if (body.velocity.y < 0) { //Head hit
				wallCheck(Util.UP, body, projectedLoc);
			}
			
			if (body.velocity.x > 0) { //right arm hit
				wallCheck(Util.RIGHT, body, projectedLoc);
			} else if (body.velocity.x < 0) { //left arm hit
				wallCheck(Util.LEFT, body, projectedLoc);
			}
			
		}
	}

}
