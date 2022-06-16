%Plays the Game Wordle
%%Wordle, Smoker, 4/25/21, Version 1.0
function [word,rounds] = play_wordleBJS(mode,grader_word) %defines function play_wordle with possible inputs for mode and grader_word
% Inputs:
%   mode - optional input. Defaults to 'standard' mode. If the mode is listed as 'grader' then the mystery word is displayed throughout game play. 
%         If you add extras for extra credit, define an alternate  mode and be sure to describe in in your last page
%   grader_word - optional input. If included, then this must be the mystery word. Else it is randomly chosen.
% Outputs:
%   word - mystery word
%   rounds - number of rounds solved in. If not solved, returns an 'X'

bank = readlines('wordle_words.txt'); %loads in word bank

MysInd = randi([1 size(bank,1)],1); %calls a random number with thin the domain of the word bank
word  = upper(bank(MysInd)); %calls the index and gives our word
%brain = 261
%abhor = 6
%abbey = 4
%alloy = 60
%mango = 1194
%lipid = 1139
%began = 173
%beach = 166
fig=figure(1); %creates figure
clf %clears figure
set(fig,'Position',[fig.Position(1),fig.Position(2),560,670]); %sets the position and dimensions
x = [10 120 230 340 450 560]; %x vector for the boxes
y = [10 120 230 340 450 560 670]; %y vector for the boxes
for a = 1:6 %creates loop for rows
    for b = 1:5 %creates loop for columns
        hold on %turns hold on
        sqr = rectangle('Position',[x(b),y(a),100,100],'EdgeColor',[0.90,0.90,0.90],'LineWidth',3); %creates rectangle
    end %end
end %end
boardtitle=gca; %sets %sets currentfigure as boardtitle
title('Wordle') %sets the title to 'Wordle'
boardtitle.Title.FontName = 'Helvetica'; %sets the font to 'Veranda'
boardtitle.Title.Position = [max(x)/2 max(y) 0]; %sets position of the title
boardtitle.FontSize = 32; %sets the fontsize to 32
axis off %turns axes off

index = {'First ' 'Second ' 'Third ' 'Fourth ' 'Fifth ' 'Sixth '}; %cell array for the turn counter
Letters = 'A':'Z'; %creates letter array

if nargin == 0 %compares if number of inputs is 0
    mode = 'standard'; %sets mode to 'standard'
end %end of if
if nargin == 1 %compares if number of inputs is 1
    if strcmp(mode,'grader') %compares if input is 'grader'
        disp(word) %diplays word
    else
        while ~(strcmp(mode,'standard') || strcmp(mode,'grader'))
            disp('Invalid Mode')
            mode = input('Mode = ',"s");
        end
        if strcmp(mode,'grader')
            word = upper(convertCharsToStrings(grader_word)); %sets word to chosen word
            disp(word)
        end
    end %end of if
end %end of if




if nargin == 2 %compares if number of inputs is 1
    
    if strcmp(mode,'grader') %compares if input is 'grader'
        word = upper(grader_word);
        disp(word) %diplays word
    else
        while ~(strcmp(mode,'standard') || strcmp(mode,'grader'))
            disp('Invalid Mode')
            mode = input('Mode = ',"s");
        end
        if strcmp(mode,'grader')
            word = upper(convertCharsToStrings(grader_word)); %sets word to chosen word
            disp(word)
        end
    end%end of if
end







while ~(strcmp(mode,'standard') || strcmp(mode,'grader'))
    switch mode %sets switch for mode
        case 'standard' %sets case where mode is 'standard' and plays normal game
        case 'grader' %sets case where mode is 'grader'
            graderalpha = isstrprop(grader_word,'alpha'); %creates logical for lettrs and non letters
            flag1 = ismember(0, graderalpha); %checks if any non letters are in input
            flag2 = ismember(grader_word,bank); %checks if guess is in the word bank
            while length(grader_word)~=5 || flag1 == 1||flag2 == 0 %creates while loop if any of the previous checks are tripped
                disp('Invalid Grader word') %displays invalid Grader word
                disp('A valid word may only contain letters, be 5 characters long, and be a real world')
                grader_word = input('Grader word = ',"s"); %asks for a new input
                graderalpha = isstrprop(grader_word,'alpha'); %creates logical for lettrs and non letters
                flag1 = ismember(0,graderalpha); %checks if any non letters are in input
                flag2 = ismember(grader_word,bank); %checks if guess is in the word bank
                continue %resets back to beggining of while
            end %end of while
            word = upper(convertCharsToStrings(grader_word)); %sets word to chosen word
            disp(word) %displays word
        otherwise
            disp('Invalid Mode')
            mode = input('Mode = ',"s");
    end %end of switch
end %end of if


