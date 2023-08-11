<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="springwork.datastructures.Base64Encoder" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Work CV</title>

  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700&display=swap" rel="stylesheet">

  <!-- CSS -->
  <link rel="stylesheet" href="../resources/assets/css/open-iconic-bootstrap.min.css">
  <link rel="stylesheet" href="../resources/assets/css/animate.css">
  <link rel="stylesheet" href="../resources/assets/css/owl.carousel.min.css">
  <link rel="stylesheet" href="../resources/assets/css/owl.theme.default.min.css">
  <link rel="stylesheet" href="../resources/assets/css/magnific-popup.css">
  <link rel="stylesheet" href="../resources/assets/css/owl.carousel.min.css">
  <link rel="stylesheet" href="../resources/assets/css/owl.theme.default.min.css">
  <link rel="stylesheet" href="../resources/assets/css/aos.css">
  <link rel="stylesheet" href="../resources/assets/css/ionicons.min.css">
  <link rel="stylesheet" href="../resources/assets/css/bootstrap-datepicker.css">
  <link rel="stylesheet" href="../resources/assets/css/jquery.timepicker.css">
  <link rel="stylesheet" href="../resources/assets/css/css/bootstrap-reboot.css">
  <link rel="stylesheet" href="../resources/assets/css/css/mixins/_text-hide.css">
  <link rel="stylesheet" href="../resources/assets/css/flaticon.css">
  <link rel="stylesheet" href="../resources/assets/css/icomoon.css">
  <link rel="stylesheet" href="../resources/assets/css/style.css">
  <link rel="stylesheet" href="../resources/assets/css/bootstrap/bootstrap-grid.css">
  <link rel="stylesheet" href="../resources/assets/css/bootstrap/bootstrap-reboot.css">

  <!-- JS -->
  <script src="../resources/assets/js/jquery.min.js"></script>
  <script src="../resources/assets/js/jquery-migrate-3.0.1.min.js"></script>
  <script src="../resources/assets/js/popper.min.js"></script>
  <script src="../resources/assets/js/bootstrap.min.js"></script>
  <script src="../resources/assets/js/jquery.easing.1.3.js"></script>
  <script src="../resources/assets/js/jquery.waypoints.min.js"></script>
  <script src="../resources/assets/js/jquery.stellar.min.js"></script>
  <script src="../resources/assets/js/owl.carousel.min.js"></script>
  <script src="../resources/assets/js/jquery.magnific-popup.min.js"></script>
  <script src="../resources/assets/js/aos.js"></script>
  <script src="../resources/assets/js/jquery.animateNumber.min.js"></script>
  <script src="../resources/assets/js/scrollax.min.js"></script>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="../resources/assets/js/google-map.js"></script>
  <script src="../resources/assets/js/main.js"></script>
  <script src="https://cdn.ckeditor.com/ckeditor5/29.0.0/classic/ckeditor.js"></script>
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
<body>
 <nav class="navbar navbar-expand-lg navbar-light bg-light">
     <div class="container-fluid px-md-4">
         <a class="navbar-brand" href="/">Work CV</a>

         <div class="collapse navbar-collapse" id="ftco-nav">
             <ul class="navbar-nav ml-auto">
                 <li class="nav-item active"><a href="${pageContext.request.contextPath}/Home/intro" class="nav-link">Trang chủ</a></li>
              <c:if test="${not sessionScope.loggedIn}">
                 <li class="nav-item cta cta-colored"><a href="${pageContext.request.contextPath}" class="nav-link">Đăng nhập</a></li>
              </c:if>
             <c:if test="${sessionScope.loggedIn}">
               <c:if test="${user.role.id == 1}">
                     <li class="nav-item"><a href="${pageContext.request.contextPath}/user/save-jobs" class="nav-link">Công việc đã lưu/ứng tuyển</a></li>
                      <li class="nav-item"><a href="${pageContext.request.contextPath}/user/follow-companies" class="nav-link">Công ty đã theo dõi/các việc theo dõi</a></li>
               </c:if>
                 <c:if test="${user.role.id == 2}">
                    <li class="nav-item"><a href="${pageContext.request.contextPath}/recruitment/post-list" class="nav-link">Danh sách bài đăng</a></li>
                    <li class="nav-item"><a href="${pageContext.request.contextPath}/recruitment/post" class="nav-link">Đăng tuyển</a></li>

                 </c:if>
                 <li class="nav-item"><a href="${pageContext.request.contextPath}/user/information" class="nav-link">Hồ Sơ</a></li>
                 <li class="nav-item"><a href="${pageContext.request.contextPath}/Home/logout" class="nav-link">Đăng xuất</a></li>
             </c:if>

             </ul>
         </div>
     </div>
 </nav>

