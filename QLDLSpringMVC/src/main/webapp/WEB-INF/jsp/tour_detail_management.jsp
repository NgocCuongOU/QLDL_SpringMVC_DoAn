<%-- 
    Document   : tour-detail-management
    Created on : Sep 17, 2021, 11:30:25 AM
    Author     : Admin
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="main-content">
    <div class="main-table">
        <div class="row main-title d-flex justify-content-between">
            <h2 class="col-12 col-md-6">Danh sách chuyến đi</h2>
            <form action="" class="col-12 col-md-6 form-search justify-content-between">
                <input type="text" name="tourName" placeholder="Tìm kiếm..." required="">
                <button><i class="fas fa-search"></i></button>
            </form>
        </div>   
        <div class="user-table">
            <table>
                <thead>
                    <tr>
                        <td>Mã chuyến đi</td>
                        <td>Tên chuyến đi</td>
                        <td>Loại chuyến đi</td>
                        <td>Số ngày</td>
                        <td>Số đêm</td>
                        <td>Giá người lớn</td>
                        <td>Giá trẻ em</td>
                        <td>Ngày bắt đầu</td>
                        <td>Ngày kết thúc</td>
                        <td>Trạng thái</td>
                        <td>Hành động</td>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="tour" items="${tours}">
                    <tr>
                        <td>${tour.id}</td>
                        <td>${tour.name}</td>
                        <td>${tour.tourType}</td>
                        <td>${tour.tourDays}</td>
                        <td>${tour.tourNights}</td>
                        <td>${tour.adultsPrice}</td>
                        <td>${tour.childrenPrice}</td>
                        <td><fmt:formatDate pattern="dd-MM-yyyy" value="${tour.startDate}"/></td>
                        <td><fmt:formatDate pattern="dd-MM-yyyy" value="${tour.endDate}"/></td>
                        <c:if test="${tour.active == true}">
                            <td><a href="#" class="btn active">Đang hoạt động</a></td>
                        </c:if>
                        <c:if test="${tour.active != true}">
                            <td><a href="#" class="btn active">Ngưng hoạt động</a></td>
                        </c:if>
                        <td>
                            <a class="user-edit" href="#"><i class="fas fa-user-edit"></i></a>
                            <a class="user-delete" href="#"><i class="fas fa-user-slash"></i></a>
                        </td>   
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div class="container-fluid main-table">
        <div class="main-title">
            <h2><i class="fas fa-plus mr-2"></i></i>Thêm chi tiết chuyến đi</h2>
        </div>
        <form:form class="form-add" modelAttribute="tourDetail">
            <div class="form-group">
                <label for="inputListTour" class="form-label col-form-label-lg">Mã chuyến đi</label>
                <select id="inputListTour" name="tourId" path="tourId" class="form-control form-control-lg">
                    <option selected disabled>Chọn mã tour</option>
                    <c:forEach var="tour" items="${tours}">
                        <option value="${tour.id}">${tour.id}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="inputDeparture" class="form-label col-form-label-lg">Điểm khởi hành</label>
                    <input type="text" name="departure" path="departure" class="form-control form-control-lg" id="inputDeparture">
                </div>
                <div class="form-group col-md-6">
                    <label for="inputDestination" class="form-label col-form-label-lg">Điểm đến</label>
                    <input type="text" name="destination" path="destination" class="form-control form-control-lg" id="inputDestination">
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="inputTimeStart" class="form-label col-form-label-lg">Ngày bắt đầu</label>
                    <input type="date" name="startDate" path="startDate" class="form-control form-control-lg" id="inputTimeStart">
                </div>
                <div class="form-group col-md-6">
                    <label for="inputTimeEnd" class="form-label col-form-label-lg">Ngày kết thúc</label>
                    <input type="date" name="endDate" path="endDate" class="form-control form-control-lg" id="inputTimeEnd">
                </div>
            </div>
            <div class="form-group">
                <label for="summernote" class="form-label col-form-label-lg">Nội dung</label>
                <textarea class="form-control" id="summernote" name="content" path="content" rows="3"></textarea>
            </div>
            <div class="form-group btn-wrapper">
                <button type="submit" class="btn btn-lg">Thêm</button>
            </div>
        </form:form>
    </div>
</div>
<!-- Script -->
<script>
    function summernote(id, placeholder) {
        $(id).summernote({
            placeholder: placeholder,
            tabsize: 2,
            height: 100,
        });
    }
    summernote('#summernote', 'Nhập điểm nhấn hành trình')
    summernote('#summernote2', 'Nhập lịch trình chuyến đi')
    summernote('#summernote3', 'Nhập dịch vụ chuyến đi')
    summernote('#summernote4', 'Nhập ghi chú chuyến đi')
</script>