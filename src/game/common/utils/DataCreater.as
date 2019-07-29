package game.common.utils
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileReference;
	import flash.utils.ByteArray;

	public class DataCreater
	{
		
		public static function getFilesBytes(patch:String):Array
		{
			var file:File = File.applicationDirectory.resolvePath("assets/"+patch+"/");
			var list:Array = file.getDirectoryListing();
			return getgetFilesVector(list);
		}	
		
		public static function openFile(callBack:Function):void
		{
			var file:File = File.userDirectory;
			file.browseForDirectory("请打开地图所在目录");
			file.addEventListener(Event.SELECT,function(e:Event):void
			{
				var list:Array = (e.target as File).getDirectoryListing();
				callBack(list, (e.target as File).nativePath);
			}); 			
		}
		
		public static function getgetFilesVector(list:Array):Array			
		{
			var vect:Array = new Array();
			for(var i:uint=0; i < list.length; i++)
			{
				var byte:ByteArray = new ByteArray();
				var subfile:File = list[i] as File;
				var stream:FileStream = new FileStream();
				stream.open(subfile,FileMode.READ);
				stream.readBytes(byte,0,stream.bytesAvailable);
				stream.close();
				vect.push({label : subfile.name, data : byte.readUTFBytes(byte.bytesAvailable) , nativePath : subfile.nativePath});
//				trace("路径：",subfile.nativePath,"文件名：",subfile.name);
			}
			return vect;
		}
		
	}
}