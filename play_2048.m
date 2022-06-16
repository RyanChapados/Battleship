%function [word,rounds] = play_wordleBJS(mode,grader_word) %defines function play_wordle with possible inputs for mode and grader_word
clear all
close all
hold on
color_tab = {'#EEE4DA','2';'#EDE0C8','4';'#F2B179','8';'#F59563','16';'#F67C5F','32';'#F65E3B','64';'#EDCF72','128'; '#EDCC61','256';'#EDC850','512';'#EDC53F','1024';'#EDC22E', '2048'};

fig=figure(1); %creates figure
clf %clears figure
set(fig,'Position',[fig.Position(1),fig.Position(2),660,860]); %sets the position and dimensions
x = [20 190 360 530 700]; %x vector for the boxes
y = [20 190 360 530 700]; %y vector for the boxes
logo_square = rectangle('Position',[0 760 175 175],'EdgeColor','#EDC22E','FaceColor','#EDC22E','LineWidth',3,'Curvature',[0.1 0.1]); %creates rectangle
background_square = rectangle('Position',[0 0 700 700],'EdgeColor','#c9b5a1','FaceColor','#c9b5a1','LineWidth',3,'Curvature',[0.01 0.01]); %creates rectangle
score_square = rectangle('Position',[330 760 175 175],'EdgeColor','#c9b5a1','FaceColor','#c9b5a1','LineWidth',3,'Curvature',[0.1 0.1]); %creates rectangle
best_square = rectangle('Position',[525 760 175 175],'EdgeColor','#c9b5a1','FaceColor','#c9b5a1','LineWidth',3,'Curvature',[0.1 0.1]); %creates rectangle
logo_txt = text(4,850,'2048','FontSize',55,'color','white','FontWeight','bold'); %plots title
score_txt = text(370,900,'SCORE','FontSize',20,'color','white','FontWeight','bold'); %plots title
best_txt = text(575,900,'BEST','FontSize',20,'color','white','FontWeight','bold'); %plots title
score1 = 0;
best1 = 0;
score_val_txt = text(410,830,num2str(score1),'FontSize',30,'color','white','FontWeight','bold');
best_val_txt = text(600,830,num2str(best1),'FontSize',30,'color','white','FontWeight','bold');
TileVal = zeros(4,4);
%% Creates initial board
for a = 1:4 %creates loop for rows
    for b = 1:4 %creates loop for columns
        hold on %turns hold on
        sqr(a,b) = rectangle('Position',[x(a),y(b),150,150],'EdgeColor','#e0d3c5','FaceColor','#e0d3c5','LineWidth',3,'Curvature',[0.1 0.1]); %creates rectangle
        TileColor(a,b) = {sqr(a,b).FaceColor};
        TileColor1 = {sqr(1,1).FaceColor};
    end %end
end %end
axis off %turns axes off
starttiles_pos = randi([1 4],1,4);
give_val = [2 2 2 2 4];
starttiles_val_ind = randi([1 5],1,2);
starttiles_val = give_val(starttiles_val_ind);
while starttiles_pos(1)==starttiles_pos(3) && starttiles_pos(2)==starttiles_pos(4)
    starttiles_pos(3) = randi([1 4],1,1);
    starttiles_pos(4) = randi([1 4],1,1);
    continue
end
for c1 = 1:2
    if c1 == 1
        for c2 = 1:size(color_tab,1)
            while num2str(starttiles_val(1,c1)) == color_tab{c2,2}
                startsqr1 = rectangle('Position',[x(starttiles_pos(1)),y(starttiles_pos(2)),150,150],'EdgeColor',color_tab{c2,1},'FaceColor',color_tab{c2,1},'LineWidth',3,'Curvature',[0.1 0.1]); %creates rectangle
                TileColor(starttiles_pos(1),starttiles_pos(2)) = {startsqr1.FaceColor};
                txt(starttiles_pos(1),starttiles_pos(2)) = text(x(starttiles_pos(1))+55,y(starttiles_pos(2))+75,num2str(starttiles_val(1,c1)),'FontSize',55,'color','#776e65','FontWeight','bold'); %plots title
                TileVal(starttiles_pos(1),starttiles_pos(2)) = starttiles_val(1,c1);
                break
            end
        end
    elseif c1 == 2
        for c2 = 1:size(color_tab,1)
            while num2str(starttiles_val(1,c1)) == color_tab{c2,2}
                startsqr2 = rectangle('Position',[x(starttiles_pos(3)),y(starttiles_pos(4)),150,150],'EdgeColor',color_tab{c2,1},'FaceColor',color_tab{c2,1},'LineWidth',3,'Curvature',[0.1 0.1]); %creates rectangle
                TileColor(starttiles_pos(3),starttiles_pos(4)) = {startsqr2.FaceColor};
                txt(starttiles_pos(3),starttiles_pos(4)) = text(x(starttiles_pos(3))+55,y(starttiles_pos(4))+75,num2str(starttiles_val(1,c1)),'FontSize',55,'color','#776e65','FontWeight','bold'); %plots title
                TileVal(starttiles_pos(3),starttiles_pos(4)) = starttiles_val(1,c1);
                break
            end
        end
    end
