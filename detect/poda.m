function prob = poda(a, pod, verbose)
%PODA prob = poda(a, pod, verbose)

narginchk(1,3);
if nargin < 2 || isempty(pod)
    pod = load('POD', 'pod_far');
    pod = pod.pod_far;
end
if nargin < 3 || isempty(verbose)
    verbose = 1;
end
amin = min(pod(:,1));
amax = max(pod(:,1));

a = a * 1e3;
if verbose >= 2
    disp('poda: a = ');
    disp(a)
end
a(a < amin) = amin;
a(a > amax) = amax;

prob = interp1(pod(:,1), pod(:,2), a);
if verbose >= 2
    disp('poda: prob = ');
    disp(prob);
end
if verbose >= 3
    disp('poda: 1 - prob = ');
    disp(1 - prob);
end

if verbose >= 1
    disp('poda: prob_overall = ');
    disp(1-prod(1-prob, 'omitnan'));
end
end

