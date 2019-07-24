package game.core.manager
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;

	/**
	 * FileManager 
	 * @author zcp
	 */	
	public class FileManager
	{
		public function FileManager()
		{
			throw new Event("can not new!");
		}

		/**
		 * 保存二进制文件
		 * 
		 */	
		public static function saveFile($ba:ByteArray,$path:String):void
		{
			var file:File = new File($path);
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.WRITE);
			$ba.position = 0;
			fs.writeBytes($ba,0,$ba.bytesAvailable);
			fs.close();
			return;
		}
		/**
		 * 读取二进制文件
		 * 
		 */	
		public static function readFile($path:String):ByteArray
		{
			var ba:ByteArray = new ByteArray();
			
			var file:File = new File($path);
			if(file.exists)
			{
				var fs:FileStream = new FileStream();          
				fs.open(file,FileMode.READ);
				fs.position = 0;
				fs.readBytes(ba,0,fs.bytesAvailable)
				fs.close();
			}
			return ba;
		}	
		
		/**
		 * 保存文本文件
		 * 
		 */	
		public static function saveText($str:String,$path:String):void
		{
			var file:File = new File($path);
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.WRITE);
			fs.writeUTFBytes($str)
			fs.close();
			return;
		}
		/**
		 * 读取文本文件
		 * 
		 */	
		public static function readText($path:String):String
		{
			var str:String;
			
			var file:File = new File($path);
			if(file.exists)
			{
				var fs:FileStream = new FileStream();          
				fs.open(file,FileMode.READ);
				str = fs.readUTFBytes(fs.bytesAvailable);
				fs.close();
			}
			return str;
		}
		
		
		
		/**
		 * 保存XML文件
		 * 
		 */	
		public static function saveXML($xml:XML,$path:String):void
		{
			var file:File = new File($path);
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.WRITE);
			fs.writeUTFBytes($xml.toXMLString());
			fs.close();
			return;
		}
		/**
		 * 保存json文件
		 * 
		 */	
		public static function saveJSON(json:String,$path:String, callBack:Function = null):void
		{
			var file:File = new File($path);
			var fs:FileStream = new FileStream();
			fs.openAsync(file,FileMode.WRITE);
			fs.writeUTFBytes(json);			
			fs.addEventListener(Event.CLOSE, function(e:Event):void
			{
				if(callBack != null)
					callBack();
			});
			fs.close();
			return;
		}
		/**
		 * 读取XML文件
		 * 
		 */	
		public static function readXML($path:String):XML
		{
			var xml:XML;
			
			var file:File = new File($path);
			if(file.exists)
			{
				var fs:FileStream = new FileStream();          
				fs.open(file,FileMode.READ);
				xml = XML(fs.readUTFBytes(fs.bytesAvailable));
				fs.close();
			}
			return xml;
		}	
		/**
		 * 获取所有指定扩展名的文件（不包括隐藏目录内的文件,不包括隐藏文件）的一个数组
		 * @param $eNames 举例：[".xml",".swf"]，为保证效率，程序里不做大小写转换，所以参数应保证输入扩展名为小写, 不限制则请传null
		 * return 格式：[file:File...]
		 */	
		public static function getFiles($directory:File,$eNames:Array=null):Array
		{
			var files:Array = [];
			if(!$directory.isHidden && $directory.name!=".svn")
			{
				var childFiles:Array = $directory.getDirectoryListing();
				for each(var file:File in childFiles)
				{
					var eName:String = file.url.replace(/^.+(\.[A-Za-z\d_]+)$/,"$1").toLowerCase();
					if((!file.isDirectory) && (!file.isHidden) && ($eNames==null || $eNames.indexOf(eName)!=-1))
					{
						files.push(file);
					}
				}
			}
			return files;
		}
		/**
		 * 获取指定目录下的所有文件夹（不包括隐藏目录内的文件,不包括隐藏文件）的一个数组
		 * @param $ignoreFolders 忽略的文件夹数组，如果传null则不忽略任何文件夹
		 * return 格式：[file:File...]
		 */	
		public static function getDirs($directory:File, $ignoreFolders:Array=null):Array
		{
			var files:Array = [];
			if(!$directory.isHidden && $directory.name!=".svn")
			{
				var childFiles:Array = $directory.getDirectoryListing();
				for each(var file:File in childFiles)
				{
					if(
						file.isDirectory
						&& 
						(!file.isHidden) 
						&&
						file.name!=".svn"
						&& 
						($ignoreFolders==null || $ignoreFolders.indexOf(file.name)==-1)
					)
					{
						files.push(file);
					}
				}
			}
			return files;
		}
		

		/**
		 * (递归)获取所有指定扩展名的文件（包括子目录内的,不包括隐藏目录内的文件,不包括隐藏文件）的一个数组
		 * @param $eNames 举例：[".xml",".swf"]，为保证效率，程序里不做大小写转换，所以参数应保证输入扩展名为小写
		 * return 格式：[file:File...]
		 */	
		public static function getAllFiles($directory:File,$eNames:Array):Array
		{
			//if($eName.charAt(0)!=".")$eName += ".";
			var files:Array = new Array();
			if(!$directory.isHidden && $directory.name!=".svn")
			{
				if(!$directory.isDirectory)
				{
					var eName:String = $directory.url.replace(/^.+(\.[A-Za-z\d_]+)$/,"$1").toLowerCase();
					if($eNames.indexOf(eName)!=-1)
					{
						files.push($directory);
					}
				}
				else
				{
					var childFiles:Array = $directory.getDirectoryListing();
					for(var i:uint = 0; i < childFiles.length; i++)
					{
						files = files.concat(getAllFiles(childFiles[i],$eNames));
					}
				}
			}
			return files;
		}
		
		/**(递归)
		 * 获取指定目录下的所有文件夹（不包括隐藏目录内的文件,不包括隐藏文件）的一个数组
		 * @param $ignoreFolders 忽略的文件夹数组，如果传null则不忽略任何文件夹
		 * return 格式：[file:File...]
		 */	
		public static function getAllDirs($directory:File, $ignoreFolders:Array=null):Array
		{
			var files:Array = [];
			if(!$directory.isHidden)
			{
				var childFiles:Array = $directory.getDirectoryListing();
				for each(var file:File in childFiles)
				{
					if(
						file.isDirectory 
						&& 
						(!file.isHidden) 
						&& 
						file.name!=".svn"
						&& 
						($ignoreFolders==null || $ignoreFolders.indexOf(file.name)==-1)
					)
					{
						files.push(file);
						files = files.concat(getAllDirs(file, $ignoreFolders));
					}
				}
			}
			return files;
		}
	}
}