end
%% Checks for any equal adjacent values
for a = 1:4 %creates loop for rows
    for b = 1:4 %creates loop for columns
        if a == 1
            if b == 1
                if TileVal(a,b) == 0
                    anyequal(a,b)= 0;
                else
                    anyequal(a,b) = TileVal(a,b)==TileVal(a+1,b) || TileVal(a,b)==TileVal(a,b+1);
                end
            elseif b == 4
                if TileVal(a,b) == 0
                    anyequal(a,b)= 0;
                else
                    anyequal(a,b) = TileVal(a,b)==TileVal(a+1,b) || TileVal(a,b)==TileVal(a,b-1);
                end
            else
                if TileVal(a,b) == 0
                    anyequal(a,b)= 0;
                else
                    anyequal(a,b) = TileVal(a,b) == TileVal(a+1,b)||TileVal(a,b)==TileVal(a,b-1)|| TileVal(a,b)==TileVal(a,b+1);
                end
            end
        elseif a==2 || a==3
            if b == 1
                if TileVal(a,b) == 0
                    anyequal(a,b)= 0;
                else
                    anyequal(a,b) = TileVal(a,b)==TileVal(a+1,b) || TileVal(a,b)==TileVal(a,b+1)||TileVal(a,b)==TileVal(a-1,b);
                end
            elseif b == 4
                if TileVal(a,b) == 0
                    anyequal(a,b)= 0;
                else
                    anyequal(a,b) = TileVal(a,b)==TileVal(a+1,b) || TileVal(a,b)==TileVal(a,b-1)||TileVal(a,b)==TileVal(a-1,b);
                end
            else
                if TileVal(a,b) == 0
                    anyequal(a,b)= 0;
                else
                    anyequal(a,b) = TileVal(a,b) == TileVal(a+1,b)||TileVal(a,b)==TileVal(a,b-1)|| TileVal(a,b)==TileVal(a,b+1)||TileVal(a,b)==TileVal(a-1,b);
                end
            end
        else
            if b == 1
                if TileVal(a,b) == 0
                    anyequal(a,b)= 0;
                else
                    anyequal(a,b) = TileVal(a,b)==TileVal(a-1,b) || TileVal(a,b)==TileVal(a,b+1);
                end
            elseif b == 4
                if TileVal(a,b) == 0
                    anyequal(a,b)= 0;
                else
                    anyequal(a,b) = TileVal(a,b)==TileVal(a-1,b) || TileVal(a,b)==TileVal(a,b-1);
                end
            else
                if TileVal(a,b) == 0
                    anyequal(a,b)= 0;
                else
                    anyequal(a,b) = TileVal(a,b) == TileVal(a-1,b)||TileVal(a,b)==TileVal(a,b-1)|| TileVal(a,b)==TileVal(a,b+1);
                    
                end
            end
        end
    end
