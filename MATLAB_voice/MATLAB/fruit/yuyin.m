global hlist
B=get(hlist,'value');
switch B
    case 1
      fs = 10000;
      x = wavread('a.wav');%��������
      subplot('position',[0.001,0.03,1,0.8]),plot(x);...
         title('ԭͼ');
      axis square;axis off
 
    case 2
       I=imread('bonemarr.tif');
       J=imadjust(I,[0 1],[1 0],1.3);
       subplot('position',[0.05,0.6,0.3,0.3]),subplot('position',[0.05,0.6,0.3,0.3]),imshow(I);...
           title('ԭͼ');
       axis square;axis off
       subplot('position',[0.38,0.6,0.3,0.3]),imshow(J),title('������');
        
     case 3
        f=enframe(x,10);
        subplot('position',[0.05,0.6,0.3,0.3]),subplot('position',[0.05,0.6,0.3,0.3]),plot(x);...
            title('ԭͼ');
        axis square;axis off
        subplot('position',[0.38,0.6,0.3,0.3]),plot(f),title('��֡��');

     case 4
        [x1,x2] = vad(x)

     case 5
        wavplay(x);
end