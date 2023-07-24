<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <!-- Bootstrap CSS -->
  <link href="../CSS/styles.css" rel="stylesheet">
  <!-- Bootstrap JS (Optional) -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    function displaySelectedColor(color) {
      document.getElementById('selected-color').innerText = color;
    }

    function displaySelectedSize(size) {
      document.getElementById('selected-size').innerText = size;
    }
    
    function displaySelectedlength(length) {
      document.getElementById('selected-length').innerText = length;
    }

    function displaySelectednum(num) {
      document.getElementById('selected-num').innerText = num;
    }

    function displaySelectedValues() {
      var selectedColor = document.getElementById('selected-color').innerText;
      var selectedSize = document.getElementById('selected-size').innerText;
      var selectedLength = document.getElementById('selected-length').innerText;
      var selectedNum = document.getElementById('selected-num').innerText;
      if (!selectedColor || !selectedSize || !selectedLength  || !selectedNum) {
        alert("각 항목에 대한 옵션을 모두 선택 바랍니다.");
        return;
      }

      var table = document.getElementById('selected-values-table').getElementsByTagName('tbody')[0];
      var newRow = table.insertRow(table.rows.length);
      var cell1 = newRow.insertCell(0);
      var cell2 = newRow.insertCell(1);
      var cell3 = newRow.insertCell(2);
      var cell4 = newRow.insertCell(3);


      cell1.innerHTML = selectedColor;
      cell2.innerHTML = selectedSize;
      cell3.innerHTML = selectedLength;
      cell4.innerHTML = selectedNum;

    
      // 수정 버튼 생성
      /*
      var modifyButton = document.createElement('button');
      modifyButton.innerText = '수정';
      modifyButton.onclick = function() {
        alert('선택한 값 수정: ' + selectedColor + ', ' + selectedSize + ', ' + selectedLength);
      };
      newRow.appendChild(modifyButton);
      */

      // 삭제 버튼 생성
      var deleteButton = document.createElement('button');
      deleteButton.innerText = '삭제';
      deleteButton.onclick = function() {
        table.deleteRow(newRow.rowIndex-1);
      };
      newRow.appendChild(deleteButton);

      createPlan(selectedColor, selectedSize, selectedLength, selectedNum);
    } 

    function createPlan(color, size, len, num) {
      console.log("[createPlan] ", color, ",", size, ",", len, ",", num);

      var form = document.getElementById("planOrderForm");
      var inpcolor = document.createElement("input");
      inpcolor.setAttribute("type", "hidden");
      inpcolor.setAttribute("value", color);
      inpcolor.setAttribute("name", "color");
      form.appendChild(inpcolor);

      var inpsize = document.createElement("input");
      inpsize.setAttribute("type", "hidden");
      inpsize.setAttribute("value", size);
      inpsize.setAttribute("name", "size");
      form.appendChild(inpsize);

      var inplen = document.createElement("input");
      inplen.setAttribute("type", "hidden");
      inplen.setAttribute("value", len);
      inplen.setAttribute("name", "len");
      form.appendChild(inplen);

      var inpnum = document.createElement("input");
      inpnum.setAttribute("type", "hidden");
      inpnum.setAttribute("value", num);
      inpnum.setAttribute("name", "num");
      form.appendChild(inpnum);

    }

    function submitSelectedValues() {
      var form = document.getElementById("planOrderForm");
      form.submit();
    }

    /*
    // 경고창
    function displayerror() {
      var selectedColor = document.getElementById('selected-color').innerText;
      var selectedSize = document.getElementById('selected-size').innerText;
      var selectedLength = document.getElementById('selected-length').innerText;
      var selectedNum = document.getElementById('selected-num').innerText;

      if (!selectedColor || !selectedSize || !selectedLength  || !selectedNum) {
        alert("각 항목에 대한 옵션을 모두 선택 바랍니다.");
        return;
      }

      var table = document.getElementById('selected-values-table').getElementsByTagName('tbody')[0];
      var newRow = table.insertRow(table.rows.length);
      var cell1 = newRow.insertCell(0);
      var cell2 = newRow.insertCell(1);
      var cell3 = newRow.insertCell(2);
      var cell4 = newRow.insertCell(3);

      cell1.innerHTML = selectedColor;
      cell2.innerHTML = selectedSize;
      cell3.innerHTML = selectedLength;
      cell4.innerHTML = selectedNum;
    }
*/
  </script>
