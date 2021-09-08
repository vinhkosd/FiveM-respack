/*
██╗      ██████╗ ██████╗ ██████╗  █████╗ ██╗  ██╗███████╗
██║     ██╔═══██╗██╔══██╗██╔══██╗██╔══██╗╚██╗██╔╝██╔════╝
██║     ██║   ██║██████╔╝██████╔╝███████║ ╚███╔╝ ███████╗
██║     ██║   ██║██╔══██╗██╔══██╗██╔══██║ ██╔██╗ ╚════██║
███████╗╚██████╔╝██║  ██║██║  ██║██║  ██║██╔╝ ██╗███████║
╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
*/
var Config = new Object();
Config.rotateCount = 10; // số vòng quay trước khi kết thúc
Config.timeRotate = 10000; // thời gian quay (giây) x 1000
Config.slot15percent = [];  // 15% 
Config.slot10percent = [2, 6, 11, 14, 8, 20]; // 10%
Config.slot5percent = [12, 13, 17, 12, 13, 17]; // 5%
Config.slot4percent = [12, 13]; // 4%
Config.slot1percent = [4]; //  1%
Config.slot05percent = [16]; // 0.5%
Config.slot02percent = [10, 17]; //0.2 %
Config.slot005percent = [18]; // 0.05%
Config.slot001percent = [3, 7, 9, 15]; // 0.01% 
Config.slot0005percent = [1, 5]; //0.005%
Config.rest = [2, 6, 11, 14, 8, 20]; // nếu không trúng vào những thứ ở trên, sẽ random ở đây
//Tổng cộng phải nhỏ hơn hoặc bằng 100%


