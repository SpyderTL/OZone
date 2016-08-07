using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.IO;

namespace OZone.Projects
{
	public static class ProjectReader
	{
		public static Project Read(string filename)
		{
			var project = new Project { Name = Path.GetFileNameWithoutExtension(filename) };

			using(var reader = XmlTextReader.Create(filename))
			{
				while(reader.Read())
				{
					switch(reader.Name)
					{
						case "path":
							project.Paths.Add(reader.ReadString());
							break;

						case "transform":
							project.Transforms.Add(new ProjectTransform { Namespace = reader.GetAttribute("namespace"), Path = reader.GetAttribute("path") });
							break;

						case "program":
							var program = new ProjectFile
							{
								Type = ProjectFileType.Program,
								Path = reader.GetAttribute("path"),
								OutputPath = Path.Combine(project.Name, reader.GetAttribute("path"))
							};

							var address = reader.GetAttribute("address");

							if(address != null)
								program.Address = new OZone.Programs.MemoryAddress
								{
									Offset = uint.Parse(address, System.Globalization.NumberStyles.HexNumber)
								};

							var block = reader.GetAttribute("block");

							if(block != null)
								program.Block = int.Parse(block);

							project.Files.Add(program);
							break;

						case "image":
							var resource = new ProjectFile
							{
								Type = ProjectFileType.Image,
								Path = reader.GetAttribute("path"),
								OutputPath = Path.Combine(project.Name, reader.GetAttribute("path") + ".xml")
							};

							var address2 = reader.GetAttribute("address");

							if(address2 != null)
								resource.Address = new OZone.Programs.MemoryAddress
								{
									Offset = uint.Parse(address2, System.Globalization.NumberStyles.HexNumber)
								};

							project.Files.Add(resource);
							break;
					}
				}
			}

			return project;
		}
	}
}