<div class="hero-wrap hero-wrap-2" style="background-image: url(../resources/assets/images/bg_1.jpg);" data-stellar-background-ratio="0.5">
    <div class="overlay"></div>
    <div class="container">
        <div class="row no-gutters slider-text align-items-end justify-content-start">
            <div class="col-md-12 text-center mb-5">
                <h1 class="mb-3 bread">Hồ sơ </h1>
               <form id="myForm" action="uploadImage" enctype="multipart/form-data" method="POST">
                <div class="form-group">
                    <label class="btn btn-primary btn-md btn-file">
                        Chọn ảnh<input type="file" name="file" id="fileUpload" hidden>
                    </label>
                </div>
               </form>
               <c:set var="user" value="${sessionScope.user}" />
               <c:if test="${user.getImage() ne null}">
                    <div style="margin-left: 0px" id="divImage" >
                        <img id="avatar" height="100" width="100" style="border-radius: 50px" src="data:image/jpg;base64,${Base64Encoder.encode(user.getImage())}">
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>


<c:if test="${user.role.id == 2}">
<!-- HOME -->
<div  style="text-align: center">
    <p style="font-size: 20px;font-weight: bold;color: #aaa;margin-top: 10px">Xác thực email đăng nhập</p>
    <div style="width: 600px;height: 400px;border-radius: 5px;
    box-shadow: rgba(0, 0, 0, 0.4) 0px 0px 10px;margin: 20px auto;padding: 15px">
        <p style="line-height: 35px;font-size: 16px">Xin chào ${user.fullName}, <span></span> và làm theo hướng dẫn trong email.
            Trường hợp không nhận được email, bạn vui lòng bấm nút Nhận email xác thực dưới đây.</p>
        <div class="row form-group">
            <form action="Confirm-Account" method="post" class="col-md-12">
                <input type="hidden" value="${user.getEmail()}" name="email" class="btn px-4 btn-primary text-white">
                <input type="submit" value="Nhận email xác thực" class="btn px-4 btn-primary text-white">
            </form>
        </div>
        <p>Mọi thắc mắc vui lòng liên hệ bộ phận CSKH của WorkCV:<br></p>
        - Điện thoại:<span style="color:#5f80ec">(024) 6680 5588</span><br>
        - Email: <a href="#" style="color:#5f80ec"> hotro@workcv.vn</a>
    </div>
  <c:if test="${isConfirmed}">
   <div style="width: 600px;height: 400px;border-radius: 5px;
        box-shadow: rgba(0, 0, 0, 0.4) 0px 0px 10px;margin: 20px auto;padding: 15px>
        <p style="line-height: 35px;font-size: 16px">Xin chào  ${user.fullName}, <span  ></span> .Bạn đã gửi yêu cầu xác thực thành công,
            vui lòng kiểm tra mail để xác thực.Cảm ơn bạn!!!
        </p>
        <p>Mọi thắc mắc vui lòng liên hệ bộ phận CSKH của WorkCV:<br></p>
        - Điện thoại:<span style="color:#5f80ec">(024) 6680 5588</span><br>
        - Email: <a href="#" style="color:#5f80ec"> hotro@workcv.vn</a>
    </div>
   </c:if>
</div>
</c:if>


<c:if test="${user.role.id == 1}">
<section  class="site-section" style="margin-top: 10px">
    <div class="container">
            <div class="row align-items-center mb-5">
                <div class="col-lg-8 ">
                    <div class="d-flex align-items-center">
                      <form id="myFormUploadCv" action="uploadCV" method="POST" enctype="multipart/form-data">
                        <div class="form-group" style="margin-top: 15px">
                            <label class="btn btn-primary btn-md btn-file">
                                Chọn cv (pdf)<input type="file" name="file" id="fileUploadCV" required hidden>
                            </label>
                        </div>
                     </form>
                    </div>
                   <c:set var="dataCV" value="${sessionScope.dataCV}" />
                    <c:if test="${dataCV ne null}">
                        <a id="nameCv"  href="data:application/pdf;base64,${Base64Encoder.encode(dataCV)}"
                          download="${user.getFullName()}">Xem cv</a>
                    </c:if>

                <!--     <a style="color: red;margin-left: 20px"  data-toggle="modal" data-target="#exampleModal" >Xóa cv</a>-->
                    <a style="color: red;margin-left: 20px" id="xoa" data-toggle="modal" data-target="#exampleModal" ></a>
                </div>

                <div class="col-lg-4">
                    <div class="row">
