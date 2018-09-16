function ckalign(remain, align, accelerate)
%CKALIGN ckalign(remain, align, accelerate)
%   remina      - a duration
%   align       - a datetime
%   accelerate	- true or false

narginchk(0, 3);

if nargin < 1 || isempty(remain)
    remain = phase('', 'remain? ');
end
now = datetime('now'); now.Format = 'HH:mm:ss';
fprintf('should finish at %s.\n', now+remain)

if nargin < 2 || isempty(align)
    align = phase('22', 'align? ');
end
fprintf('want to finished in %.2f hr.\n', hours(align-datetime('now')));

if nargin < 3 || isempty(accelerate)
    accelerate = phase('true', 'accelerate [true]/false? ');
end

if accelerate
    mspeed = 45;    % eat speed, in g/hr
else
    mspeed = 36;
end
tspeed = 18;

calling = calc(hours(remain), hours(align-now), mspeed, tspeed);
if calling >= remain
    fprintf(['You don''t need to call other chikens.\n', ...
            '\tThat would finish in %.2f hrs (%s)\n'], hours(remain), now+remain);
else
    print_res(calling, 'another chiken', now, remain, mspeed, tspeed)

    if calling < 0
        tspeed = 2*tspeed;

        calling = calc(hours(remain), hours(align-now), mspeed, tspeed);
        print_res(calling, '2 chikens', now, remain, mspeed, tspeed)
    end
end

end

function t = phase(default, prompt)
    t = input(prompt, 's');
    if isempty(t)
        t = default;
        while isempty(t), t = input(prompt, 's'); end
    end
    
    if ~isempty(regexpi(prompt, 'remain'))
        [hr, min] = phase_time(t);
        t = duration(hr, min, 0);
    elseif ~isempty(regexpi(prompt, 'align'))
        [hr, min] = phase_time(t);
        t = datetime('now');
        t.Hour = hr; t.Minute = min; t.Second = 0;

        if t - datetime('now') < 0
            t = t + days(1);
        end
    elseif ~isempty(regexpi(prompt, 'accelerate'))
        yes = ["y", "yes", "t", "true", "1"];
        yes = [yes, upper(yes)];
        no = ["n", "no", "f", "false", "0"];
        no = [no, upper(no)];
        
        if ismember(t, yes)
            t = true;
        elseif ismember(t, no)
            t = false;
        else
            t = eval(t);
        end
        
        if ~islogical(t)
            t = eval(default);
        end
    else
        error('ckalign: phase: unkown prompt!')
    end
end

function [hr, min] = phase_time(t)
    dot = strfind(t, '.');
    if isempty(dot)
        dot = length(t);
    end
    hr = str2double(t(1:dot));
    min = str2double(t(dot+1:end));
    if isnan(min)
        min = 0;
    end
end

function calling = calc(remain, align, mspeed, tspeed)
    calling = ((mspeed+tspeed)*align - mspeed*remain)/tspeed;
    calling = hours(calling);
end

function print_res(calling, prompt, now, remain, mspeed, tspeed)
    if calling < 0
        calling = hours(0);
    end
    hrcall = hours(calling);

    hr = floor(hrcall);
    min = floor(hrcall*60-hr*60);

    vol = hours(remain) * mspeed;
    remain = hrcall + (vol - mspeed*hrcall)/(mspeed+tspeed);
    fprintf(['you should call %s after: %d hrs + %d mins\n', ...
            '\tThat would finish in %.2f hrs (%s)\n'], ...
            prompt, hr, min, remain, now+hours(remain));
end