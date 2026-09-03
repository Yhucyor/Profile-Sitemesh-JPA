<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Sửa sản phẩm</title>
</head>

<body>

<h2>Sửa sản phẩm</h2>

<form action="${pageContext.request.contextPath}/admin/product/update"
      method="post"
      enctype="multipart/form-data">

    <input type="hidden"
           name="productId"
           value="${product.productId}">

    <div>
        <label>Tên sản phẩm:</label>
        <br>

        <input type="text"
               name="productName"
               value="${product.productName}"
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
               value="${product.price}"
               required>
    </div>

    <br>

    <div>
        <label>Số lượng:</label>
        <br>

        <input type="number"
               name="quantity"
               min="0"
               value="${product.quantity}"
               required>
    </div>

    <br>

    <div>
        <label>Ảnh hiện tại:</label>
        <br>

        <c:if test="${not empty product.image}">
            <img
                    src="${pageContext.request.contextPath}/image?fname=${product.image}"
                    width="150"
                    height="120"
                    alt="${product.productName}">
        </c:if>
    </div>

    <br>

    <div>
        <label>Chọn ảnh mới:</label>
        <br>

        <input type="file"
               name="imageFile"
               accept="image/*">

        <p>
            Nếu không chọn ảnh mới thì giữ nguyên ảnh hiện tại.
        </p>
    </div>

    <br>

    <div>
        <label>Mô tả:</label>
        <br>

        <textarea name="description"
                  rows="5"
                  cols="50">${product.description}</textarea>
    </div>

    <br>

    <div>
        <label>Category:</label>
        <br>

        <select name="categoryId"
                required>

            <c:forEach items="${listCategory}"
                       var="category">

                <option
                        value="${category.categoryid}"
                        ${category.categoryid == product.category.categoryid
                                ? 'selected'
                                : ''}>

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
               ${product.status == 1 ? 'checked' : ''}>
        Hoạt động

        <input type="radio"
               name="status"
               value="0"
               ${product.status == 0 ? 'checked' : ''}>
        Khóa
    </div>

    <br>

    <button type="submit">
        Cập nhật sản phẩm
    </button>

</form>

<br>

<a href="${pageContext.request.contextPath}/admin/products">
    Quay lại danh sách
</a>

</body>
</html>