end
while any(any(TileVal))||any(any(anyequal~=0))
    [~,~,direction]=ginput(1); %attained from {https://stackoverflow.com/questions/43426469/how-to-make-matlab-detect-keyboard-stroke-arrows-and-record-the-data, Gelliant, @ 13:23 Apr 15, 2017 }
    
    NewTileVal = TileVal;
    if direction == 30 %up
        
        %% Checks for equal adjacent values above
        for i = 1:4 %creates loop for rows
            for j = 1:4 %creates loop for columns
                if j == 4
                    equal_up(i,j)= 0;
                else
                    if NewTileVal(i,j) ~= 0 && NewTileVal(i,j)==NewTileVal(i,j+1)
                        equal_up(i,j)= 1;
                    else
                        equal_up(i,j) = 0;
                    end
                end
            end
        end
        combine = zeros(4,1);
        for a = 1:4 %creates loop for rows
            for b = 1:4 %creates loop for columns
                z = 1;
                position =  sqr(a,5-b).Position(2);
                while position < 530 && TileVal(a,5-b)~=0 && (TileVal(a,5-b+z) == 0 || equal_up(a,5-b) == 1|| equal_up(a,5-b+z-1) == 1) && combine(a,:) == 0
                    combine = zeros(4,1);
                    sqr(a,5-b+z) = rectangle('Position',[x(a),y(5-b+z),150,150],'EdgeColor',TileColor{a,5-b},'FaceColor',TileColor{a,5-b},'LineWidth',3,'Curvature',[0.1 0.1]); %creates rectangle
                    txt(a,5-b) = text((sqr(a,5-b).Position(1)+sqr(a,5-b).Position(3)/2-20),y(5-b+z)+75,num2str(TileVal(a,5-b)),'FontSize',55,'color','#776e65','FontWeight','bold'); %plots title
                    NewTileVal(a,5-b+z) = TileVal(a,5-b);
                    if sqr(a,5-b+z).Position(2) ~= sqr(a,5-b+z-1).Position(2)
                        sqr(a,5-b+z-1) = rectangle('Position',[x(a),y(5-b+z-1),150,150],'EdgeColor','#e0d3c5','FaceColor','#e0d3c5','LineWidth',3,'Curvature',[0.1 0.1]); %creates rectangle
                        NewTileVal(a,5-b+z-1) = 0;
                    end
                    if equal_up(a,5-b+z-1) == 1 && combine(a,:) == 0
                        NewTileVal(a,5-b+z) = TileVal(a,5-b)+ TileVal(a,5-b+z);
                        score = TileVal(a,5-b)+ TileVal(a,5-b+z) + score1;
                        if score > best1
                            best = TileVal(a,5-b)+ TileVal(a,5-b+z) + score1;
                        end
                        delete(score_val_txt)
                        delete(best_val_txt)
                        score_txt_pos = 410-15*(length(num2str(score))-1);
                        best_txt_pos= 600-15*(length(num2str(best))-1);
                        score_val_txt = text(score_txt_pos,830,num2str(score),'FontSize',30,'color','white','FontWeight','bold');
                        best_val_txt = text(best_txt_pos,830,num2str(best),'FontSize',30,'color','white','FontWeight','bold');
                        score1 = score;
                        best1 = best;
                        
                        sqr(a,5-b+z) = rectangle('Position',[x(a),y(5-b+z),150,150],'EdgeColor',TileColor{a,5-b},'FaceColor',TileColor{a,5-b},'LineWidth',3,'Curvature',[0.1 0.1]); %creates rectangle
                        
                        if NewTileVal(a,5-b+z)< 5
                            txt(a,5-b) = text((sqr(a,5-b).Position(1)+sqr(a,5-b).Position(3)/2-20),y(5-b+z)+75,num2str(NewTileVal(a,5-b+z)),'FontSize',55,'color','#776e65','FontWeight','bold'); %plots title
                        else
                            txt(a,5-b) = text((sqr(a,5-b).Position(1)+sqr(a,5-b).Position(3)/2-20),y(5-b+z)+75,num2str(NewTileVal(a,5-b+z)),'FontSize',55,'color','white','FontWeight','bold'); %plots title
                        end
                        if NewTileVal(a,5-b+z) == 2
                            sqr(a,5-b+z).FaceColor = color_tab{1,:};
                            sqr(a,5-b+z).EdgeColor = color_tab{1,:};
                        elseif NewTileVal(a,5-b+z) == 4
                            sqr(a,5-b+z).FaceColor = color_tab{2,:};
                            sqr(a,5-b+z).EdgeColor = color_tab{2,:};
                        elseif NewTileVal(a,5-b+z) == 8
                            sqr(a,5-b+z).FaceColor = color_tab{3,:};
                            sqr(a,5-b+z).EdgeColor = color_tab{3,:};
                        elseif NewTileVal(a,5-b+z) == 16
                            sqr(a,5-b+z).FaceColor = color_tab{4,:};
                            sqr(a,5-b+z).EdgeColor = color_tab{4,:};
                            txt(a,5-b).Position(1) = txt(a,5-b).Position(1)-20;
                        elseif NewTileVal(a,5-b+z) == 32
                            sqr(a,5-b+z).FaceColor = color_tab{5,:};
                            sqr(a,5-b+z).EdgeColor = color_tab{5,:};
                            txt(a,5-b).Position(1) = txt(a,5-b).Position(1)-20;
                        elseif NewTileVal(a,5-b+z) == 64
                            sqr(a,5-b+z).FaceColor = color_tab{6,:};
                            sqr(a,5-b+z).EdgeColor = color_tab{6,:};
                            txt(a,5-b).Position(1) = txt(a,5-b).Position(1)-20;
                        elseif NewTileVal(a,5-b+z) == 128
                            sqr(a,5-b+z).FaceColor = color_tab{7,:};
                            sqr(a,5-b+z).EdgeColor = color_tab{7,:};
                            
                        elseif NewTileVal(a,5-b+z) == 256
                            sqr(a,5-b+z).FaceColor = color_tab{8,:};
                            sqr(a,5-b+z).EdgeColor = color_tab{8,:};
                            
                        elseif NewTileVal(a,5-b+z) == 512
                            sqr(a,5-b+z).FaceColor = color_tab{9,:};
                            sqr(a,5-b+z).EdgeColor = color_tab{9,:};
                            
                        elseif NewTileVal(a,5-b+z) == 1024
                            sqr(a,5-b+z).FaceColor = color_tab{10,:};
                            sqr(a,5-b+z).EdgeColor = color_tab{10,:};
                            
                        elseif NewTileVal(a,5-b+z) == 2048
                            sqr(a,5-b+z).FaceColor = color_tab{11,:};
                            sqr(a,5-b+z).EdgeColor = color_tab{11,:};
                        else
                            sqr(a,5-b+z).FaceColor = [0.47,1.00,0.65];
                            sqr(a,5-b+z).EdgeColor = [0.47,1.00,0.65];
                        end
                        combine(a,:) = 1;
                    end
                    position = sqr(a,5-b+z).Position(2);
                    if 5-b+z < 4
                        z = z+1;
                    end
                    for i = 1:4 %creates loop for rows
                        for j = 1:4 %creates loop for columns
                            if j == 4
                                equal_up(i,j)= 0;
                            else
                                if NewTileVal(i,j) ~= 0 && NewTileVal(i,j)==NewTileVal(i,j+1)
                                    equal_up(i,j)= 1;
                                else
                                    equal_up(i,j) = 0;
                                end
                            end
                        end
                    end
                    continue
                end
                TileVal = NewTileVal;
            end
        end
        
        %% Moves Bottom Tiles up
        for xtra_move = 1:4
            z = 1;
            position =  sqr(xtra_move,1).Position(2);
            while position < 530 && TileVal(xtra_move,1)~=0 && TileVal(xtra_move,1+z) == 0
                combine = zeros(4,1);
                sqr(xtra_move,1+z) = rectangle('Position',[x(xtra_move),y(1+z),150,150],'EdgeColor',TileColor{xtra_move,1},'FaceColor',TileColor{xtra_move,1},'LineWidth',3,'Curvature',[0.1 0.1]); %creates rectangle
                txt(xtra_move,1) = text((sqr(xtra_move,1).Position(1)+sqr(xtra_move,1).Position(3)/2-20),y(1+z)+75,num2str(TileVal(xtra_move,1)),'FontSize',55,'color','#776e65','FontWeight','bold'); %plots title
                NewTileVal(xtra_move,1+z) = TileVal(xtra_move,1);
                if sqr(xtra_move,1+z).Position(2) ~= sqr(xtra_move,1+z-1).Position(2)
                    sqr(xtra_move,1+z-1) = rectangle('Position',[x(xtra_move),y(1+z-1),150,150],'EdgeColor','#e0d3c5','FaceColor','#e0d3c5','LineWidth',3,'Curvature',[0.1 0.1]); %creates rectangle
                    NewTileVal(xtra_move,1+z-1) = 0;
                end
                if 1+z < 4
                    z = z+1;
                end
            end
        end
        
        for h = 1:4 %creates loop for columns
            zero_loc(h) = TileVal(h,1)==0;
        end
        
        num_zero1 = size(find(TileVal==0),1);
        num_zero2 =size(find(zero_loc),2);
        num_zero = min([num_zero1 num_zero2]);
        
        if any(any(equal_up)) || any(any(TileVal(1:4,2:4)==0))
            if num_zero == 0
                continue
                
            elseif num_zero == 1 && any(find(TileVal==0)<5)
                newtiles_pos = randi([1 4],1);
                newtiles_val_ind = randi([1 5],1);
                newtiles_val = give_val(newtiles_val_ind);
                while zero_loc(newtiles_pos) == 0
                    range = zero_loc.*[1:4];
                    range1 = find(range);
                    newtiles_pos = randi([min(range1) max(range1)],1);
                end
                
            elseif num_zero >= 2 && any(find(TileVal==0)<5)
                newtiles_pos = randi([1 4],1,2);
                newtiles_val_ind = randi([1 5],1,2);
                newtiles_val = give_val(newtiles_val_ind);
                while newtiles_pos(1)==newtiles_pos(2) || (zero_loc(newtiles_pos(1)) == 0 ||zero_loc(newtiles_pos(2)) == 0)
                    range = zero_loc.*[1:4];
                    range1 = find(range);
                    newtiles_pos(1) = randi([min(range1) max(range1)],1,1);
                    newtiles_pos(2) = randi([min(range1) max(range1)],1,1);
                    continue
                end
            end
            if num_zero == 0
                
            elseif num_zero == 1 && any(find(TileVal==0)<5)
                c1 = 1;
                for c2 = 1:size(color_tab,1)
                    while num2str(newtiles_val(1,c1)) == color_tab{c2,2}
                        newsqr1 = rectangle('Position',[x(newtiles_pos(1)),y(1),150,150],'EdgeColor',color_tab{c2,1},'FaceColor',color_tab{c2,1},'LineWidth',3,'Curvature',[0.1 0.1]); %creates rectangle
                        TileColor(newtiles_pos(1),1) = {newsqr1.FaceColor};
                        text(x(newtiles_pos(1))+55,y(1)+75,num2str(newtiles_val(1,c1)),'FontSize',55,'color','#776e65','FontWeight','bold') %plots title
                        TileVal(newtiles_pos(1),1) = newtiles_val(1,c1);
                        break
                    end
                end
                
            elseif num_zero >= 2 && any(find(TileVal==0)<5)
                for c1 = 1:2
                    if c1 == 1
                        for c2 = 1:size(color_tab,1)
                            while num2str(newtiles_val(1,c1)) == color_tab{c2,2}
                                newsqr1 = rectangle('Position',[x(newtiles_pos(1)),y(1),150,150],'EdgeColor',color_tab{c2,1},'FaceColor',color_tab{c2,1},'LineWidth',3,'Curvature',[0.1 0.1]); %creates rectangle
                                TileColor(newtiles_pos(1),1) = {newsqr1.FaceColor};
                                text(x(newtiles_pos(1))+55,y(1)+75,num2str(newtiles_val(1,c1)),'FontSize',55,'color','#776e65','FontWeight','bold') %plots title
                                TileVal(newtiles_pos(1),1) = newtiles_val(1,c1);
                                break
                            end
                        end
                    elseif c1 == 2
                        for c2 = 1:size(color_tab,1)
                            while num2str(newtiles_val(1,c1)) == color_tab{c2,2}
                                newsqr1 = rectangle('Position',[x(newtiles_pos(2)),y(1),150,150],'EdgeColor',color_tab{c2,1},'FaceColor',color_tab{c2,1},'LineWidth',3,'Curvature',[0.1 0.1]); %creates rectangle
                                TileColor(newtiles_pos(2),1) = {newsqr1.FaceColor};
                                text(x(newtiles_pos(2))+55,y(1)+75,num2str(newtiles_val(1,c1)),'FontSize',55,'color','#776e65','FontWeight','bold') %plots title
                                TileVal(newtiles_pos(2),1) = newtiles_val(1,c1);
                                break
                            end
                        end
                    end
                end
            end
        end
        for a = 1:4
            for b = 1:4
                if TileVal(a,5-b) == 2
                    TileColor{a,5-b} = color_tab{1,:};
                    sqr(a,5-b).FaceColor = color_tab{1,:};
                    sqr(a,5-b).EdgeColor = color_tab{1,:};
                elseif TileVal(a,5-b) == 4
                    TileColor{a,5-b} = color_tab{2,:};
                    sqr(a,5-b).FaceColor = color_tab{2,:};
                    sqr(a,5-b).EdgeColor = color_tab{2,:};
                elseif  TileVal(a,5-b) == 8
                    TileColor{a,5-b} = color_tab{3,:};
                    sqr(a,5-b).FaceColor = color_tab{3,:};
                    sqr(a,5-b).EdgeColor = color_tab{3,:};
                elseif  TileVal(a,5-b) == 16
                    TileColor{a,5-b} = color_tab{4,:};
                    sqr(a,5-b).FaceColor = color_tab{4,:};
                    sqr(a,5-b).EdgeColor = color_tab{4,:};
                elseif  TileVal(a,5-b) == 32
                    TileColor{a,5-b} = color_tab{5,:};
                    sqr(a,5-b).FaceColor = color_tab{5,:};
                    sqr(a,5-b).EdgeColor = color_tab{5,:};
                elseif  TileVal(a,5-b) == 64
                    TileColor{a,5-b} = color_tab{6,:};
                    sqr(a,5-b).FaceColor = color_tab{6,:};
                    sqr(a,5-b).EdgeColor = color_tab{6,:};
                elseif  TileVal(a,5-b) == 128
                    TileColor{a,5-b} = color_tab{7,:};
                    sqr(a,5-b).FaceColor = color_tab{7,:};
                    sqr(a,5-b).EdgeColor = color_tab{7,:};
                elseif  TileVal(a,5-b) == 256
                    TileColor{a,5-b} = color_tab{8,:};
                    sqr(a,5-b).FaceColor = color_tab{8,:};
                    sqr(a,5-b).EdgeColor = color_tab{8,:};
                elseif  TileVal(a,5-b) == 512
                    TileColor{a,5-b} = color_tab{9,:};
                    sqr(a,5-b).FaceColor = color_tab{9,:};
                    sqr(a,5-b).EdgeColor = color_tab{9,:};
                elseif   TileVal(a,5-b) == 1024
                    TileColor{a,5-b} = color_tab{10,:};
                    sqr(a,5-b).FaceColor = color_tab{10,:};
                    sqr(a,5-b).EdgeColor = color_tab{10,:};
                elseif   TileVal(a,5-b) == 2048
                    TileColor{a,5-b} = color_tab{11,:};
                    sqr(a,5-b).FaceColor = color_tab{11,:};
                    sqr(a,5-b).EdgeColor = color_tab{11,:};
                elseif TileVal(a,5-b) > 2048
                    TileColor{a,5-b} = [0.47,1.00,0.65];
                    sqr(a,5-b).FaceColor = [0.47,1.00,0.65];
                    sqr(a,5-b).EdgeColor = [0.47,1.00,0.65];
                end
            end
        end
    elseif direction == 31 %down
        
        
        
        %% Checks for equal adjacent values below
        for i = 1:4 %creates loop for rows
            for j = 1:4 %creates loop for columns
                if j == 1
                    equal_down(i,j)= 0;
                else
                    if NewTileVal(i,j) ~= 0 && NewTileVal(i,j)==NewTileVal(i,j-1)
                        equal_down(i,j)= 1;
                    else
                        equal_down(i,j) = 0;
                    end
                end
            end
        end
        combine = zeros(4,1);
        for a = 1:4 %creates loop for rows
            for b = 1:4 %creates loop for columns
                z = 1;
                position =  sqr(a,b).Position(2);
                while position > 20 && TileVal(a,b)~=0 && (TileVal(a,b-z) == 0 || equal_down(a,b) == 1|| equal_down(a,b-z+1) == 1) && combine(a,:) == 0
                    combine = zeros(4,1);
                    sqr(a,b-z) = rectangle('Position',[x(a),y(b-z),150,150],'EdgeColor',TileColor{a,b},'FaceColor',TileColor{a,b},'LineWidth',3,'Curvature',[0.1 0.1]); %creates rectangle
                    txt(a,b) = text((sqr(a,b).Position(1)+sqr(a,b).Position(3)/2-20),y(b-z)+75,num2str(TileVal(a,b)),'FontSize',55,'color','#776e65','FontWeight','bold'); %plots title
                    NewTileVal(a,b-z) = TileVal(a,b);
                    if sqr(a,b-z).Position(2) ~= sqr(a,b-z+1).Position(2)
                        sqr(a,b-z+1) = rectangle('Position',[x(a),y(b-z+1),150,150],'EdgeColor','#e0d3c5','FaceColor','#e0d3c5','LineWidth',3,'Curvature',[0.1 0.1]); %creates rectangle
                        NewTileVal(a,b-z+1) = 0;
                    end
                    if equal_down(a,b-z+1) == 1 && combine(a,:) == 0
                        NewTileVal(a,b-z) = TileVal(a,b)+ TileVal(a,b-z);
                        score = TileVal(a,b)+ TileVal(a,b-z) + score1;
                        if score > best1
                            best = TileVal(a,b)+ TileVal(a,b-z) + score1;
                        end
                        delete(score_val_txt)
                        delete(best_val_txt)
                        score_txt_pos = 410-15*(length(num2str(score))-1);
                        best_txt_pos= 600-15*(length(num2str(best))-1);
                        score_val_txt = text(score_txt_pos,830,num2str(score),'FontSize',30,'color','white','FontWeight','bold');
                        best_val_txt = text(best_txt_pos,830,num2str(best),'FontSize',30,'color','white','FontWeight','bold');
                        score1 = score;
                        best1 = best;
                        
                        sqr(a,b-z) = rectangle('Position',[x(a),y(b-z),150,150],'EdgeColor',TileColor{a,b},'FaceColor',TileColor{a,b},'LineWidth',3,'Curvature',[0.1 0.1]); %creates rectangle
                        
                        if NewTileVal(a,b-z)< 5
                            txt(a,b) = text((sqr(a,b).Position(1)+sqr(a,b).Position(3)/2-20),y(b-z)+75,num2str(NewTileVal(a,b-z)),'FontSize',55,'color','#776e65','FontWeight','bold'); %plots title
                        else
                            txt(a,b) = text((sqr(a,b).Position(1)+sqr(a,b).Position(3)/2-20),y(b-z)+75,num2str(NewTileVal(a,b-z)),'FontSize',55,'color','white','FontWeight','bold'); %plots title
                        end
                        if NewTileVal(a,b-z) == 2
                            sqr(a,b-z).FaceColor = color_tab{1,:};
                            sqr(a,b-z).EdgeColor = color_tab{1,:};
                        elseif NewTileVal(a,b-z) == 4
                            sqr(a,b-z).FaceColor = color_tab{2,:};
                            sqr(a,b-z).EdgeColor = color_tab{2,:};
                        elseif NewTileVal(a,b-z) == 8
                            sqr(a,b-z).FaceColor = color_tab{3,:};
                            sqr(a,b-z).EdgeColor = color_tab{3,:};
                        elseif NewTileVal(a,b-z) == 16
                            sqr(a,b-z).FaceColor = color_tab{4,:};
                            sqr(a,b-z).EdgeColor = color_tab{4,:};
                            txt(a,b).Position(1) = txt(a,b).Position(1)-20;
                        elseif NewTileVal(a,b-z) == 32
                            sqr(a,b-z).FaceColor = color_tab{5,:};
                            sqr(a,b-z).EdgeColor = color_tab{5,:};
                            txt(a,b).Position(1) = txt(a,b).Position(1)-20;
                        elseif NewTileVal(a,b-z) == 64
                            sqr(a,b-z).FaceColor = color_tab{6,:};
                            sqr(a,b-z).EdgeColor = color_tab{6,:};
                            txt(a,b).Position(1) = txt(a,b).Position(1)-20;
                        elseif NewTileVal(a,b-z) == 128
                            sqr(a,b-z).FaceColor = color_tab{7,:};
                            sqr(a,b-z).EdgeColor = color_tab{7,:};
                            
                        elseif NewTileVal(a,b-z) == 256
                            sqr(a,b-z).FaceColor = color_tab{8,:};
                            sqr(a,b-z).EdgeColor = color_tab{8,:};
                            
                        elseif NewTileVal(a,b-z) == 512
                            sqr(a,b-z).FaceColor = color_tab{9,:};
                            sqr(a,b-z).EdgeColor = color_tab{9,:};
                            
                        elseif NewTileVal(a,b-z) == 1024
                            sqr(a,b-z).FaceColor = color_tab{10,:};
                            sqr(a,b-z).EdgeColor = color_tab{10,:};
                            
                        elseif NewTileVal(a,b-z) == 2048
                            sqr(a,b-z).FaceColor = color_tab{11,:};
                            sqr(a,b-z).EdgeColor = color_tab{11,:};
                        else
                            sqr(a,b-z).FaceColor = [0.47,1.00,0.65];
                            sqr(a,b-z).EdgeColor = [0.47,1.00,0.65];
                        end
                        combine(a,:) = 1;
                    end
                    position = sqr(a,b-z).Position(2);
                    if b-z > 1
                        z = z+1;
                    end
                    for i = 1:4 %creates loop for rows
                        for j = 1:4 %creates loop for columns
                            if j == 1
                                equal_down(i,j)= 0;
                            else
                                if NewTileVal(i,j) ~= 0 && NewTileVal(i,j)==NewTileVal(i,j-1)
                                    equal_down(i,j)= 1;
                                else
                                    equal_down(i,j) = 0;
                                end
                            end
                        end
                    end
                    continue
                end
                TileVal = NewTileVal;
            end
        end
        
        %% Moves Bottom Tiles down
        for xtra_move = 1:4
            z = 1;
            position =  sqr(xtra_move,1).Position(2);
            while position > 20 && TileVal(xtra_move,4)~=0 && TileVal(xtra_move,4-z) == 0
                combine = zeros(4,1);
                sqr(xtra_move,4-z) = rectangle('Position',[x(xtra_move),y(4-z),150,150],'EdgeColor',TileColor{xtra_move,4},'FaceColor',TileColor{xtra_move,4},'LineWidth',3,'Curvature',[0.1 0.1]); %creates rectangle
                txt(xtra_move,4) = text((sqr(xtra_move,4).Position(1)+sqr(xtra_move,4).Position(3)/2-20),y(4-z)+75,num2str(TileVal(xtra_move,4)),'FontSize',55,'color','#776e65','FontWeight','bold'); %plots title
                NewTileVal(xtra_move,4-z) = TileVal(xtra_move,4);
                if sqr(xtra_move,4-z).Position(2) ~= sqr(xtra_move,4-z+1).Position(2)
                    sqr(xtra_move,4-z+1) = rectangle('Position',[x(xtra_move),y(4-z+1),150,150],'EdgeColor','#e0d3c5','FaceColor','#e0d3c5','LineWidth',3,'Curvature',[0.1 0.1]); %creates rectangle
                    NewTileVal(xtra_move,4-z+1) = 0;
                end
                if 1+z < 4
                    z = z-1;
                end
            end
        end
        
        for h = 1:4 %creates loop for columns
            zero_loc(h) = TileVal(h,4)==0;
        end
        
        num_zero1 = size(find(TileVal==0),1);
        num_zero2 =size(find(zero_loc),2);
        num_zero = min([num_zero1 num_zero2]);
        
        if any(any(equal_down)) || any(any(TileVal(1:4,1:3)==0))
            if num_zero == 0
                continue
                
            elseif num_zero == 1 && any(find(TileVal==0)>12)
                newtiles_pos = randi([1 4],1);
                newtiles_val_ind = randi([1 5],1);
                newtiles_val = give_val(newtiles_val_ind);
                while zero_loc(newtiles_pos) == 0
                    range = zero_loc.*[1:4];
                    range1 = find(range);
                    newtiles_pos = randi([min(range1) max(range1)],1);
                end
                
            elseif num_zero >= 2 && any(find(TileVal==0)>12)
                newtiles_pos = randi([1 4],1,2);
                newtiles_val_ind = randi([1 5],1,2);
                newtiles_val = give_val(newtiles_val_ind);
                while newtiles_pos(1)==newtiles_pos(2) || (zero_loc(newtiles_pos(1)) == 0 ||zero_loc(newtiles_pos(2)) == 0)
                    range = zero_loc.*[1:4];
                    range1 = find(range);
                    newtiles_pos(1) = randi([min(range1) max(range1)],1,1);
                    newtiles_pos(2) = randi([min(range1) max(range1)],1,1);
                    continue
                end
            end
            if num_zero == 0
                
            elseif num_zero == 1 && any(find(TileVal==0)>12)
                c1 = 1;
                for c2 = 1:size(color_tab,1)
                    while num2str(newtiles_val(1,c1)) == color_tab{c2,2}
                        newsqr1 = rectangle('Position',[x(newtiles_pos(1)),y(4),150,150],'EdgeColor',color_tab{c2,1},'FaceColor',color_tab{c2,1},'LineWidth',3,'Curvature',[0.1 0.1]); %creates rectangle
                        TileColor(newtiles_pos(1),4) = {newsqr1.FaceColor};
                        text(x(newtiles_pos(1))+55,y(4)+75,num2str(newtiles_val(1,c1)),'FontSize',55,'color','#776e65','FontWeight','bold') %plots title
                        TileVal(newtiles_pos(1),4) = newtiles_val(1,c1);
                        break
                    end
                end
                
            elseif num_zero >= 2 && any(find(TileVal==0)>12)
                for c1 = 1:2
                    if c1 == 1
                        for c2 = 1:size(color_tab,1)
                            while num2str(newtiles_val(1,c1)) == color_tab{c2,2}
                                newsqr1 = rectangle('Position',[x(newtiles_pos(1)),y(4),150,150],'EdgeColor',color_tab{c2,1},'FaceColor',color_tab{c2,1},'LineWidth',3,'Curvature',[0.1 0.1]); %creates rectangle
                                TileColor(newtiles_pos(1),4) = {newsqr1.FaceColor};
                                text(x(newtiles_pos(1))+55,y(4)+75,num2str(newtiles_val(1,c1)),'FontSize',55,'color','#776e65','FontWeight','bold') %plots title
                                TileVal(newtiles_pos(1),4) = newtiles_val(1,c1);
                                break
                            end
                        end
                    elseif c1 == 2
                        for c2 = 1:size(color_tab,1)
                            while num2str(newtiles_val(1,c1)) == color_tab{c2,2}
                                newsqr1 = rectangle('Position',[x(newtiles_pos(2)),y(4),150,150],'EdgeColor',color_tab{c2,1},'FaceColor',color_tab{c2,1},'LineWidth',3,'Curvature',[0.1 0.1]); %creates rectangle
                                TileColor(newtiles_pos(2),4) = {newsqr1.FaceColor};
                                text(x(newtiles_pos(2))+55,y(4)+75,num2str(newtiles_val(1,c1)),'FontSize',55,'color','#776e65','FontWeight','bold') %plots title
                                TileVal(newtiles_pos(2),4) = newtiles_val(1,c1);
                                break
                            end
                        end
                    end
                end
            end
        end
        
    elseif direction == 28 %left
    elseif direction == 29 %right
    else
        
        while direction ~= 28 && direction ~= 29 && direction ~= 30 && direction ~= 31
            err1 = text(10,730,'Wrong input, please only use arrow keys','FontSize',20,'color','#776e65');
            [~,~,direction]=ginput(1);
            continue
        end
    end
    if exist('err1','var')==1
        delete(err1)
    end
    %% Checks for any equal adjacent values
    for a = 1:4 %creates loop for rows
        for b = 1:4 %creates loop for columns
            if a == 1
                if b == 1
                    if TileVal(a,b) == 0
                        anyequal(a,b)= 0;
                    else
                        anyequal(a,b) = TileVal(a,b)==TileVal(a+1,b) || TileVal(a,b)==TileVal(a,b+1);
                    end
                elseif b == 4
                    if TileVal(a,b) == 0
                        anyequal(a,b)= 0;
                    else
                        anyequal(a,b) = TileVal(a,b)==TileVal(a+1,b) || TileVal(a,b)==TileVal(a,b-1);
                    end
                else
                    if TileVal(a,b) == 0
                        anyequal(a,b)= 0;
                    else
                        anyequal(a,b) = TileVal(a,b) == TileVal(a+1,b)||TileVal(a,b)==TileVal(a,b-1)|| TileVal(a,b)==TileVal(a,b+1);
                    end
                end
            elseif a==2 || a==3
                if b == 1
                    if TileVal(a,b) == 0
                        anyequal(a,b)= 0;
                    else
                        anyequal(a,b) = TileVal(a,b)==TileVal(a+1,b) || TileVal(a,b)==TileVal(a,b+1)||TileVal(a,b)==TileVal(a-1,b);
                    end
                elseif b == 4
                    if TileVal(a,b) == 0
                        anyequal(a,b)= 0;
                    else
                        anyequal(a,b) = TileVal(a,b)==TileVal(a+1,b) || TileVal(a,b)==TileVal(a,b-1)||TileVal(a,b)==TileVal(a-1,b);
                    end
                else
                    if TileVal(a,b) == 0
                        anyequal(a,b)= 0;
                    else
                        anyequal(a,b) = TileVal(a,b) == TileVal(a+1,b)||TileVal(a,b)==TileVal(a,b-1)|| TileVal(a,b)==TileVal(a,b+1)||TileVal(a,b)==TileVal(a-1,b);
                    end
                end
            else
                if b == 1
                    if TileVal(a,b) == 0
                        anyequal(a,b)= 0;
                    else
                        anyequal(a,b) = TileVal(a,b)==TileVal(a-1,b) || TileVal(a,b)==TileVal(a,b+1);
                    end
                elseif b == 4
                    if TileVal(a,b) == 0
                        anyequal(a,b)= 0;
                    else
                        anyequal(a,b) = TileVal(a,b)==TileVal(a-1,b) || TileVal(a,b)==TileVal(a,b-1);
                    end
                else
                    if TileVal(a,b) == 0
                        anyequal(a,b)= 0;
                    else
                        anyequal(a,b) = TileVal(a,b) == TileVal(a-1,b)||TileVal(a,b)==TileVal(a,b-1)|| TileVal(a,b)==TileVal(a,b+1);
                        
                    end
                end
            end
        end
    end
end
