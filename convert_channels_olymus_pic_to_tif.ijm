///
/// \file      convert_channels_olymus_pic_to_tif.ijm
/// \author    Melanie Schuerz
/// \author    Joachim Danmayr
/// \brief     Converts Olympus vis files to tif images
///            This script supports up two three channels



run("Viewer");
dir = getDirectory("image");
name = getTitle();
prefix = substring (name, 0, lastIndexOf(name,".vsi"))+".vsi";
pic1=prefix+" Group:1 Level:1 Area:1";
pic2=prefix+" Group:2 Level:1 Area:1";
pic3=prefix+" Group:3 Level:1 Area:1";

pic1_file = dir+"pic1.tif";
pic2_file = dir+"pic2.tif";
pic3_file = dir+"pic2.tif";
merge_file_name = dir+"merged.tif";

//
// Check if it is a file with multi widow or sequence
//
if(isOpen(pic2)) {
// Multi widow files

  selectWindow(pic1);
  run("RGB Color");
  saveAs("Tiff", pic1_file);

  selectWindow(pic2);
  run("RGB Color");
  saveAs("Tiff", pic2_file);

 
  if(isOpen(pic3)){
    // Three pictures found
    selectWindow(pic3);
    run("RGB Color");
    saveAs("Tiff", pic3_file);
    
    run("Merge Channels...", "c1=["+pic1+"] c2=["+pic2+"] c3=["+pic3+"] create");
  } else {
    // Just two merges
    run("Merge Channels...", "c1=["+pic1+"] c2=["+pic2+"] create");
  }
  
  selectWindow("Composite");
  run("RGB Color");
  saveAs("Tiff", merge_file_name);
  selectWindow("Composite");
  close("Composite");

}else{
  
  // All channels are stored in one window in a sequence
  
  run("RGB Color");
  run("Image Sequence... ", "format=TIFF save="+pic1_file);
  run("Make Composite");

  selectWindow(pic1);
  run("Make Composite");
  run("RGB Color");
  saveAs("Tiff", merge_file_name);
}