<!--                        <div class="col-6">-->
<!--                            <button type="submit" id="myBtn" class="btn btn-block btn-light btn-md"><span class="icon-open_in_new mr-2"></span>Cập nhật cv</button>-->
<!--                        </div>-->
                    </div>
                </div>
            </div>


        <form action="updateProfileUser" method="post" >
            <div class="row align-items-center mb-5">
                <div class="col-lg-8 mb-4 mb-lg-0">
                    <div class="d-flex align-items-center">
                        <div>
                            <h2>Cập nhật thông tin</h2>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="row">

                        <div class="col-6">
                            <button type="submit" class="btn btn-block btn-primary btn-md">Lưu thông tin</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mb-5">
                <div class="col-lg-12">
                    <div class="p-4 p-md-5 border rounded" method="post">
                        <h3 class="text-black mb-5 border-bottom pb-2">Thông tin chi tiết</h3>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" class="form-control" id="email" name="email" value="${user.getEmail()}" required placeholder="you@yourdomain.com">
                              <c:if test="${not empty messageError}">
                                    <small class="text-danger">${messageError}</small>
                                </c:if>
                        </div>
                        <div class="form-group">
                            <label for="job-title">Full name</label>
                            <input type="text" class="form-control" name="fullName" value="${user.getFullName()}" required id="job-title" placeholder="Full name">
                        </div>
                        <div class="form-group">
                            <label for="job-location">Địa chỉ</label>
                            <input type="text" name="address" value="${user.getAddress()}" class="form-control" id="job-location" required placeholder="e.g. New York">
                        </div>
                        <div class="form-group">
                            <label for="job-location">Số điện thoại</label>
                            <input type="text" name="phoneNumber" value="${user.getPhoneNumber()}" class="form-control" id="job-location" required placeholder="+ 84"
                             pattern="[0-9]+" title="Vui lòng nhập số điện thoại hợp lệ (chỉ chấp nhận chuỗi số)">
                        </div>
                        <div class="form-group">
                            <label for="job-location">Mô tả bản thân</label>
                            <textarea  name="description"  class="form-control" id="editor" placeholder="Mô tả" required>${user.getDescription()} </textarea>
                        </div>

                    </div>

                </div>


            </div>
        </form>
    </div>
</section>

<!-- Modal -->
<div class="modal fade"  id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Bạn có chắc chắn muốn xóa ?</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Cv : <span id="cvXoa" ></span>
                <span th:if="${Cv != null}" th:text="${Cv.fileName}"></span>
                <form action="/user/deleteCv" method="post">
                    <div class="modal-footer mt-1">
                        <input type="hidden"  name="idCv">
                        <button type="submit" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                        <button type="submit" class="btn btn-danger">Xóa</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>
</c:if>


<c:if test="${user.role.id == 2}">
<section  class="site-section" style="margin-top: 10px">
    <div class="container">
        <div class="row">
            <div class="col-lg-6 mb-5">
                <h2 class="mb-4">Thông tin cá nhân</h2>
                <form action="updateProfilePersonalAdmin" method="POST">

                    <div class="row mb-5">
                        <div class="col-lg-12">
                            <div class="p-4 p-md-5 border rounded" >
                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" value="${user.getEmail()}" required placeholder="you@yourdomain.com">
                                      <c:if test="${not empty messageError}">
                                            <small class="text-danger">${messageError}</small>
                                        </c:if>
                                </div>
                                <div class="form-group">
                                    <label for="job-title">Họ và tên</label>
                                    <input type="text" class="form-control" name="fullName" value="${user.getFullName()}"  id="job-title" required placeholder="Full name">
                                </div>
                                <div class="form-group">
                                    <label for="job-location">Địa chỉ</label>
                                    <input type="text" name="address"  value="${user.getAddress()}" required class="form-control" id="job-location" placeholder="e.g. New York">
                                </div>
                                <div class="form-group">
                                    <label for="job-location">Số điện thoại</label>
                                    <input type="text" name="phoneNumber" value="${user.getPhoneNumber()}" required class="form-control" id="job-location" placeholder="+ 84"
                                           pattern="[0-9]+" title="Vui lòng nhập số điện thoại hợp lệ (chỉ chấp nhận chuỗi số)">

                                </div>
                                <div class="form-group">
                                    <label for="job-location">Mô tả bản thân</label>
                                    <textarea  name="description"  class="form-control" id="editor" placeholder="Mô tả" required>${user.getDescription()}</textarea>
                                </div>
                                <div class="row form-group">
                                    <div class="col-md-12">
                                        <input type="submit"  value="Lưu thông tin" class="btn px-4 btn-primary text-white">
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                </form>
            </div>
            <div class="col-lg-6">
                <h2 class="mb-4">Thông tin công ty</h2>

                        <label for="company-website-tw d-block1">Cập nhật Logo</label> <br>
                     <form id="myForm2" action="uploadImage2" enctype="multipart/form-data" method="POST">
                       <div class="form-group">
                        <label class="btn btn-primary btn-md btn-file">
                             Chọn ảnh<input type="file" name="file" id="fileUpload2" hidden>
                        </label>
                       </div>
                    </form>


                    <c:set var="dataLogo" value="${sessionScope.dataLogo}" />
                    <c:if test="${dataLogo ne null}">
                        <div id="divLogo">
                            <img id="avatar1" height="100" width="100" style="border-radius: 50px" src="data:image/jpg;base64,${Base64Encoder.encode(dataLogo)}">
                        </div>
                    </c:if>

                <form action="updateCompany" method="post" enctype="multipart/form-data" >
                    <div class="row mb-5">
                        <div class="col-lg-12">
                            <div class="p-4 p-md-5 border rounded" method="post">
                                <div class="form-group">
                                    <label for="email">Email</label>

                                    <input type="text" class="form-control"  id="email1" name="email"  placeholder="you@yourdomain.com" required>
                                </div>
                                <div class="form-group">
                                    <label for="job-title">Tên công ty</label>
                                    <input type="text" class="form-control" name="nameCompany" id="job-title"  placeholder="Full name" required>
                                    <input type="hidden" class="form-control" name="user_id" id="job-title" placeholder="Full name">
                                    <input type="hidden" class="form-control" name="id"  id="job-title" placeholder="Full name">

                                </div>
                                <div class="form-group">
                                    <label for="job-location">Địa chỉ</label>
                                    <input type="text" name="address"  required class="form-control" id="job-location" placeholder="e.g. New York">
                                </div>
                                <div class="form-group">
                                    <label for="job-location">Số điện thoại công ty</label>
                                    <input type="text" name="phoneNumber" required class="form-control" id="job-location" placeholder="+ 84"
                                                                               pattern="[0-9]+" title="Vui lòng nhập số điện thoại hợp lệ (chỉ chấp nhận chuỗi số)">
                                </div>
                                <div class="form-group">
                                    <label for="job-location">Mô tả công ty</label>
                                    <textarea  name="description"   class="form-control" id="editorN" placeholder="Mô tả" required></textarea>
                                </div>


                                <c:set var="dataLogo" value="${sessionScope.dataLogo}" />
                               <c:if test="${dataLogo ne null}">
                                <div style="margin-left: 0px" id="divImag1" >
                                    <img id="avatar" height="100" width="100" style="border-radius: 50px;margin-bottom: 15px" src="data:image/jpg;base64,${Base64Encoder.encode(dataLogo)}">
                                </div>
                                </c:if>

                                <div class="row form-group" >
                                    <div class="col-md-12">
                                        <input type="submit" value="Lưu thông tin" class="btn px-4 btn-primary text-white">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>
