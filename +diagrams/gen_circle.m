function C = gen_circle(k,p)
    N = 100;
    C = NaN([3 N+1]);
    angles = linspace(0,2*pi,N+1);
    for i = 1:N
    C(:,i) = rot(k, angles(i))*p;
    end
    C(:,end)=C(:,1);
end
