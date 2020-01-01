run("Viewer");
dir = getDirectory("image");
name = getTitle();
prefix = substring (name, 0, lastIndexOf(name,".vsi"))+".vsi";
pic1=prefix+" Group:1 Level:1 Area:1";
pic2=prefix+" Group:2 Level:1 Area:1";

pic1_file = dir+"pic1.tif";
pic2_file = dir+"pic2.tif";
merge_file_name = dir+"merged.tif";

if(isOpen(pic2)) {
  selectWindow(pic1);
  run("RGB Color");
  saveAs("Tiff", pic1_file);


  selectWindow(pic2);
  run("RGB Color");
  saveAs("Tiff", pic2_file);

  run("Merge Channels...", "c1=["+pic1+"] c2=["+pic2+"] create");
  selectWindow("Composite");
  run("RGB Color");
  saveAs("Tiff", merge_file_name);
  selectWindow("Composite");
  close("Composite");
}else{

  run("RGB Color");
  run("Image Sequence... ", "format=TIFF save="+pic1_file);
  run("Make Composite");

  selectWindow(pic1);
  run("Make Composite");
  run("RGB Color");
  saveAs("Tiff", merge_file_name);

}
