<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                      <c:if test="${user.role.id == 2}">
                          <li class="nav-item cta mr-md-1"><a href="${pageContext.request.contextPath}/recruitment/post" class="nav-link">Đăng tuyển</a></li>
                          <li class="nav-item"><a href="${pageContext.request.contextPath}/user/list-post" class="nav-link">Danh sách bài đăng</a></li>
                      </c:if>
                      <li class="nav-item"><a href="${pageContext.request.contextPath}/user/information" class="nav-link">Hồ Sơ</a></li>
                       <li class="nav-item"><a href="${pageContext.request.contextPath}/Home/logout" class="nav-link">Đăng xuất</a></li>
                  </c:if>

              </ul>
          </div>
      </div>
  </nav>

<div class="hero-wrap hero-wrap-2" style="background-image: url(../resources/assets/images/bg_1.jpg);" data-stellar-background-ratio="0.5" th:if="${session.user.role.id == 2 }">
    <div class="overlay"></div>
    <div class="container">
        <div class="row no-gutters slider-text align-items-end justify-content-start">
            <div class="col-md-12 text-center mb-5">
                <p class="breadcrumbs mb-0"><span class="mr-3"><a href="index.html">Trang chủ <i class="ion-ios-arrow-forward"></i></a></span> Update<span></span></p>
                <h1 class="mb-3 bread">Cập nhật bài đăng</h1>
            </div>
        </div>
    </div>
</div>
<div th:if="${success}" class="toast" data-delay="2500" style="position:fixed; top: 100PX; right: 10PX;z-index: 2000;width: 300px">
    <script>
        swal({
            title: 'Update thành công!',
            /* text: 'Redirecting...', */
            icon: 'success',
            timer: 3000,
            buttons: true,
            type: 'success'
        })
    </script>
</div>

<!--<div th:if="${msg_register_error}" class="toast" data-delay="2500" style="position:fixed; top: 100PX; right: 10PX;z-index: 2000;width: 300px">-->
<!--    <div class="toast-header" style="background-color: red">-->

<!--        <strong class="mr-auto" style="color: white">Thông báo</strong>-->
<!--        <small style="color: white">Vừa xong</small>-->
<!--        <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">-->
<!--            <span aria-hidden="true" style="color: white">&times;</span>-->
<!--        </button>-->
<!--    </div>-->
<!--    <div class="toast-body" >-->
<!--        <p th:text="'❌ ' +${msg_register_error}"></p>-->
<!--    </div>-->
<!--    <script>-->
<!--        $(document).ready(function(){-->
<!--            $('.toast').toast('show');-->
<!--        });-->
<!--    </script>-->
<!--</div>-->
<!-- HOME -->
<section class="section-hero overlay inner-page bg-image" style="background-image: url(../resources/assets/images/bg_1.jpg));" id="home-section" th:if="${session.user.role.id == 2 }">
    <div class="container">
        <div class="row">
            <div class="col-md-7">
                <h1 class="text-white font-weight-bold">Update</h1>
                <div class="custom-breadcrumbs">
                    <a href="#">Trang chủ</a> <span class="mx-2 slash">/</span>
                    <span class="text-white"><strong>Chi tiết bài tuyển dụng</strong></span>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="site-section">
    <div class="container">
    <form action="editARecruitment" method="post">
        <div class="row align-items-center mb-5">
            <div class="col-lg-8 mb-4 mb-lg-0">
                <div class="d-flex align-items-center">
                    <div>
                        <h2>Cập Nhật</h2>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="row">
                    <div class="col-6">
                        <a href="#" class="btn btn-block btn-light btn-md"></a>
                    </div>
                    <div class="col-6">
                        <button type="submit" class="btn btn-block btn-primary btn-md">Cập nhật</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mb-5">
            <div class="col-lg-12">

                <div class="p-4 p-md-5 border rounded" >
                    <h3 class="text-black mb-5 border-bottom pb-2">Chi tiết bài tuyển dụng</h3>

                    <div class="form-group">
                        <label for="email">Tiêu đề</label>
                        <input type="text" class="form-control" id="email" name="title" value="${recruitment.title}"  required>
                        <input type="text" class="form-control" name="id" value="${recruitment.id}" style="display: none;">

                    </div>
                    <div class="form-group">
                        <label for="job-location">Mô tả công việc</label>
                         <textarea name="description" class="form-control" id="editorN" required>${recruitment.description}</textarea>
                    </div>
                    <div class="form-group">
                        <label for="job-title">Kinh nghiệm</label>
                        <input type="text" class="form-control" id="job-title" name="experience" value="${recruitment.experience}"required >
                    </div>
                    <div class="form-group">
                        <label for="job-title">Số người cần tuyển</label>
                        <input type="number" class="form-control" id="job-title" name="quantity" value="${recruitment.quantity}" min="1" required>
                    </div>
                    <div class="form-group">
                        <label for="job-location">Địa chỉ</label>
                        <input type="text" class="form-control" id="job-location"  name="address" value="${recruitment.address}"required>
                    </div>
                    <div class="form-group">
                        <label for="job-location">Hạn ứng tuyển</label>
                        <input type="date" class="form-control" id="job-location"  name="deadline" required>


                    </div>
                    <div class="form-group">
                        <label for="job-location">Lương</label>
                        <input type="number" class="form-control" id="job-location"  name="salary" value="${recruitment.salary}" min="1" required>
                    </div>

                    <div class="form-group">
                        <label for="job-region">Loại công việc</label>
                        <select class="form-control" name="type" aria-label="Default select example" required>
                               <option selected>Chọn loại công việc</option>
                            <option value="Part time">Part time</option>
                            <option value="Full time">Full time</option>
                            <option value="Freelancer">Freelancer</option>
                        </select>

                    </div>
                    <div class="form-group">
                        <label for="job-region">Danh mục công việc</label>
                        <select class="form-control" name="category_id" aria-label="Default select example" required>
                          <option selected>Chọn danh mục công việc</option>
                           <c:forEach items="${categories}" var="category">
                                 <option value="${category.id}">
                                       <c:out value="${category.name}" />
                                  </option>
                            </c:forEach>
                        </select>
                    </div>

                </div>
            </div>

        </div>
        <div class="row align-items-center mb-5">

            <div class="col-lg-4 ml-auto">
                <div class="row">
                    <div class="col-6">
                        <a href="#" class="btn btn-block btn-light btn-md"></a>
                    </div>
                    <div class="col-6">
                        <button type="submit" class="btn btn-block btn-primary btn-md">Cập nhật</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
    </div>
</section>
<script>
    ClassicEditor.create(document.querySelector('#editorN')).then(eidt => {
        console.log("da" + eidt);
    })
        .catch(error => {
            console.error(error);
        });
</script>
<footer th:replace="public/fragments :: footer" class="ftco-footer ftco-bg-dark ftco-section">

</footer>
</body>
</html>