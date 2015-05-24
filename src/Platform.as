package {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Platform extends Square {
		public function Platform() {
			// constructor code
			super();
		
		}
		
		override public function narrowCheck(body:Body):void {
			cloudCheck(body);
		}
		
		protected function cloudCheck(body:Body):void {
			var projectedLoc:Point = new Point(body.x, body.y).add(body.velocity);
			if (body.velocity.y > 0 && rotation == 90) { //Foot hit
				wallCheck(Util.DOWN, body, projectedLoc);
			} else if (body.velocity.y < 0 && rotation == -90) { //Head hit
				wallCheck(Util.UP, body, projectedLoc);
			}
			
			if (body.velocity.x > 0 && rotation == 0) { //right arm hit
				wallCheck(Util.RIGHT, body, projectedLoc);
			} else if (body.velocity.x < 0 && (rotation == 180 || rotation == -180)) { //left arm hit
				wallCheck(Util.LEFT, body, projectedLoc);
			}
		}
	}

}
