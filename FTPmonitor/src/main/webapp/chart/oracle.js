// 서버로부터 데이터를 가져오는 AJAX 호출
$.ajax({
  url: 'jdbc:oracle:thin:@localhost:1521:xe',
  method: 'GET',
  success: function(data) {
    // 서버로부터 전달받은 JSON 데이터 처리
    // HTML 문서의 적절한 위치에 값을 출력
  },
  error: function(error) {
    // 에러 처리
  }
});
