package com.tss.squatch
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.core.FlexGlobals;
	import mx.core.UIComponent;
	
	import spark.components.BorderContainer;
	import spark.components.Group;
	import spark.components.Image;
	import spark.components.Label;
	import spark.components.Scroller;
	import spark.core.SpriteVisualElement;

	public class MobileMap extends UIComponent
	{
		private var iMinx:Number;
		private var iMiny:Number;
		private var iMaxx:Number;
		private var iMaxy:Number;
		private var currMinx:Number;
		private var currMiny:Number;
		private var currMaxx:Number;
		private var currMaxy:Number;
		private var mapServiceURL:String = "http://server.arcgisonline.com/ArcGIS/rest/services/ESRI_StreetMap_World_2D/MapServer";
		//private var mapServiceURL:String = "http://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Transportation/MapServer";
		private var imageList:ArrayList = new ArrayList();
		private var tileList1:ArrayList = new ArrayList();
		private var tileList2:ArrayList = new ArrayList();
		private var tileList3:ArrayList = new ArrayList();
		private var mapMinx:ArrayList = new ArrayList();
		private var mapMiny:ArrayList = new ArrayList();
		private var mapMaxx:ArrayList = new ArrayList();
		private var mapMaxy:ArrayList = new ArrayList();
		private var mapWidth:Number = 270;
		private var mapHeight:Number = 400;
		private var zoomState:Number = 0;
		private var mapGroup:Group = new Group();
		private var imageGroup1:Group = new Group();
		private var imageGroup2:Group = new Group();
		private var imageGroup3:Group = new Group();
		
		private var mapImage:Image = new Image();
		
		private var mapImage1_1:Image = new Image();
		private var mapImage1_2:Image = new Image();
		private var mapImage1_3:Image = new Image();
		private var mapImage1_4:Image = new Image();
		
		private var mapImage2_1:Image = new Image();
		private var mapImage2_2:Image = new Image();
		private var mapImage2_3:Image = new Image();
		private var mapImage2_4:Image = new Image();
		private var mapImage2_5:Image = new Image();
		private var mapImage2_6:Image = new Image();
		private var mapImage2_7:Image = new Image();
		private var mapImage2_8:Image = new Image();
		private var mapImage2_9:Image = new Image();
		private var mapImage2_10:Image = new Image();
		private var mapImage2_11:Image = new Image();
		private var mapImage2_12:Image = new Image();
		private var mapImage2_13:Image = new Image();
		private var mapImage2_14:Image = new Image();
		private var mapImage2_15:Image = new Image();
		private var mapImage2_16:Image = new Image();
		
		private var zinImage:Image = new Image();
		private var zoutImage:Image = new Image();
		private var pLeft:Image = new Image();
		private var pRight:Image = new Image();
		private var pUp:Image = new Image();
		private var pDown:Image = new Image();
		private var canvas:BorderContainer = new BorderContainer();
		private var sve:SpriteVisualElement = new SpriteVisualElement();
		private var _routeCoords:ArrayCollection;
		private var positionSprite:Sprite = new Sprite();
		private var mapRetrievalCount:int = 0;
		private var tileRetrievalCount:int = 0;
		private var dbManager:MAVRICDBManager = new MAVRICDBManager();
		private var fileUtility:FileUtility = new FileUtility();
		private var waitLabel:Label = new Label();
		private var mapIsDrawing:Boolean = false;
		
		[Embed(source="images/zoom-in.png")] protected var zoomin:Class
		[Embed(source="images/zoom-out.png")] protected var zoomout:Class
		[Embed(source="images/arrow_up.png")] protected var panUp:Class
		[Embed(source="images/arrow_down.png")] protected var panDown:Class
		[Embed(source="images/arrow_left.png")] protected var panLeft:Class
		[Embed(source="images/arrow_right.png")] protected var panRight:Class
		
		public function MobileMap()
		{
			try
			{
				imageList.addItemAt(tileList1, 0);
				imageList.addItemAt(tileList2, 1);
				imageList.addItemAt(tileList3, 2);
				
				imageGroup1.height = mapHeight;
				imageGroup1.width = mapWidth;
				imageGroup1.x = 0;
				imageGroup1.y = 0;
				
				imageGroup2.height = mapHeight * 2;
				imageGroup2.width = mapWidth * 2;
				imageGroup2.x = ((imageGroup2.width - mapWidth) / 2) * -1;
				imageGroup2.y = ((imageGroup2.height - mapHeight) / 2) * -1;
				
				imageGroup3.height = mapHeight * 4;
				imageGroup3.width = mapWidth * 4;
				imageGroup3.x = ((imageGroup3.width - mapWidth) / 2) * -1;
				imageGroup3.y = ((imageGroup3.height - mapHeight) / 2) * -1;
				
				// Add group 1 images
				mapImage.x=0;
				mapImage.y=0;
				imageGroup1.addElement(mapImage);
				
				
				// Add group 2 images
				mapImage1_1.x=0;
				mapImage1_1.y=mapHeight;
				imageGroup2.addElement(mapImage1_1);
				
				mapImage1_2.x=mapWidth;
				mapImage1_2.y=mapHeight;
				imageGroup2.addElement(mapImage1_2);
				
				mapImage1_3.x=0;
				mapImage1_3.y=0;
				imageGroup2.addElement(mapImage1_3);
				
				mapImage1_4.x=mapWidth;
				mapImage1_4.y=0;
				imageGroup2.addElement(mapImage1_4);
				
				// Add group 3 images
				mapImage2_1.x=0;
				mapImage2_1.y=mapHeight*3;
				imageGroup3.addElement(mapImage2_1);
				
				mapImage2_2.x=mapWidth;
				mapImage2_2.y=mapHeight*3;
				imageGroup3.addElement(mapImage2_2);
				
				mapImage2_3.x=mapWidth * 2;
				mapImage2_3.y=mapHeight*3;
				imageGroup3.addElement(mapImage2_3);
				
				mapImage2_4.x=mapWidth * 3;
				mapImage2_4.y=mapHeight*3;
				imageGroup3.addElement(mapImage2_4);
				//
				
				mapImage2_5.x=0;
				mapImage2_5.y=mapHeight * 2;
				imageGroup3.addElement(mapImage2_5);
				
				mapImage2_6.x=mapWidth;
				mapImage2_6.y=mapHeight * 2;
				imageGroup3.addElement(mapImage2_6);
				
				mapImage2_7.x=mapWidth * 2;
				mapImage2_7.y=mapHeight * 2;
				imageGroup3.addElement(mapImage2_7);
				
				mapImage2_8.x=mapWidth * 3;
				mapImage2_8.y=mapHeight * 2;
				imageGroup3.addElement(mapImage2_8);
				//
				
				mapImage2_9.x=0;
				mapImage2_9.y=mapHeight;
				imageGroup3.addElement(mapImage2_9);
				
				mapImage2_10.x=mapWidth;
				mapImage2_10.y=mapHeight;
				imageGroup3.addElement(mapImage2_10);
				
				mapImage2_11.x=mapWidth * 2;
				mapImage2_11.y=mapHeight;
				imageGroup3.addElement(mapImage2_11);
				
				mapImage2_12.x=mapWidth * 3;
				mapImage2_12.y=mapHeight;
				imageGroup3.addElement(mapImage2_12);
				//
				
				mapImage2_13.x=0;
				mapImage2_13.y=0;
				imageGroup3.addElement(mapImage2_13);
				
				mapImage2_14.x=mapWidth;
				mapImage2_14.y=0;
				imageGroup3.addElement(mapImage2_14);
				
				mapImage2_15.x=mapWidth * 2;
				mapImage2_15.y=0
				imageGroup3.addElement(mapImage2_15);
				
				mapImage2_16.x=mapWidth *3;
				mapImage2_16.y=0;
				imageGroup3.addElement(mapImage2_16);
				
				
				
				// Set up the map group
				mapGroup.height = mapHeight;
				mapGroup.width = mapWidth;
				mapGroup.addElement(imageGroup1);
				
				canvas.x=0;
				canvas.y=0;
				canvas.height=mapHeight;
				canvas.width=mapWidth;
				canvas.visible=true;
				canvas.setStyle("backgroundAlpha",0);
				canvas.setStyle("contentBackgroundAlpha",0);
				positionSprite.graphics.lineStyle(1,0x000000,1);
				positionSprite.graphics.beginFill(0xFF0000,1);
				positionSprite.graphics.drawCircle(5,5,8);
				positionSprite.graphics.endFill();
				positionSprite.visible = false;
				positionSprite.x=0;
				positionSprite.y=0;
				
				
				sve.addChild(positionSprite);
				sve.x=0;
				sve.y=0;
				sve.height=mapHeight;
				sve.width=mapWidth;
				canvas.addElement(sve);
				
				mapGroup.addElement(canvas);
				
				zinImage.source = zoomin;
				zinImage.x = 35;
				zinImage.y = 30;
				zinImage.width = 35;
				zinImage.height = 35;
				zinImage.addEventListener(MouseEvent.CLICK, zoomIn);
				mapGroup.addElement(zinImage);
				
				zoutImage.source = zoomout;
				zoutImage.x = 35;
				zoutImage.y = 85;
				zoutImage.width = 35;
				zoutImage.height = 35;
				zoutImage.addEventListener(MouseEvent.CLICK, zoomOut);
				mapGroup.addElement(zoutImage);
				
				pUp.source = panUp;
				pUp.height=35;
				pUp.width=35;
				pUp.x = 40;
				pUp.y = 130;
				pUp.addEventListener(MouseEvent.CLICK, panMapUp);
				mapGroup.addElement(pUp);
				
				pDown .source = panDown;
				pDown.height=35;
				pDown.width=35;
				pDown.x = 40;
				pDown.y = 180;
				pDown.addEventListener(MouseEvent.CLICK, panMapDown);
				mapGroup.addElement(pDown);
				
				pLeft.source = panLeft;
				pLeft.height=35;
				pLeft.width=35;
				pLeft.x = 10;
				pLeft.y = 155;
				pLeft.addEventListener(MouseEvent.CLICK, panMapLeft);
				mapGroup.addElement(pLeft);
				
				pRight.source = panRight;
				pRight.height=35;
				pRight.width=35;
				pRight.x = 68;
				pRight.y = 155;
				pRight.addEventListener(MouseEvent.CLICK, panMapRight);
				mapGroup.addElement(pRight);
				
				waitLabel.visible = false;
				mapIsDrawing = false;
				waitLabel.height = 30;
				waitLabel.width = 400;
				waitLabel.x = mapWidth / 2 - 75;
				waitLabel.y = 100;
				waitLabel.text = "Caching Map Images.  Please wait...";
				
				mapGroup.addElement(waitLabel);
				this.addChild(mapGroup);
			} catch (err:Error)
			{
				FlexGlobals.topLevelApplication.TSSAlert(err.message);
			}
		}
		
		/*
		Set the initial map extent.  Esri only.
		*/

		public function get routeCoords():ArrayCollection
		{
			return _routeCoords;
		}

		public function set routeCoords(value:ArrayCollection):void
		{
			_routeCoords = value;
		}

		public function setInitialMapExtent(minx:Number, miny:Number, maxx:Number, maxy:Number):void
		{
			if (!this.mapIsDrawing)
			{
				mapIsDrawing = true;
				iMinx=minx;
				iMiny=miny;
				iMaxx=maxx;
				iMaxy=maxy;
				mapRetrievalCount = 0;
				tileRetrievalCount = 0;
				retrieveMapImages();
			}
		}
		
		
		
		// Retrieve the three map scale images. Check locally first.
		private function retrieveMapImages():void
		{
			try
			{
				waitLabel.visible = true;
				trace("FlexGlobals.topLevelApplication: " + FlexGlobals.topLevelApplication);
				var coords:Array = dbManager.getMapImageRecord(FlexGlobals.topLevelApplication.currentRouteName, FlexGlobals.topLevelApplication.currentBeginMile, FlexGlobals.topLevelApplication.currentEndMile);
				if (coords == null)
				{
					
					var bbox:String;
					var msize:String = mapWidth + "," + mapHeight;
					var extWidth:Number = iMaxx - iMinx;
					var extHeight:Number = iMaxy - iMiny;
					if (mapRetrievalCount == 0)
					{
						bbox = iMinx + "," + iMiny + "," + iMaxx + "," + iMaxy;
					} else if (mapRetrievalCount == 1)
					{
						if (tileRetrievalCount == 0)
						{
							bbox = iMinx + "," + iMiny + "," + (iMinx + (extWidth/2)) + "," + (iMiny + (extHeight /2));
						} else if (tileRetrievalCount == 1)
						{
							bbox = (iMinx + (extWidth/2)) + "," + iMiny + "," + iMaxx + "," + (iMiny + (extHeight /2));
						} else if (tileRetrievalCount == 2)
						{
							bbox = iMinx + "," + (iMiny + (extHeight /2)) + "," + (iMinx + (extWidth/2)) + "," + iMaxy;
						} else if (tileRetrievalCount == 3)
						{
							bbox = (iMinx + (extWidth/2)) + "," + (iMiny + (extHeight /2)) + "," + iMaxx + "," + iMaxy;
						}
					} else if (mapRetrievalCount == 2)
					{
						if (tileRetrievalCount == 0)
						{
							bbox = iMinx + "," + iMiny + "," + (iMinx + (extWidth/4)) + "," + (iMiny + (extHeight /4));
						} else if (tileRetrievalCount == 1)
						{
							bbox = (iMinx + (extWidth/4)) + "," + iMiny + "," + (iMinx + (extWidth /2)) + "," + (iMiny + (extHeight /4));
						} else if (tileRetrievalCount == 2)
						{
							bbox = (iMinx + (extWidth/2)) + "," + iMiny + "," + (iMaxx - (extWidth/4)) + "," + (iMiny + (extHeight /4));
						} else if (tileRetrievalCount == 3)
						{
							bbox = (iMaxx - (extWidth/4)) + "," + iMiny  + "," + iMaxx + "," + (iMiny + (extHeight /4));
							//
						} else if (tileRetrievalCount == 4)
						{
							bbox = iMinx + "," + (iMiny + (extHeight/4)) + "," + (iMinx + (extWidth/4)) + "," + (iMiny + (extHeight /2));
						} else if (tileRetrievalCount == 5)
						{
							bbox = (iMinx + (extWidth/4)) + "," + (iMiny + (extHeight/4)) + "," + (iMinx + (extWidth /2)) + "," + (iMiny + (extHeight /2));
						} else if (tileRetrievalCount == 6)
						{
							bbox = (iMinx + (extWidth/2)) + "," + (iMiny + (extHeight /4)) + "," + (iMaxx - (extWidth/4)) + "," + (iMiny + (extHeight /2));
						} else if (tileRetrievalCount == 7)
						{
							bbox = (iMaxx - (extWidth/4)) + "," + (iMiny + (extHeight /4))  + "," + iMaxx + "," + (iMiny + (extHeight /2));
							//
						} else if (tileRetrievalCount == 8)
						{
							bbox = iMinx + "," + (iMiny + (extHeight/2)) + "," + (iMinx + (extWidth/4)) + "," + (iMaxy - (extHeight /4));
						} else if (tileRetrievalCount == 9)
						{
							bbox = (iMinx + (extWidth/4)) + "," + (iMiny + (extHeight /2)) + "," + (iMinx + (extWidth/2)) + "," + (iMaxy - (extHeight /4));
						} else if (tileRetrievalCount == 10)
						{
							bbox = (iMinx + (extWidth/2)) + "," + (iMiny + (extHeight /2)) + "," + (iMaxx - (extWidth/4)) + "," + (iMaxy - (extHeight /4));
						} else if (tileRetrievalCount == 11)
						{
							bbox = (iMaxx - (extWidth/4)) + "," + (iMiny + (extHeight /2)) + "," + iMaxx + "," + (iMaxy - (extHeight /4));
							//
						} else if (tileRetrievalCount == 12)
						{
							bbox = iMinx + "," + (iMaxy - (extHeight/4)) + "," + (iMinx + (extWidth/4)) + "," + iMaxy;
						} else if (tileRetrievalCount == 13)
						{
							bbox = (iMinx + (extWidth/4)) + "," + (iMaxy - (extHeight/4)) + "," + (iMinx + (extWidth/2)) + "," + iMaxy;
						} else if (tileRetrievalCount == 14)
						{
							bbox = (iMinx + (extWidth/2)) + "," + (iMaxy - (extHeight/4)) + "," + (iMaxx - (extWidth/4)) + "," + iMaxy;
						} else if (tileRetrievalCount == 15)
						{
							bbox = (iMaxx - (extWidth/4)) + "," + (iMaxy - (extHeight/4)) + "," + iMaxx + "," + iMaxy;
						}
					}
		
					var mapRequestUrl:String = mapServiceURL+"/export?bbox=" + bbox + "&bboxSR=&layers=&layerdefs=&size=" + msize + "&imageSR=&format=png24&transparent=false&dpi=200&f=pjson";
					trace(mapRequestUrl);
					var urlReq:URLRequest = new URLRequest(mapRequestUrl);	
					var urlLdr:URLLoader = new URLLoader();
					urlLdr.addEventListener(Event.COMPLETE, handleMapString);
					urlLdr.load(urlReq);
				} else
				{
					currMinx = coords[0];
					currMiny = coords[1];
					currMaxx = coords[2];
					currMaxy = coords[3];
					iMinx = coords[0];
					iMiny = coords[1];
					iMaxx = coords[2];
					iMaxy = coords[3];
					getLocalMapImages();
				}
			} catch (err:Error)
			{
				waitLabel.visible = false;
				mapIsDrawing = false;
				FlexGlobals.topLevelApplication.TSSAlert(err.message);
			}
		}
	
		
		private function handleMapString(evt:Event):void 
		{
			try
			{
				var ldr:URLLoader = evt.currentTarget as URLLoader;
				var mapReturn:String = ldr.data;
				trace(mapReturn);
				var syms:Object = (JSON.parse(mapReturn));
				if (mapRetrievalCount == 0)
				{
					currMinx = syms.extent.xmin;
					currMiny = syms.extent.ymin;
					currMaxx = syms.extent.xmax;
					currMaxy = syms.extent.ymax;
					iMinx = syms.extent.xmin;
					iMiny = syms.extent.ymin;
					iMaxx = syms.extent.xmax;
					iMaxy = syms.extent.ymax;
					
				}
				/*this.mapMinx.addItemAt(syms.extent.xmin,mapRetrievalCount);
				this.mapMiny.addItemAt(syms.extent.ymin,mapRetrievalCount);
				this.mapMaxx.addItemAt(syms.extent.xmax,mapRetrievalCount);
				this.mapMaxy.addItemAt(syms.extent.ymax,mapRetrievalCount);*/
				 
				var mapRequestUrl:String = syms.href;
				
				var urlReq:URLRequest = new URLRequest(mapRequestUrl);	
				var urlLdr:Loader = new Loader();
				urlLdr.contentLoaderInfo.addEventListener(Event.COMPLETE, handleImageLoad);	
				urlLdr.load(urlReq);	
			} catch (err:Error)
			{
				waitLabel.visible = false;
				mapIsDrawing = false;
				FlexGlobals.topLevelApplication.TSSAlert(err.message);
			}
		}
		
		private function handleImageLoad(evt:Event):void 
		{
			try
			{
				var ldr:URLLoader = evt.currentTarget as URLLoader;
				var img:Bitmap = evt.target.content as Bitmap;
				if (mapRetrievalCount == 0)
				{
					mapImage.source = img;
					addOverlay();
					this.tileList1.addItemAt(img,0);
					mapRetrievalCount++;
					if (FlexGlobals.topLevelApplication.cacheLocalMaps)
					{
						retrieveMapImages();
					} else
					{
						waitLabel.visible = false;
						mapIsDrawing = false;
						this.zinImage.visible = false;
						this.zoutImage.visible = false;
						this.pUp.visible = false;
						this.pDown.visible = false;
						this.pLeft.visible = false;
						this.pRight.visible = false;
					}
				} else if (mapRetrievalCount == 1)
				{
					this.tileList2.addItemAt(img,this.tileRetrievalCount);
					tileRetrievalCount++;
					if (tileRetrievalCount > 3)
					{
						mapRetrievalCount++;
						tileRetrievalCount = 0;
					}
					retrieveMapImages();
				}else if (mapRetrievalCount == 2)
				{
					this.tileList3.addItemAt(img,this.tileRetrievalCount);
					tileRetrievalCount++;
					if (tileRetrievalCount < 16)
						retrieveMapImages();
					else // Done loading map images 
					{
						mapImage1_1.source = tileList2.getItemAt(0) as Bitmap;
						mapImage1_2.source = tileList2.getItemAt(1) as Bitmap;
						mapImage1_3.source = tileList2.getItemAt(2) as Bitmap;
						mapImage1_4.source = tileList2.getItemAt(3) as Bitmap;
						
						mapImage2_1.source = tileList3.getItemAt(0) as Bitmap;
						mapImage2_2.source = tileList3.getItemAt(1) as Bitmap;
						mapImage2_3.source = tileList3.getItemAt(2) as Bitmap;
						mapImage2_4.source = tileList3.getItemAt(3) as Bitmap;
						mapImage2_5.source = tileList3.getItemAt(4) as Bitmap;
						mapImage2_6.source = tileList3.getItemAt(5) as Bitmap;
						mapImage2_7.source = tileList3.getItemAt(6) as Bitmap;
						mapImage2_8.source = tileList3.getItemAt(7) as Bitmap;
						mapImage2_9.source = tileList3.getItemAt(8) as Bitmap;
						mapImage2_10.source = tileList3.getItemAt(9) as Bitmap;
						mapImage2_11.source = tileList3.getItemAt(10) as Bitmap;
						mapImage2_12.source = tileList3.getItemAt(11) as Bitmap;
						mapImage2_13.source = tileList3.getItemAt(12) as Bitmap;
						mapImage2_14.source = tileList3.getItemAt(13) as Bitmap;
						mapImage2_15.source = tileList3.getItemAt(14) as Bitmap;
						mapImage2_16.source = tileList3.getItemAt(15) as Bitmap;
						writeLocalMapImages();
						dbManager.insertMapImageRecord(FlexGlobals.topLevelApplication.currentRouteName, FlexGlobals.topLevelApplication.currentBeginMile, FlexGlobals.topLevelApplication.currentEndMile, 
							currMinx, currMiny, currMaxx, currMaxy,
							FlexGlobals.topLevelApplication.currentRouteName + "_" + FlexGlobals.topLevelApplication.currentBeginMile + "_" + FlexGlobals.topLevelApplication.currentEndMile);
						FlexGlobals.topLevelApplication.TSSAlert("Map Loading Complete");
						waitLabel.visible = false;
						mapIsDrawing = false;
						
					}
				}
			} catch (err:Error)
			{
				waitLabel.visible = false;
				mapIsDrawing = false;
				FlexGlobals.topLevelApplication.TSSAlert(err.message);
			}
		}
		
		private function writeLocalMapImages():void
		{
			try
			{
				var tmpRN:String = FlexGlobals.topLevelApplication.currentRouteName;
				var tmpBM:Number = FlexGlobals.topLevelApplication.currentBeginMile;
				var tmpEM:Number = FlexGlobals.topLevelApplication.currentEndMile;
				
				var tmpMapImage:Bitmap = tileList1.getItemAt(0) as Bitmap;
				fileUtility.WriteMapImage(tmpRN + "_" + tmpBM + "_" + tmpEM + ".png", tmpMapImage);
				
				for (var i:int=0;i<tileList2.length;i++)
				{
					tmpMapImage = tileList2.getItemAt(i) as Bitmap;
					fileUtility.WriteMapImage(tmpRN + "_" + tmpBM + "_" + tmpEM + "_1_" + i + ".png", tmpMapImage);
				}
				
				for (var i:int=0;i<tileList3.length;i++)
				{
					tmpMapImage = tileList3.getItemAt(i) as Bitmap;
					fileUtility.WriteMapImage(tmpRN + "_" + tmpBM + "_" + tmpEM + "_2_" + i + ".png", tmpMapImage);
				}
			} catch (err:Error)
			{
				waitLabel.visible = false;
				mapIsDrawing = false;
				FlexGlobals.topLevelApplication.TSSAlert(err.message);
			}
		}
		
		
		private function getLocalMapImages():void
		{
			try
			{
				var tmpRN:String = FlexGlobals.topLevelApplication.currentRouteName;
				var tmpBM:Number = FlexGlobals.topLevelApplication.currentBeginMile;
				var tmpEM:Number = FlexGlobals.topLevelApplication.currentEndMile;
				var tmpFile:File;
				var load:Loader
				
				if (mapRetrievalCount == 0)
				{
					tmpFile = new File("/sdcard/mapimages/" + tmpRN + "_" + tmpBM + "_" + tmpEM + ".png");
				} else if (mapRetrievalCount == 1)
				{
					tmpFile = new File("/sdcard/mapimages/" + tmpRN + "_" + tmpBM + "_" + tmpEM + "_1_" + tileRetrievalCount + ".png");
				} else if (mapRetrievalCount == 2)
				{
					tmpFile = new File("/sdcard/mapimages/" + tmpRN + "_" + tmpBM + "_" + tmpEM + "_2_" + tileRetrievalCount + ".png");
				}
				
	
				load = new Loader();
				var request:URLRequest = new URLRequest(tmpFile.url);
				load.load(request);
				load.contentLoaderInfo.addEventListener(Event.COMPLETE, map_image_load_complete);
			} catch (err:Error)
			{
				waitLabel.visible = false;
				mapIsDrawing = false;
				FlexGlobals.topLevelApplication.TSSAlert(err.message);
			}
		}
		
		private function map_image_load_complete(evt:Event):void
		{
			
			try
			{
				var ldr:URLLoader = evt.currentTarget as URLLoader;
				var img:Bitmap = evt.target.content as Bitmap;
				if (mapRetrievalCount == 0)
				{
					mapImage.source = img;
					addOverlay();
					this.tileList1.addItemAt(img,0);
					mapRetrievalCount++;
					getLocalMapImages();
				} else if (mapRetrievalCount == 1)
				{
					this.tileList2.addItemAt(img,this.tileRetrievalCount);
					tileRetrievalCount++;
					if (tileRetrievalCount > 3)
					{
						mapRetrievalCount++;
						tileRetrievalCount = 0;
					}
					getLocalMapImages();
				}else if (mapRetrievalCount == 2)
				{
					this.tileList3.addItemAt(img,this.tileRetrievalCount);
					tileRetrievalCount++;
					if (tileRetrievalCount < 16)
						getLocalMapImages();
					else // Done loading map images 
					{
						mapImage1_1.source = tileList2.getItemAt(0) as Bitmap;
						mapImage1_2.source = tileList2.getItemAt(1) as Bitmap;
						mapImage1_3.source = tileList2.getItemAt(2) as Bitmap;
						mapImage1_4.source = tileList2.getItemAt(3) as Bitmap;
						
						mapImage2_1.source = tileList3.getItemAt(0) as Bitmap;
						mapImage2_2.source = tileList3.getItemAt(1) as Bitmap;
						mapImage2_3.source = tileList3.getItemAt(2) as Bitmap;
						mapImage2_4.source = tileList3.getItemAt(3) as Bitmap;
						mapImage2_5.source = tileList3.getItemAt(4) as Bitmap;
						mapImage2_6.source = tileList3.getItemAt(5) as Bitmap;
						mapImage2_7.source = tileList3.getItemAt(6) as Bitmap;
						mapImage2_8.source = tileList3.getItemAt(7) as Bitmap;
						mapImage2_9.source = tileList3.getItemAt(8) as Bitmap;
						mapImage2_10.source = tileList3.getItemAt(9) as Bitmap;
						mapImage2_11.source = tileList3.getItemAt(10) as Bitmap;
						mapImage2_12.source = tileList3.getItemAt(11) as Bitmap;
						mapImage2_13.source = tileList3.getItemAt(12) as Bitmap;
						mapImage2_14.source = tileList3.getItemAt(13) as Bitmap;
						mapImage2_15.source = tileList3.getItemAt(14) as Bitmap;
						mapImage2_16.source = tileList3.getItemAt(15) as Bitmap;
						FlexGlobals.topLevelApplication.TSSAlert("Map Loading Complete");
						waitLabel.visible = false;
						mapIsDrawing = false;
					}
				}
			} catch (err:Error)
			{
				waitLabel.visible = false;
				mapIsDrawing = false;
				FlexGlobals.topLevelApplication.TSSAlert(err.message);
			}
		}
		
		
		
		
		
		private function panMapDown(evt:MouseEvent):void
		{
			if (zoomState == 1)
			{
				imageGroup2.y = imageGroup2.y - 20;
				canvas.x = imageGroup2.x;
				canvas.y = imageGroup2.y;
			} else if (zoomState == 2)
			{
				imageGroup3.y = imageGroup3.y - 20;
				canvas.x = imageGroup3.x;
				canvas.y = imageGroup3.y;
			}
				
		}
		
		private function panMapUp(evt:MouseEvent):void
		{
			if (zoomState == 1)
			{
				imageGroup2.y = imageGroup2.y + 20;
				canvas.x = imageGroup2.x;
				canvas.y = imageGroup2.y;
			} else if (zoomState == 2)
			{
				imageGroup3.y = imageGroup3.y + 20;
				canvas.x = imageGroup3.x;
				canvas.y = imageGroup3.y;
			}
			
		}
		
		private function panMapRight(evt:MouseEvent):void
		{
			if (zoomState == 1)
			{
				imageGroup2.x = imageGroup2.x - 20;
				canvas.x = imageGroup2.x;
				canvas.y = imageGroup2.y;
			} else if (zoomState == 2)
			{
				imageGroup3.x = imageGroup3.x - 20;
				canvas.x = imageGroup3.x;
				canvas.y = imageGroup3.y;
			}
			
		}
		
		private function panMapLeft(evt:MouseEvent):void
		{
			if (zoomState == 1)
			{
				imageGroup2.x = imageGroup2.x + 20;
				canvas.x = imageGroup2.x;
				canvas.y = imageGroup2.y;
			} else if (zoomState == 2)
			{
				imageGroup3.x = imageGroup3.x + 20;
				canvas.x = imageGroup3.x;
				canvas.y = imageGroup3.y;
			}
			
		}
		
		private function zoomIn(evt:MouseEvent):void
		{
			if (zoomState < 2)
			{
				zoomState++;
				setZoomLevel(zoomState);
			}
		}
		
		private function zoomOut(evt:MouseEvent):void
		{
			if (zoomState > 0)
			{
				zoomState = zoomState -1;
				setZoomLevel(zoomState);
			}
		}
		
		// Set the image for the appropriate zoom level
		public function setZoomLevel(zLevel:int):void
		{
			try
			{
				if (zLevel < imageList.length && zLevel > -1)
				{
					if (mapGroup.contains(imageGroup1))
					{
						mapGroup.removeElement(imageGroup1);
					}
					if (mapGroup.contains(imageGroup2))
					{
						mapGroup.removeElement(imageGroup2);
					}
					if (mapGroup.contains(imageGroup3))
					{
						mapGroup.removeElement(imageGroup3);
					}
					if (zLevel == 0)
					{
						mapGroup.addElementAt(imageGroup1, 0);
						mapWidth = imageGroup1.width;
						canvas.width = imageGroup1.width;
						sve.width = imageGroup1.width;
						mapHeight = imageGroup1.height;
						canvas.height = imageGroup1.height;
						canvas.x = imageGroup1.x;
						canvas.y = imageGroup1.y;
						sve.height = imageGroup1.height;
					} else if (zLevel == 1)
					{
						mapGroup.addElementAt(imageGroup2, 0);
						mapWidth = imageGroup2.width;
						canvas.width = imageGroup2.width;
						sve.width = imageGroup2.width;
						mapHeight = imageGroup2.height;
						canvas.height = imageGroup2.height;
						canvas.x = imageGroup2.x;
						canvas.y = imageGroup2.y;
						sve.height = imageGroup2.height;
					} else if (zLevel == 2)
					{
						mapGroup.addElementAt(imageGroup3, 0);
						mapWidth = imageGroup3.width;
						canvas.width = imageGroup3.width;
						sve.width = imageGroup3.width;
						mapHeight = imageGroup3.height;
						canvas.height = imageGroup3.height;
						canvas.x = imageGroup3.x;
						canvas.y = imageGroup3.y;
						sve.height = imageGroup3.height;
					}
					/*mapImage.source = imageList.getItemAt(zLevel) as Bitmap;
					currMinx = mapMinx.getItemAt(zLevel) as Number;
					currMiny = mapMiny.getItemAt(zLevel) as Number;
					currMaxx = mapMaxx.getItemAt(zLevel) as Number;
					currMaxy = mapMaxy.getItemAt(zLevel) as Number;
					mapImage.x = ((mapImage.width - mapGroup.width) / 2) * -1;
					mapImage.y = ((mapImage.height - mapGroup.height) / 2) * -1;
					this.clearOverlays();*/
					this.addOverlay();
				}
			} catch (err:Error)
			{
				FlexGlobals.topLevelApplication.TSSAlert(err.message);
			}
		}
		
		/*
		Add a linear feature passing in an ordered array of coordinate pairs
		ToDo: Add support for the optimized arrays for Google.
		*/
		public function addOverlay():void
		{
			canvas.graphics.clear();
			canvas.graphics.lineStyle(8,0x0000FF,.4);
			canvas.graphics.moveTo(longToMapX(this.routeCoords[0].X), latToMapY(this.routeCoords[0].Y));
			for (var i:int=1;i<this.routeCoords.length;i++)
			{
				canvas.graphics.lineTo(longToMapX(this.routeCoords[i].X), latToMapY(this.routeCoords[i].Y));
			}
		}
		
		/*
		Add a polygon feature passing in an ordered array of coordinate pairs
		ToDo: Add support for the optimized arrays for Google.
		*/
		public function addPolygon(polyCoords:ArrayCollection, boundarywidth:Number, boundarycolor:Number, fillcolor:Number, opacity:Number):void
		{
			
			canvas.graphics.lineStyle(boundarywidth,boundarycolor,opacity);
			canvas.graphics.beginFill(fillcolor, opacity);
			canvas.graphics.moveTo(longToMapX(polyCoords[0].X), latToMapY(polyCoords[0].Y));
			for (var i:int=1;i<polyCoords.length;i++)
			{
				canvas.graphics.lineTo(longToMapX(polyCoords[i].X), latToMapY(polyCoords[i].Y));
			}
			canvas.graphics.lineTo(longToMapX(polyCoords[0].X), latToMapY(polyCoords[0].Y));
			canvas.graphics.endFill();
		}
		
		/*
		Clear all dynamic lines and points
		*/
		public function clearOverlays():void
		{
			canvas.graphics.clear();
		}
		
		
		
		/*
		Move the dynamic point of the specified name
		*/
		public function positionTrackingPoint(x:Number, y:Number, angle:Number, name:String):void
		{
			positionSprite.x = longToMapX(x) - (positionSprite.width/2);
			positionSprite.y = latToMapY(y) - (positionSprite.height/2);
			positionSprite.visible = true;
		}
		
		/*
		Clear a specific dynamic point
		*/
		public function clearTrackingPoint(name:String):void
		{
			positionSprite.visible = false;
		}
		
		// Calculate x value in pixels from a longitude value
		private function longToMapX(long:Number):Number
		{
			if (long <= currMaxx && long >= currMinx)
			{
				var tmpDif:Number = long - currMinx;
				var tmpPerc:Number = tmpDif / (currMaxx - currMinx);
				return mapWidth * tmpPerc;
			} 
			
			return -1;
		}
		
		// Calculate y value in pixels from a latitude value
		private function latToMapY(lat:Number):Number
		{
			if (lat <=currMaxy && lat >= currMiny)
			{
				var tmpDif:Number = currMaxy - lat;
				var tmpPerc:Number = tmpDif / (currMaxy - currMiny);
				return mapHeight * tmpPerc;
			}
			return -1;
		}
	}
}