</head>
<body>
  <div class="btn-group">
    <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
      색상
    </button>
    <ul class="dropdown-menu">
      <li><a class="dropdown-item" href="#" onclick="displaySelectedColor('Red')">빨강</a></li>
      <li><a class="dropdown-item" href="#" onclick="displaySelectedColor('Blue')">파랑</a></li>
      <li><a class="dropdown-item" href="#" onclick="displaySelectedColor('Yellow')">노랑</a></li>
      <li><a class="dropdown-item" href="#" onclick="displaySelectedColor('Green')">초록</a></li>
      <li><hr class="dropdown-divider"></li>
    </ul>
  </div>

  <div class="btn-group">
    <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
      사이즈
    </button>
    <ul class="dropdown-menu">
      <li><a class="dropdown-item" href="#" onclick="displaySelectedSize('S')">S</a></li>
      <li><a class="dropdown-item" href="#" onclick="displaySelectedSize('M')">M</a></li>
      <li><a class="dropdown-item" href="#" onclick="displaySelectedSize('L')">L</a></li>
      <li><a class="dropdown-item" href="#" onclick="displaySelectedSize('XL')">XL</a></li>
      <li><hr class="dropdown-divider"></li>
    </ul>
  </div>

  <div class="btn-group">
    <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
      수량
    </button>
    <ul class="dropdown-menu">
      <li><a class="dropdown-item" href="#" onclick="displaySelectedlength('S')">1</a></li>
      <li><a class="dropdown-item" href="#" onclick="displaySelectedlength('M')">2</a></li>
      <li><a class="dropdown-item" href="#" onclick="displaySelectedlength('L')">3</a></li>
      <li><a class="dropdown-item" href="#" onclick="displaySelectedlength('XL')">4</a></li>
      <li><hr class="dropdown-divider"></li>
    </ul>
  </div>

  <div class="btn-group">
    <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
      기계번호
    </button>
    <ul class="dropdown-menu">
      <li><a class="dropdown-item" href="#" onclick="displaySelectednum('M0001')">M0001</a></li>
      <li><a class="dropdown-item" href="#" onclick="displaySelectednum('M0002')">M0002</a></li>
      <li><a class="dropdown-item" href="#" onclick="displaySelectednum('M0003')">M0003</a></li>
      <li><a class="dropdown-item" href="#" onclick="displaySelectednum('M0004')">M0004</a></li>
      <li><hr class="dropdown-divider"></li>
    </ul>
  </div>


  <div class="btn-group">
    <button type="button" class="btn btn-primary" onclick="displaySelectedValues()">저장</button>
  </div>
  <div class="btn-group">
    <button type="button" class="btn btn-primary" onclick="submitSelectedValues()">전송</button>
  </div>

<form id="planOrderForm" action="planOrder" method="post">
  <table class="table table-bordered" id="selected-values-table">
    <thead>
      <tr>
        <th>색상</th>
        <th>사이즈</th>
        <th>길이</th>
        <th>기계번호</th>
        <!--<th>수정</th>
        <th>삭제</th>-->
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>
          <div id="selected-color"></div>
        </td>
        <td>
          <div id="selected-size"></div>
        </td>
        <td>
          <div id="selected-length"></div>
        </td>
        <td>
          <div id="selected-num"></div>
        </td>
      </tr>
    </tbody>
  </table>
</form>

</body>
</html>
