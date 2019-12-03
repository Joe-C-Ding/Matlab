function end_up(script_name, fig_names, paper_oriented)
%END_UP end_up(script_name='script', fig_names=script_name, paper_oriented=false)
%   printf a toc message, and save figures;
%   script_name: chars -> used to print elapsed time
%   fig_names(optional): empty or chars or cell array of chars
%       -> if fig_name are not given, it will be set to `script_name' as
%          default value.
%       -> keep empty ([] or '') won't save any fig, but docks them to
%          workspace. If fig_names == script_name, it will be treated like
%          empty for convenience, unless `script_name' begins with 'plot_'.
%       -> chars, `fig' say, will save all figs in the form `fig', `fig2', ...
%       -> cell array, in this case its lenght mush no less than figs
%          count. And figure(1) will be save as fig_name{1}, and so on.
%   paper_oriented: bool, true to save `.eps` in `./pic'; `.png` and `.fig`
%       -> in `./word/fig'. false to save them all in `./script'.
if nargin < 1
    script_name = 'script';
end

if nargin < 2
    fig_names = script_name;
end

if nargin < 3 || isempty(paper_oriented)
    paper_oriented = false;
end

if paper_oriented
    eps_root = 'pic/';
    fig_root = 'word/fig/';
else
    eps_root = ['pic/', script_name, '/'];
    fig_root = eps_root;
end

global start_tic
if start_tic > 0
    fprintf('%s elapsed: %f s\n', script_name, toc(start_tic));
    start_tic = 0;
end

if isempty(fig_names)
    set_docked();
    return;
end

[nname, fig_names] = count_name(fig_names);

if nname > 1
    save_figs(fig_names, eps_root, fig_root)
else
    if ~strcmp(fig_names, script_name) || strncmpi(fig_names, 'plot_', 5)
        save_fig(fig_names, eps_root, fig_root);
        
    else
        set_docked();
    end
end

end

function [nname, fig_names] = count_name(fig_names)
    if ischar(fig_names)
            nname = 1;

    else
        if isstring(fig_names)
            fig_names = cellstr(fig_names(:));
        elseif iscell(fig_names)
            fig_names = fig_names(:);
        else
            error(script_name + " :end_up: unknow type of `fig_names'.");
        end

        nname = length(fig_names);
    end
end

function save_figs(fig_names, eps_root, fig_root)
    h = get(groot, 'Children');
    nfig = length(h);
    
    if length(fig_names) < nfig
            error("end_up: too few `fig_names'!");
    end
 
    pre_save(eps_root, fig_root);
    h = sort_fig(h);
    for i = 1:nfig
        if strcmp(fig_names{i}, '~')
            set(h(i), 'windowstyle', 'docked');
            continue;
        else
            print(h(i), fullfile(eps_root, fig_names{i}), '-depsc');
            print(h(i), fullfile(fig_root, fig_names{i}), '-dpng');
            savefig(h(i), fullfile(fig_root, fig_names{i}));
        end
    end
end

function save_fig(fname, eps_root, fig_root)
    if strncmpi(fname, 'plot_', 5)
        fname = fname(6:end);
    end

    h = get(groot, 'Children');
    pre_save(eps_root, fig_root);

    for i = sort_fig(h).'
        if i.Number == 1
            suffix = '';
        else
            suffix = num2str(i.Number);
        end
        
        print(i, fullfile(eps_root, [fname, suffix]), '-depsc');
        print(i, fullfile(fig_root, [fname, suffix]), '-dpng');
        savefig(i, fullfile(fig_root, [fname, suffix]));
    end

    figure(1);
end

function set_docked()
    h = get(groot, 'Children');
    set(h, 'windowstyle', 'docked');
end

function pre_save(eps_root, fig_root)
%clear grid, box, legend-box etc.
    h = findobj(groot, 'Type', 'axes');
    set(h, 'Box', 'off');
    set(h, 'GridColor', 'none');
    set(h, 'MinorGridColor', 'none');
    
    h = findobj(groot, 'Type', 'legend');
    set(h, 'Box', 'off');
    
    if exist(eps_root, 'file') ~= 7
        mkdir(eps_root);
    end
    if exist(fig_root, 'file') ~= 7
        mkdir(fig_root);
    end
end

function h = sort_fig(h)
    [~,I] = sort([h.Number]);
    h = h(I);
end