<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.mark {
	border-radius:10px; border: 1px solid blue; color: white; font-size: 14px; width: 30px; height: 30px; background: blue
	}
	.circle {
	border-radius:50%; border: 1px solid aqua; color: white; font-size: 24px; width: 100px; height: 100px; background: aqua; display: flex; align-items: center; justify-content: center;
	}
</style>
</head>
<body>
	<p style="margin-top: -12px">
		<em class="link"> <a href="/web/documentation/#MapTypeId"
			target="_blank">지도 타입을 보시려면 여기를 클릭하세요!</a>
		</em>
	</p>
	<div id="map" style="width: 800px; height: 500px; margin: 0 auto"></div>
	<p id="message"></p>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=683cef37c8e822b967d6997468818ca4"></script>
	<script>

	
	let data = [
			[33.450701, 126.570667, 'A'],
			[33.350701, 126.170667, 'B'],
			[33.550701, 126.370667, 'C'],
			[33.250701, 126.270667, 'D'],
			[33.250701, 126.170667, 'E'],
			[33.450701, 126.370667, 'F'],
			[33.440701, 126.560667, 'G'],
			[33.450701, 126.460667, 'H'],
			[33.460701, 126.560667, 'I'],
			[33.440701, 126.570667, 'G'],
			[33.455701, 126.563667, 'I'],
		]	
	
	let globaloverlay = [];
	
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 6
		// 지도의 확대 레벨
		};

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

		// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
		var zoomControl = new kakao.maps.ZoomControl();
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
	
		// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
		var mapTypeControl = new kakao.maps.MapTypeControl();

		// 지도 타입 컨트롤을 지도에 표시합니다
		map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
		
		getInfo();
		
		function getInfo() {
			// 지도의 현재 중심좌표를 얻어옵니다 
			var center = map.getCenter();
			// 지도의 현재 레벨을 얻어옵니다
			var level = map.getLevel();
			
			switch (level) {
			case 6:
				console.log(6);
				overfive();
				break;
			case 5:
				underfive();
				break;
			default:
				break;
			}
			
			// 지도타입을 얻어옵니다
			var mapTypeId = map.getMapTypeId();
			// 지도의 현재 영역을 얻어옵니다 
			var bounds = map.getBounds();
			// 영역의 남서쪽 좌표를 얻어옵니다 
			var swLatLng = bounds.getSouthWest();
			// 영역의 북동쪽 좌표를 얻어옵니다 
			var neLatLng = bounds.getNorthEast();
			// 영역정보를 문자열로 얻어옵니다. ((남,서), (북,동)) 형식입니다
			var boundsStr = bounds.toString();
		
			var message = '지도 중심좌표는 위도 ' + center.getLat() + ', <br>';
			message += '경도 ' + center.getLng() + ' 이고 <br>';
			message += '지도 레벨은 ' + level + ' 입니다 <br> <br>';
			message += '지도 타입은 ' + mapTypeId + ' 이고 <br> ';
			message += '지도의 남서쪽 좌표는 ' + swLatLng.getLat() + ', '
					+ swLatLng.getLng() + ' 이고 <br>';
			message += '북동쪽 좌표는 ' + neLatLng.getLat() + ', '
					+ neLatLng.getLng() + ' 입니다';
			
			document.getElementById('message').innerHTML = message;
			// 개발자도구를 통해 직접 message 내용을 확인해 보세요.
		}
		
	// 지도 레벨이 바뀔 때마다 이벤트
	kakao.maps.event.addListener(map, 'zoom_changed', getInfo);
	// 지도 움직일 때마다 이벤트
	kakao.maps.event.addListener(map, 'dragend', getInfo);        
	
	
	overfive();
	
	function overfive() {

		
  	  for(i = 0; i < data.length; i++) {
  	 		let content = '<div class="mark">' + data[i][2] +'</div>';
 		   	    	
			// 커스텀 오버레이가 표시될 위치입니다 
			let position = new kakao.maps.LatLng(data[i][0], data[i][1]);  

			// 커스텀 오버레이를 생성합니다
			let customOverlay = new kakao.maps.CustomOverlay({
		   	 position: position,
		   	 content: content,
	    		xAnchor: 0.3,
	   			 yAnchor: 0.91
			});
		
			// 커스텀 오버레이를 지도에 표시합니다
			customOverlay.setMap(map);
			globaloverlay.push(customOverlay);
    	}
	}
	
	function underfive() {
		for(j = 0; j < globaloverlay.length; j++) {
			globaloverlay[j].setMap(null);
		}
		
		let bounds = map.getBounds();
		let swLatLng = bounds.getSouthWest();		// 남서
		let neLatLng = bounds.getNorthEast();		// 북동
		console.log('swLatLng : ', swLatLng);
		let count = 0;
	  		console.log('data[0][1] : ', data[0][1]);
	  		console.log('swLatLng[1] : ', swLatLng.La);
	  		console.log('neLatLng[1] : ', neLatLng.La);
	  		console.log('data[0][0] : ', data[0][0]);
	  		console.log('swLatLng[0] : ', swLatLng.Ma);
	  		console.log('neLatLng[0] : ', neLatLng.Ma);
	  		
	  	for(i = 0; i < data.length; i++) {
	  		if(data[i][0] > swLatLng.Ma && data[i][0] < neLatLng.Ma) {
	  			if(data[i][1] > swLatLng.La || data[i][1] < neLatLng.La) {
			  		count++;
	  			}
	  		}
	  		
	  	}
	  	
		let content1 = '<div class="circle">' + count +'</div>';
	    let center1 = map.getCenter();	
	    console.log('center1 : ', center1);
		// 커스텀 오버레이가 표시될 위치입니다 
// 		let position = new kakao.maps.LatLng(center1[0], center1[1]);  

		// 커스텀 오버레이를 생성합니다
		let customOverlay1 = new kakao.maps.CustomOverlay({
	   	 position: center1,
	   	 content: content1,
    		xAnchor: 0.3,
   			 yAnchor: 0.91
		});
	
		// 커스텀 오버레이를 지도에 표시합니다
		customOverlay1.setMap(map);
	}
	
	</script>
</body>
</html>