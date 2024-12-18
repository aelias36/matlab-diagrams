function R=rot(k,theta)
    k = k / norm(k);
    R = eye(3,3) + sin(theta)*hat(k) + (1-cos(theta))*hat(k)*hat(k);
end  

function khat = hat(k)
    khat=[0 -k(3) k(2); k(3) 0 -k(1); -k(2) k(1) 0];
end
  