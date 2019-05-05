function outputText = updateDataCursor(~,event_obj)

pos = get( event_obj, 'Position' );
Mat=get(0,'UserData');
ths=Mat(:,1);
xx=Mat(:,2);
yy=Mat(:,3);
RelevantInd=find((yy==pos(2))&(xx==pos(1)));
Th=ths(RelevantInd);

outputText = { ['FP: ', num2str( round( pos( 1 ), 3 ) )],...
          ['TP: ', num2str( round( pos( 2 ), 3 ) )],...
    ['th: ', num2str( round( Th, 3 ) )] };

end