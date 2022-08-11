function Index = create_palmprintIndex(clsnum,session1_num,session2_num)
Index = zeros(clsnum,3);
for i = 1:clsnum
   Index(i,1) = i;
   Index(i,2) = session1_num;
   Index(i,3) = session2_num;
end