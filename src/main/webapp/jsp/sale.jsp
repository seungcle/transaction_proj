<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>수박나라 | 판매 등록</title>

  <!-- 외부 CSS 로드 -->
  <link rel="stylesheet" href="<c:url value='/css/styles.css'/>">
</head>
<body>
  <!-- header.jsp -->
   <jsp:include page="header.jsp" />

  <div id="UpLoadIamges">
    <form action="upload" method="post" enctype="multipart/form-data" id="productForm">
      <input type="file"
             id="fileInput"
             name="images"
             accept="image/*"
             multiple
             style="display:none;">
      <label for="fileInput">
        <img src="<c:url value='/images/upload-icon.png'/>"
             alt="이미지 업로드"
             id="uploadIcon">
      </label>
      <div id="counter">0/5</div>
      <div id="preview"></div>
      <button type="submit" class="btn-submit">등록하기</button>
    </form>
  </div>

  <script>
    const fileInput = document.getElementById('fileInput');
    const counter   = document.getElementById('counter');
    const preview   = document.getElementById('preview');
    let filesArr    = [];

    fileInput.addEventListener('change', () => {
      const selected = Array.from(fileInput.files);

      if (selected.length + filesArr.length > 5) {
        alert('최대 5개의 이미지만 업로드할 수 있습니다.');
        fileInput.value = '';
        return;
      }

      selected.forEach(file => {
        filesArr.push(file);
        const reader = new FileReader();
        reader.onload = e => {
          const wrapper = document.createElement('div');
          wrapper.className = 'preview-item';

          const img = document.createElement('img');
          img.src = e.target.result;

          const btn = document.createElement('button');
          btn.type = 'button';
          btn.className = 'remove-btn';
          btn.innerHTML = '&times;';
          btn.addEventListener('click', () => removeImage(file, wrapper));

          wrapper.appendChild(img);
          wrapper.appendChild(btn);
          preview.appendChild(wrapper);
        };
        reader.readAsDataURL(file);
      });

      updateCounter();
      fileInput.value = '';
    });

    function removeImage(file, wrapper) {
      filesArr = filesArr.filter(f => f !== file);
      preview.removeChild(wrapper);
      updateCounter();
    }

    function updateCounter() {
      counter.textContent = `${filesArr.length}/5`;
      const dataTransfer = new DataTransfer();
      filesArr.forEach(f => dataTransfer.items.add(f));
      fileInput.files = dataTransfer.files;
    }
  </script>
</body>
</html>
