package com.tss.squatch
{
	
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;
	import mx.core.*;

	public class MAVRICDBManager
	{
		private var sConn:SQLConnection;
		private var sStat:SQLStatement = new SQLStatement();
		private var templates:Object;
		private var primaryKey:String;
		private var invCols:Array;
		private var inspCols:Array;
		
		public function MAVRICDBManager()
		{
			sConn = new SQLConnection();
			sConn.open(File.applicationStorageDirectory.resolvePath("squatch.db"));
			trace(File.applicationStorageDirectory.url);
			//sConn.addEventListener(SQLEvent.OPEN, openedHandler);
			//sConn.addEventListener(SQLErrorEvent.ERROR, errorHandler);
			//sConn.addEventListener(SQLEvent.RESULT, resultHandler);
			setupTables();
		}
		
		
		// Open the local database and initialize all tables
		private function setupTables():void
		{
			sStat.sqlConnection = sConn;
			
			
			sStat.text = "CREATE TABLE IF NOT EXISTS GEOTAGS ( id INTEGER PRIMARY KEY AUTOINCREMENT, " + 
				"asset_base_id TEXT, "+
				"local_asset_id TEXT, "+
				"is_insp_tag INTEGER, "+
				"cached_route_id TEXT, " + 
				"begin_mile REAL, " +
				"end_mile REAL, " + 
				"image_filename TEXT, " + 
				"video_filename TEXT, " + 
				"voice_filename TEXT, " + 
				"text_memo TEXT);";
			sStat.execute();		
			
			//sStat.text = "DROP TABLE MAP_IMAGES;";
			//sStat.execute();
			sStat.text = "CREATE TABLE IF NOT EXISTS MAP_IMAGES ( id INTEGER PRIMARY KEY AUTOINCREMENT, " + 
				"ROUTE_FULL_NAME TEXT,"+ 
				"BEGIN_MILE REAL, " +
				"END_MILE REAL, " + 
				"MINX REAL, " +
				"MINY REAL, " + 
				"MAXX REAL, " + 
				"MAXY REAL, " +
				"FILE_PREFIX TEXT);";
			sStat.execute();	
			
		}
		
		
		// Populate local domain DB table
		public function insertMapImageRecord(routeName:String, beginMile:Number, endMile:Number, minx:Number, miny:Number, maxx:Number, maxy:Number, filePrefix:String):void
		{
			try
			{
				sStat.text = "INSERT INTO MAP_IMAGES (ROUTE_FULL_NAME, BEGIN_MILE, END_MILE, MINX, MINY, MAXX, MAXY, FILE_PREFIX) " +
					" VALUES('" + routeName + "'," + beginMile + "," + endMile + "," + minx + "," + miny + "," + maxx + "," + maxy + ",'" + filePrefix + "');";
				sStat.execute();
				
			} catch (err:Error)
			{
				FlexGlobals.topLevelApplication.TSSAlert(err.message);
			}
			
		}
		
		// Retrieve map image from local DB
		public function getMapImageRecord(routeName:String, beginMile:Number, endMile:Number):Array
		{
			var coords:Array = null;
			try
			{
				sStat.text = "SELECT * from MAP_IMAGES where ROUTE_FULL_NAME = '" + routeName + "' and BEGIN_MILE = " + beginMile + " and END_MILE = " + endMile + "";
				sStat.execute();
				var data:Array = sStat.getResult().data;
				
				
				if (data != null && data.length >0)
				{
					coords = new Array();
					coords[0] =	data[0].MINX;
					coords[1] =	data[0].MINY;
					coords[2] =	data[0].MAXX;
					coords[3] =	data[0].MAXY;
					
				}
				
			} catch (err:Error)
			{
				FlexGlobals.topLevelApplication.TSSAlert(err.message);
			}
			return coords;
		}
		
		
		
	
		
		// Drop the Geotags table
		public function dropGeotagsTable(): void
		{
			sStat.text = "DROP TABLE GEOTAGS;";
			sStat.execute();
			
			sStat.text = "CREATE TABLE IF NOT EXISTS GEOTAGS ( id INTEGER PRIMARY KEY AUTOINCREMENT, " + 
				"asset_base_id TEXT, "+
				"local_asset_id TEXT, "+
				"cached_route_id TEXT, " + 
				"is_insp_tag INTEGER, "+
				"begin_mile REAL, " +
				"end_mile REAL, " + 
				"image_filename TEXT, " + 
				"video_filename TEXT, " + 
				"voice_filename TEXT, " + 
				"text_memo TEXT);";
			sStat.execute();
		}
		
		// deletes all data the Geotags table
		public function clearGeotagsTable(): void
		{
			sStat.text = "DELETE FROM GEOTAGS;";
			sStat.execute();
			
		}
		
		public function clearMapImageTable():void
		{
			sStat.text = "DELETE FROM MAP_IMAGES";
			sStat.execute();	
		}
		
		

		// deletes all data the Geotags table
		public function deleteFromGeotagsTable(idType:String, str:String): void
		{
			if(idType =="local")
				sStat.text = "DELETE FROM GEOTAGS where local_asset_id not in (" +str+")";
			else 
				sStat.text = "DELETE FROM GEOTAGS where asset_base_id not in (" +str+")";
			sStat.execute();
			
		}
		
		
		
	
		
		private function stringOrNull(str : String, isString : Boolean):String
		{
			var res : String;
			if(str === "" || str == null)
			{
				res = "NULL";
			}
			else
			{
				if(isString)
				{
					res = "'" + str + "'";
				}
				else
				{
					res = str;
				}
				
			}
			return res;
		}
		
			
		// Shamelessly Lifted from StackOverflow at:
		// http://stackoverflow.com/questions/5350907/merging-objects-in-as3
		public static function zip(objects:Array):Object
		{
			var r:Object = {};
			
			for each (var o:Object in objects)
			for (var k:String in o)
				r[k] = o[k];
			
			return r;
		}


		
		public function exportGeotags():Array
		{
			var data:Array = new Array();
			try
			{
				sStat.text = "SELECT cached_route_id,asset_base_id,local_asset_id,is_insp_tag,begin_mile,end_mile,image_filename,video_filename,voice_filename,text_memo from GEOTAGS";
				
				sStat.execute();
				data= sStat.getResult().data;
			}
			catch(e:Error)
			{
				FlexGlobals.topLevelApplication.TSSAlert(e.message);
			}
			return data;
		}
		
		
		
		// Geotags **********************************************
		public function addGeoTag(tag:GeoTag):void
		{
			var assetColName:String;
			var assetColVal:String;
			
			/*if(tag.asset_base_id =="" && tag.local_asset_id =="" || tag.asset_base_id ==null && tag.local_asset_id ==null)
			{
				assetColName = "local_asset_id,asset_base_id,";
				assetColVal="'','',";
			}
			else if(tag.asset_base_id =="" && tag.local_asset_id !="" || tag.asset_base_id ==null && tag.local_asset_id !=null)
			{
				assetColName = "local_asset_id,asset_base_id,";
				assetColVal = "'"+ tag.local_asset_id +"','',";
			}
			else
			{
				assetColName = "local_asset_id,asset_base_id,";
				assetColVal = "'"+  tag.local_asset_id+"','"+  tag.asset_base_id+"',";
			}
			
			
			
			sStat.text = "INSERT INTO GEOTAGS (cached_route_id,"+assetColName+ " is_insp_tag, begin_mile, end_mile, image_filename, video_filename, voice_filename, text_memo) " +
				" VALUES('" + tag.cached_route_id + "',"+assetColVal + tag.is_insp + "," + tag.begin_mile_point + "," + tag.end_mile_point + ", '" + tag.image_file_name +
				"' , '" + tag.video_file_name + "' , '" + tag.voice_file_name + "', '" + tag.text_memo + "');";
			sStat.execute();*/
		}
		
		public function getGeoTags():Array
		{
			var gtArray:Array = [];
			sStat.text = "SELECT * from GEOTAGS";
			sStat.execute();
			var data:Array = sStat.getResult().data;
			
			for (var i:int=0;i<data.length;i++)
			{
				var tmpgt:GeoTag = new GeoTag();
				tmpgt.id = data[i].id;
				tmpgt.cached_route_id = data[i].cached_route_id;
				tmpgt.asset_base_id = data[i].asset_base_id;
				tmpgt.is_insp = data[i].is_insp_tag;
				tmpgt.begin_mile_point = data[i].begin_mile;
				tmpgt.end_mile_point = data[i].end_mile;
				tmpgt.image_file_name = data[i].image_filename;
				tmpgt.video_file_name = data[i].video_filename;
				tmpgt.voice_file_name = data[i].voice_filename;
				tmpgt.text_memo = data[i].text_memo;
				gtArray[i] = tmpgt;
			}
			
			return gtArray;
		}
		
		public function getLocalGeoTags(local_id:Number):Array
		{
			var gtArray:Array = [];
			sStat.text = "SELECT * from GEOTAGS where local_asset_id =" + local_id;
			sStat.execute();
			var data:Array = sStat.getResult().data;
			if (data != null)
			{
				for (var i:int=0;i<data.length;i++)
				{
					var tmpgt:GeoTag = new GeoTag();
					tmpgt.id = data[i].id;
					tmpgt.cached_route_id = data[i].cached_route_id;
					tmpgt.asset_base_id = data[i].asset_base_id;
					tmpgt.is_insp = data[i].is_insp_tag;
					tmpgt.begin_mile_point = data[i].begin_mile;
					tmpgt.end_mile_point = data[i].end_mile;
					tmpgt.image_file_name = data[i].image_filename;
					tmpgt.video_file_name = data[i].video_filename;
					tmpgt.voice_file_name = data[i].voice_filename;
					tmpgt.text_memo = data[i].text_memo;
					gtArray[i] = tmpgt;
				}
			}
			return gtArray;
		}
		
		
		public function getGeoTag(gtid:Number):GeoTag
		{
			return null;
		}
		
		public function deleteGeoTag(gtid:Number): void
		{
			
		}
		
	
		
		
	}
}