for rounds=1:6 %creates loop for eahc guess
    
    guess = input([index{rounds} 'Guess = '],"s"); %ask for an input of any kind
    alpha = isstrprop(guess,'alpha'); %creates logical for lettrs and non letters
    flag1 = ismember(0,alpha); %checks if any non letters are in input
    flag2 = ismember(guess,bank); %checks if guess is in the word bank
    while length(guess)~=5 || flag1 == 1||flag2 == 0 %creates while loop if any of the previous checks are tripped
        disp('Invalid Guess') %displays invalid guess
        disp('A valid guess may only contain letters, be 5 characters long, and be a real world')
        guess = input([index{rounds} 'Guess = '],"s"); %asks fro a new input
        alpha = isstrprop(guess,'alpha'); %creates logical for lettrs and non letters
        flag1 = ismember(0,alpha); %checks if any non letters are in input
        flag2 = ismember(guess,bank); %checks if guess is in the word bank
        continue %resets back to beggining of while
    end %end of while
    spGuess = split(guess,'',1); %splits guess into character strings
    spGuess = upper(spGuess(2:6,:)); %removes first and last spaces
    for d = 1:5 %%creates loop for each letter
        check{d,:} = strfind(word,spGuess{d,:}); %checks if any letters from guess are in Word
        if any(check{d,:} == d) %checks if
            flag3{d,:} = 1;
        else
            flag3{d,:} = 0;%checks if any should be green
        end %end of if
    end %end of for
    
    for e = 1:5 %creates for loop for each column
        if check{e}~=0 %comapres if check{e} is not 0
            if flag3{e} == 1 %compares if flag3{e} is 1, if letter is in correct spot
                rect{e,:} = rectangle('Position',[x(e),y(abs(rounds-7)),100,100],'FaceColor',[0.38,0.7,0.31],'EdgeColor',[0.38,0.7,0.31],'LineWidth',3);%marks letter as green, present in word, and in the correct spot
                CorrectSpot{e,:} = 1; %sets flag4 to 1
                FaceColor{e,:} = rect{e,:}.FaceColor; %saves rectangle face color
            else %else
                rect{e,:} =rectangle('Position',[x(e),y(abs(rounds-7)),100,100],'FaceColor',[0.84,0.77,0.45],'EdgeColor',[0.84,0.77,0.45],'LineWidth',3);%marks letter as gold, present in word, but not in right spot
                CorrectSpot{e,:} = 0; %sets flag4 to 0, indicates letter is present in word but not in correct spot
                FaceColor{e,:} = rect{e,:}.FaceColor; %saves rectangle face color
            end %end of if
        else %else
            rect{e,:} =rectangle('Position',[x(e),y(abs(rounds-7)),100,100],'FaceColor',[0.41,0.41,0.41],'EdgeColor',[0.41,0.41,0.41],'LineWidth',3);%marks letter as grey, not present in word
            CorrectSpot{e,:} = 0; %sets flag4 as 0
            FaceColor{e,:} = rect{e,:}.FaceColor; %saves rectangle face color
        end %end of if
        txt = spGuess; %sets txt as spGuess
        text(x(e)+30,y(abs(rounds-7))+50,txt(e),'FontSize',40,'color','white','FontWeight','bold') %plots letter
    end
    if upper(guess)==word %checks if input is correct
        if rounds == 1 %compares if round was 1
            disp(['Congratulaitons! You solved the puzzle in ' num2str(rounds) ' round']); %displays win output statement
            playagain = input(['Play Again? (yes,no) =>'],"s") %asks if player wants to play again
            if strcmp(playagain,'yes') %compares input to 'yes'
                [word,rounds] = play_wordleBS() %calls function
            elseif strcmp(playagain,'no') %compares input to 'no'
                break %ends function
            else %else
                playagain = input(['Play Again? (yes,no) =>'],"s") %asks if player wants to play again
            end %end of if
        else %else
            disp(['Congratulaitons! You solved the puzzle in ' num2str(rounds) ' rounds']);
            playagain = input(['Play Again? (yes,no) =>'],"s"); %asks if player wants to play again
            if strcmp(playagain,'yes') %compares input to 'yes'
                [word,rounds] = play_wordleBS()%calls function
            elseif strcmp(playagain,'no')%compares input to 'no'
                break %ends loop
            end %end of if
        end %end of if
    end %end of if
    for j = 1:length(Letters) % Go through letters of the alphabet
        freq(1,j) = sum(count(guess,lower(Letters(j)))); %counts the amount of each letter in guess
        freq(2,j) = sum(count(num2str(cell2mat(word)),Letters(j)));%counts the amount of each letter in word
        double = cell2mat(FaceColor(strfind(word,Letters(j)),:)); %saves tile color
        if isempty(double)==0 %checks if theres a saved color present
            single = double(1,1);  %sets single to first value of double
        else %else
            single = 0; %sets single 0
        end %end of it
        if freq(1,j)>=2 && freq(2,j) == 1 %if the frequency of the letter is greater than or equal to 2 in the guess and the number of that letter is only one in the word
            if single == 0.41 %if the color is grey
                m = strfind(upper(guess),Letters(j)); %finds the position of letter in guess
                for q = 2:size(m,2) %creates loop from 2 to size of m
                    n = ismember(m,m(q)); %finds the position of each individual repeated letter
                    rect{m(n),:} =rectangle('Position',[x(m(n)),y(abs(rounds-7)),100,100],'FaceColor',[0.41,0.41,0.41],'EdgeColor',[0.41,0.41,0.41],'LineWidth',3);%changes the second repeated letter to grey
                    text(x(m(n))+30,y(abs(rounds-7))+50,txt(m(n)),'FontSize',40,'color','white','FontWeight','bold') %replaces letter
                end %end of for
            end %end of if
            if single == 0.38 %if the color is green
                m = strfind(upper(guess),Letters(j)); %finds the position of letter in guess
                for q = 2:size(m,2)%creates loop from 2 to size of m
                    single1 = FaceColor{m(q),:} == [0.38,0.7,0.31]; %checks if color is green
                    single2 = FaceColor{m(q),:} == [0.84,0.77,0.45]; %checks if color is gold
                    if single1(1) == 1 %if color is green
                        n = find(m~=m(q)); %find the position that is not green
                        for z = 1:size(n,2)
                            rect{m(n(z)),:} =rectangle('Position',[x(m(n(z))),y(abs(rounds-7)),100,100],'FaceColor',[0.41,0.41,0.41],'EdgeColor',[0.41,0.41,0.41],'LineWidth',3);%changes the second repeated letter to grey
                            text(x(m(n(z)))+30,y(abs(rounds-7))+50,txt(m(n(z))),'FontSize',40,'color','white','FontWeight','bold')%replaces letter
                        end
                    elseif single2(1) == 1 %checks if color is gold
                        n = ismember(m,m(q)); %find the position
                        rect{m(n),:} =rectangle('Position',[x(m(n)),y(abs(rounds-7)),100,100],'FaceColor',[0.41,0.41,0.41],'EdgeColor',[0.41,0.41,0.41],'LineWidth',3);%changes the second repeated letter to grey
                        text(x(m(n))+30,y(abs(rounds-7))+50,txt(m(n)),'FontSize',40,'color','white','FontWeight','bold')%replaces letter
                    end %end of if
                end %end of for
            end %end of if
        end %end of if
    end%end of for
    
    
    if upper(guess)==word %checks if guess is equal to word
        if rounds == 1 %checks if rounds == 1
            disp(['Congratulations! You solved the puzzle in ' num2str(rounds) ' round']); %displays victory statement for 1 round
            playagain = input(['Play Again? (yes,no) =>'],"s"); %asks if user wants to play again
            if strcmp(playagain,'yes') %checks if user input was 'yes'
                [word,rounds] = play_wordleBS() %runs function again
            elseif strcmp(playagain,'no') %checks if user input was 'no'
                break %breaks for loop
            else %else
                playagain = input(['Play Again? (yes,no) =>'],"s"); %reasks play again
            end %end of if
            break %breaks for loop
        else %else
            disp(['Congratulaitons! You solved the puzzle in ' num2str(rounds) ' rounds']); %displays victory statement for more than 1 round
            playagain = input(['Play Again? (yes,no) =>'],"s"); %asks if user wants to play again
            if strcmp(playagain,'yes') %checks if user input was 'yes'
                [word,rounds] = play_wordleBS() %runs function again
            elseif strcmp(playagain,'no') %checks if user input was 'no'
                break %breaks for loop
            else %else
                playagain = input(['Play Again? (yes,no) =>'],"s") %reasks play again
            end %end of if
            break %breaks for loop
        end %end of if
    end %end of if
end %end of for
playagain = ''; %sets playagain to an empty string
if rounds == 6 %checks if rounds was equal to 6
    while ~(strcmp(playagain,'yes') || strcmp(playagain,'no')) %while playagain doesnt equal 'yes' or 'no'
        if upper(guess)~=word %checks if last guess was the word
            disp(['Sorry! You did not solve the puzzle']); %displays losing statement
            disp(['The word was ' lower(num2str(cell2mat(word)))]); %tells user what the word was
            playagain = input(['Play Again? (yes,no) =>'],"s"); %asks if user wants to play again
            if strcmp(playagain,'yes') %checks if user input was 'yes'
                [word,rounds] = play_wordleBS() %runs function again
            elseif strcmp(playagain,'no') %checks if user input was 'no'
                rounds ='X'; %rounds equals 'X'
                break
            else %else
                playagain = input(['Play Again? (yes,no) =>'],"s"); %asks if user wants to play again
                continue %continue
            end %end of if
        else
            playagain = 'no';
            break
        end %end of if
    end %end of while
end %end of if

