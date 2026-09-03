<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Thêm sản phẩm</title>
</head>

<body>

<h2>Thêm sản phẩm</h2>

<form action="${pageContext.request.contextPath}/admin/product/insert"
      method="post"
      enctype="multipart/form-data">

    <div>
        <label>Tên sản phẩm:</label>
        <br>

        <input type="text"
               name="productName"
               required>
    </div>

    <br>

    <div>
        <label>Giá:</label>
        <br>

        <input type="number"
               name="price"
               min="0"
               step="0.01"
               required>
    </div>

    <br>

    <div>
        <label>Số lượng:</label>
        <br>

        <input type="number"
               name="quantity"
               min="0"
               value="0"
               required>
    </div>

    <br>

    <div>
        <label>Ảnh sản phẩm:</label>
        <br>

        <input type="file"
               name="imageFile"
               accept="image/*">
    </div>

    <br>

    <div>
        <label>Mô tả:</label>
        <br>

        <textarea name="description"
                  rows="5"
                  cols="50"></textarea>
    </div>

    <br>

    <div>
        <label>Category:</label>
        <br>

        <select name="categoryId"
                required>

            <option value="">
                -- Chọn Category --
            </option>

            <c:forEach items="${listCategory}"
                       var="category">

                <option value="${category.categoryid}">
                    ${category.categoryname}
                </option>

            </c:forEach>

        </select>
    </div>

    <br>

    <div>
        <label>Trạng thái:</label>

        <input type="radio"
               name="status"
               value="1"
               checked>
        Hoạt động

        <input type="radio"
               name="status"
               value="0">
        Khóa
    </div>

    <br>

    <button type="submit">
        Thêm sản phẩm
    </button>

</form>

<br>

<a href="${pageContext.request.contextPath}/admin/products">
    Quay lại danh sách
</a>

</body>
</html>
