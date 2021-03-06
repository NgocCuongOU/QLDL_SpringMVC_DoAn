<%-- 
    Document   : tour_management
    Created on : Sep 14, 2021, 8:53:30 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:url value="/admin/tour-management" var="action"/>

<!-- Main - content start -->
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
                        <td>Quốc gia</td>
                        <td>Số ngày/đêm</td>
                        <td>Số khách tối thiểu</td>
                        <td>Số khách tối đa</td>
                        <td>Vé đã đặt</td>
                        <td>Giá người lớn/trẻ em</td>
                        <td>Thời gian</td>
                        <td>Trạng thái</td>
                        <td class="user-table__tour-action">Hành động</td>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="tour" items="${tours}">
                        <div id="intro${tour.id}" hidden>${tour.introduction}</div>
                        <div id="service${tour.id}" hidden>${tour.service}</div>
                        <div id="note${tour.id}" hidden>${tour.note}</div>
                        <tr>
                            <td id="tourId${tour.id}">${tour.id}</td>
                            <td id="tourName${tour.id}">${tour.name}</td>
                            <td id="tourType${tour.id}" hidden>${tour.tourType}</td>
                            <td id="country${tour.id}">${tour.country}</td>
                            <td id="time${tour.id}">${tour.tourDays}/${tour.tourNights}</td>
                            <td id="minCus${tour.id}">${tour.minCustomer}</td>
                            <td id="maxCus${tour.id}">${tour.maxCustomer}</td>
                            <td id="booked${tour.id}">14</td>
                            <td id="price${tour.id}">${tour.adultsPrice}/${tour.childrenPrice}</td>
                            <td id="date${tour.id}">
                                <fmt:formatDate pattern="dd/MM/yyyy" value="${tour.startDate}"/>
                                <br>-<br>
                                <fmt:formatDate pattern="dd/MM/yyyy" value="${tour.endDate}"/>
                            </td>
                            <td>
                                <a href="#" class="btn active" id="active${tour.id}">
                                    <c:if test="${tour.active == true}">
                                        Đang hoạt động
                                    </c:if>
                                    <c:if test="${tour.active == false}">
                                        Ngưng hoạt động
                                    </c:if>
                                </a>
                            </td>
                            <td class="user-table__tour-action">
                                <a class="user-edit" href="javascript:;" onclick="getTourInfo(${tour.id})"><i class="fas fa-user-edit"></i></a>
                                <c:if test="${tour.tourDetails.isEmpty() && tour.tourPhotos.isEmpty() && tour.bookings.isEmpty()}">
                                <a class="user-delete" href="javascript:;" onclick="deleteTour(${tour.id})"><i class="fas fa-user-slash"></i></a>
                                </c:if>
                                <c:if test="${!tour.tourDetails.isEmpty() && !tour.tourPhotos.isEmpty() && !tour.bookings.isEmpty()}">

                                </c:if>
                            </td>   
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div class="container-fluid main-table">
        <div class="main-title">
            <h2><i class="fas fa-plus mr-2"></i></i>Thêm chuyến đi</h2>
        </div>
        <c:if test="${errMsg != null}">
            <div class="form-group">
                <span class="form-message-login error">
                    ${errMsg}
                </span>
            </div>
        </c:if>
        <c:if test="${successMsg != null}">
            <div class="form-group">
                <span class="form-message-login success">
                    ${successMsg}
                </span>
            </div>
        </c:if>
        <form:form action="${action}" class="form-add" modelAttribute="tour" enctype="multipart/form-data">
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="inputName" class="form-label col-form-label-lg ">Tên chuyến đi<span class="book-required">*</span></label>
                    <input type="text" name="name" path="name" class="form-control form-control-lg" id="inputName" placeholder="VD: Du lịch biển đảo">
                    <form:errors path="name" cssClass="text text-danger form-message" element="span" />
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="inputTypeTour" class="form-label col-form-label-lg">Loại chuyến đi<span class="book-required">*</span></label>
                        <select id="inputTypeTour" name="tourType" path="tourType" class="form-control">
                            <option selected disabled>Chọn loại</option>
                            <option value="Du lịch trong nước">Du lịch trong nước</option>
                            <option value="Du lịch nước ngoài">Du lịch nước ngoài</option>
                        </select>
                        <form:errors path="tourType" cssClass="text text-danger form-message" element="span" />
                    </div>
                </div>  
            </div>
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="inputDay" class="form-label col-form-label-lg">Số ngày<span class="book-required">*</span></label>
                    <input type="number" name="tourDays" path="tourDays" class="form-control form-control-lg" id="inputDay" value="0" min="0">
                    <form:errors path="tourDays" cssClass="text text-danger form-message" element="span" />
                </div>
                <div class="form-group col-md-6">
                    <label for="inputNight" class="form-label col-form-label-lg">Số đêm<span class="book-required">*</span></label>
                    <input type="number" name="tourNights" path="tourNights" class="form-control form-control-lg" id="inputNight" value="0" min="0">
                    <form:errors path="tourNights" cssClass="text text-danger form-message" element="span" />
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="inputMinCustomer" class="form-label col-form-label-lg">Số khách tối thiểu<span class="book-required">*</span></label>
                    <input type="number" name="minCustomer" path="minCustomer" class="form-control form-control-lg" id="inputMin" value="0" min="0">
                    <form:errors path="minCustomer" cssClass="text text-danger form-message" element="span" />
                </div>
                <div class="form-group col-md-6">
                    <label for="inputMaxCustomer" class="form-label col-form-label-lg">Số khách tối đa<span class="book-required">*</span></label>
                    <input type="number" name="maxCustomer" path="maxCustomer" class="form-control form-control-lg" id="inputMax" value="0" min="0">
                    <form:errors path="maxCustomer" cssClass="text text-danger form-message" element="span" />
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="inputPriceAdult" class="form-label col-form-label-lg">Giá người lớn<span class="book-required">*</span></label>
                    <div class="input-group">
                        <input type="number" name="adultsPrice" path="adultsPrice" class="form-control" id="inputPriceAdult" aria-label="Dollar amount (with dot and two decimal places)" value="0" min="0">
                        <span class="input-group-text">$</span>
                    </div>
                    <form:errors path="adultsPrice" cssClass="text text-danger form-message" element="span" />
                </div>
                <div class="form-group col-md-6">
                    <label for="inputPriceChild" class="form-label col-form-label-lg">Giá trẻ em<span class="book-required">*</span></label>
                    <div class="input-group">
                        <input type="number" name="childrenPrice" path="childrenPrice" class="form-control" id="inputPriceChild" aria-label="Dollar amount (with dot and two decimal places)" value="0" min="0">
                        <span class="input-group-text">$</span>
                    </div>
                    <form:errors path="childrenPrice" cssClass="text text-danger form-message" element="span" />
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="inputTimeStart" class="form-label col-form-label-lg">Ngày bắt đầu<span class="book-required">*</span></label>
                    <input type="date" name="startDate" path="startDate" class="form-control form-control-lg" id="inputTimeStart">
                </div>
                <div class="form-group col-md-6">
                    <label for="inputTimeEnd" class="form-label col-form-label-lg">Ngày kết thúc<span class="book-required">*</span></label>
                    <input type="date" name="endDate" path="endDate" class="form-control form-control-lg" id="inputTimeEnd">
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="inputFileTour" class="form-label col-form-label-lg">Ảnh chuyến đi<span class="book-required">*</span></label>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Thêm ảnh</span>
                        </div>
                        <div class="custom-file">
                            <input type="file" accept="image/*" name="file" path="file" class="custom-file-input" id="inputFileTour">
                            <label class="custom-file-label" for="inputFileTour">Chọn ảnh</label>
                        </div>
                    </div>
                </div>
                <div class="form-group col-md-6">
                    <label for="inputCountry" class="form-label col-form-label-lg">Quốc gia<span class="book-required">*</span></label>
                    <input type="text" name="country" path="country" class="form-control form-control-lg" id="inputCountry">
                    <form:errors path="country" cssClass="text text-danger form-message" element="span" />
                </div>
            </div>
            <div class="form-group">
                <label for="summernoteIntro" class="form-label col-form-label-lg">Giới thiệu<span class="book-required">*</span></label>
                <textarea class="form-control" id="summernoteIntro" path="introduction" name="introduction" rows="3"></textarea>
                <form:errors path="introduction" cssClass="text text-danger form-message" element="span" />
            </div>
            <div class="form-group">
                <label for="summernoteService" class="form-label col-form-label-lg">Dịch vụ<span class="book-required">*</span></label>
                <textarea class="form-control" id="summernoteService" path="service" name="service" rows="3"></textarea>
                <form:errors path="service" cssClass="text text-danger form-message" element="span" />
            </div>
            <div class="form-group">
                <label for="summernoteNote" class="form-label col-form-label-lg">Ghi chú<span class="book-required">*</span></label>
                <textarea class="form-control" id="summernoteNote" path="note" name="note" rows="3"></textarea>
                <form:errors path="note" cssClass="text text-danger form-message" element="span" />
            </div>
            <div class="form-check">
                <input class="form-check-input" name="active" type="checkbox" id="activeCheck" checked="true">
                <label class="form-check-label" for="activeCheck">
                    Active
                </label>
            </div>
            <input name="id" type="text" hidden id="tourId" value="0">
            <div class="form-group btn-wrapper">
                <button type="submit" id="abt" class="btn btn-lg">Thêm</button>
                <button type="reset" class="btn btn-lg" onclick="setBtn()">Làm mới</button>
            </div>
        </form:form>
    </div>
</div>
<!-- Main - content end -->

<!-- Script -->
<script src="<c:url value="/js/tour.js"/>"></script>
