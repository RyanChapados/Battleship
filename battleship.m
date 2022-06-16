%function [word,rounds] = play_Battleship
clear all;close all
hold on
fig=figure(1); %creates figure
clf %clears figure
set(fig,'Position',[150,50,1200,700]); %sets the position and dimensions
logo_square = rectangle('Position',[115 195 150 30],'EdgeColor','black','FaceColor','black','LineWidth',3); %creates rectangle
%AI_square = rectangle('Position',[10 10 180 180],'EdgeColor',[0.42,0.78,0.93],'FaceColor',[0.42,0.78,0.93],'LineWidth',3); %creates rectangle
%Player_square = rectangle('Position',[210 10 180 180],'EdgeColor',[0.42,0.78,0.93],'FaceColor',[0.42,0.78,0.93],'LineWidth',3); %creates rectangle
logo_txt = text(125,210,'BATTLESHIP','FontSize',30,'color','white','FontWeight','bold'); %plots title
axis off

%draws the initial board
for a = 0:17 %creates loop for x axis
    for b = 0:8 %creates loop for y axis
        if a <= 8
            x(a+1) = 20*a+10;
        else
            x(a+1) = 20*a+20;
        end
        y(b+1) = 20*b+10;
        if a == 0 || b == 0 || a == 9
            ColorSwitch = 'white';
        else
            ColorSwitch = [0.42,0.78,0.93];
        end
        sqr(a+1,b+1) = rectangle('Position',[x(a+1),y(b+1),20,20],'EdgeColor','black','FaceColor',ColorSwitch,'LineWidth',3); %creates rectangle
        TileColor(a+1,b+1) = {sqr(a+1,b+1).FaceColor};
    end %end
end %end

%new comment here thats super important
