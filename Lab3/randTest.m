function [d] = randTest(~)
%randTest Setup random numbers to use for testing
% Assumes 6 genres, 5 songs each, and 10 passes
% need 6*5*10 random numbers
d=zeros(6,5,10); % hold the index for random songs
for n=1:10 % average over the randomization
    for i=1:6 % an array for each genre
        % generates 5 random numbers between 1 and 25
        d(i,:,n)=randperm(25,5);
    end
end
if(nargin)
    % We now have d, which is our song indices
    % Save away the list of indices to a file
    DateString=datestr(datetime('now'));
    DateString(DateString==' ')='_';
    name= ['randomNum_', DateString];
    save(name,'d');
end
end