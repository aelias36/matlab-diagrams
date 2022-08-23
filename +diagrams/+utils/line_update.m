function line_update(L, t, h)
    set(L,'XData',[t(1) h(1)],'YData',[t(2) h(2)],'ZData',[t(3) h(3)]);
end