</c:if>


<footer th:replace="public/fragments :: footer" class="ftco-footer ftco-bg-dark ftco-section">

</footer>

<script>
//Only Admin


document.querySelector("#fileUpload2").addEventListener("change", function (event) {
    // get the file
    var file = this.files[0];

    if (file) {
        // Check if it's an image file and meets the size limit
        if (isImageFile(file) && checkFileSize(file, 5)) {
            console.log("Định dạng ảnh: " + file.type);
            document.querySelector("#myForm2").submit();
        } else {
            alert("Vui lòng chỉ chọn tệp ảnh có định dạng JPEG và kích thước không quá 5MB.");
        }
    }
});

</script>

<script>
//Using for User And Admin
document.querySelector("#fileUpload").addEventListener("change", function (event) {
    // get the file
    var file = this.files[0];

    if (file) {
        // Check if it's an image file and meets the size limit
        if (isImageFile(file) && checkFileSize(file, 5)) {
            console.log("Định dạng ảnh: " + file.type);
            document.querySelector("#myForm").submit();
        } else {
            alert("Vui lòng chỉ chọn tệp ảnh có định dạng JPEG và kích thước không quá 5MB.");
        }
    }
});


//Only for User (candidate)
document.querySelector("#fileUploadCV").addEventListener("change", function (event) {
    // get the file
    var file = this.files[0]; // Khai báo biến file ở đây

    if (file) {
        // Check if it's a PDF file and meets the size limit
        if (isPDFFile(file) && checkFileSize(file, 5)) {
            console.log("File format: " + file.type);
            document.querySelector("#myFormUploadCv").submit();
        } else {
            alert("Please select a PDF file with a size of up to 5MB.");
        }
    }
});






function isImageFile(file) {
    var imageType = file.type;
    return imageType.startsWith("image/") && (imageType === "image/jpeg" || imageType === "image/jpg");
}

function isPDFFile(file) {
    var fileName = file.name;
    var fileExtension = fileName.split('.').pop().toLowerCase();

    // Kiểm tra xem phần mở rộng có phải là "pdf" không
    return fileExtension === "pdf";
}

function checkFileSize(file, maxSizeInMB) {
    var maxSizeInBytes = maxSizeInMB * 1024 * 1024; // Convert MB to bytes
    return file.size <= maxSizeInBytes;
}


</script>
</body>
</html>