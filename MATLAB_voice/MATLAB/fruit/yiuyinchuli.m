clear
global hpop hlist
clf reset
H=axes('unit','normalized','position',[0,0,1,1],'visible','off');
set(gcf,'currentaxes',H);
str='\fontname{����}';
h_fig=get(H,'parent');
set(h_fig,'unit','normalized','position',[0.1,0.2,0.7,0.6]);
 hlist=uicontrol(h_fig,'style','list','unit','normalized',...
     'position',[0.7,0.6,0.2,0.2],...
    'string','¼��|�˲�|��֡|�˵���|¼���ط�','MAX',2);
hpush=uicontrol(h_fig,'style','push','unit','normalized',...
    'position',[0.76,0.32,0.1,0.06],'string',{'����'},'callback',...
 'yuyin');