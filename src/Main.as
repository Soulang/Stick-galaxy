package {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Michael M
	 */
	public class Main extends Sprite {
		private var bodies:Vector.<ExampleBody>;
		
		public function Main() {
			Util.init(this);
			
			bodies = new Vector.<ExampleBody>();
			for (var i:uint = 0; i < 200; i++) {
				var dude:ExampleBody = new ExampleBody();
				addChild(dude);
				bodies.push(dude);
			}
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(MouseEvent.CLICK, jump);
			
			for (var j:uint = 0; j < numChildren; j++) {
				if (getChildAt(j) is TerrainObject) {
					Util.terrain.push(getChildAt(j));
				}
			}
			trace(Util.terrain);
		}
		private function jump(e:MouseEvent):void 
		{
			for each (var d:ExampleBody in bodies) {
				d.myCustomJumpFunction();
			}
		}
		
		private function update(e:Event):void {
			for each (var d:ExampleBody in bodies) {
				d.update();
				d.myCustomMoveFunction();
			}
			
		}
	
	}

}