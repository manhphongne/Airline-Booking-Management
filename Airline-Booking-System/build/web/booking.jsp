<%-- 
    Document   : booking
    Created on : May 13, 2025, 7:23:52 AM
    Author     : manhphong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking Page</title>

        <style>
            body {
                background-color: #f8f9fa;
            }

            .booking-container {
                max-width: 800px;
                margin: 50px auto;
                padding: 20px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .form-control:focus {
                border-color: #ffc107;
                box-shadow: 0 0 0 0.25rem rgba(255, 193, 7, 0.25);
            }

            .btn-primary {
                background-color: #ffc107;
                border-color: #ffc107;
                color: #000;
            }

            .btn-primary:hover {
                background-color: #ffca2c;
                border-color: #ffc720;
                color: #000;
            }

            .trip-type-btn {
                background-color: #fff;
                border: 1px solid #dee2e6;
                padding: 10px 20px;
                cursor: pointer;
            }

            .trip-type-btn.active {
                background-color: #ffc107;
                border-color: #ffc107;
                color: #000;
            }

            .location-suggestion {
                padding: 8px 12px;
                cursor: pointer;
            }

            .location-suggestion:hover {
                background-color: #f8f9fa;
            }

            .calendar-dropdown {
                padding: 15px;
                min-width: 300px;
                max-width: 100%;
                position: absolute;
                z-index: 1000;
                background: white;
                border: 1px solid rgba(0, 0, 0, .15);
                border-radius: 0.25rem;
                box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, .175);
            }

            .calendar-grid {
                display: grid;
                grid-template-columns: repeat(7, 1fr);
                gap: 5px;
                width: 100%;
            }

            .calendar-day {
                padding: 5px;
                text-align: center;
                cursor: pointer;
                min-width: 30px;
                height: 30px;
                line-height: 20px;
                font-size: 14px;
                border-radius: 4px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
            }

            .calendar-day:hover {
                background-color: #f8f9fa;
            }

            .calendar-day.selected {
                background-color: #ffc107;
                color: #000;
            }

            .calendar-day.disabled {
                color: #6c757d;
                cursor: not-allowed;
            }

            .calendar-price {
                font-size: 10px;
                color: #6c757d;
                margin-top: 2px;
            }

            .calendar-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 10px;
                padding: 0 10px;
            }

            .multi-segment-row {
                border: 1px solid #dee2e6;
                padding: 15px;
                margin-bottom: 15px;
                border-radius: 5px;
            }

            .dropdown-menu {
                max-height: 300px;
                overflow-y: auto;
            }
        </style>

    </head>
    <body>
        <div class="container">
            <div class="booking-container">
                <h2 class="text-center mb-4">Đặt vé máy bay</h2>

                <!-- Trip Type Selection -->
                <div class="d-flex justify-content-center mb-4">
                    <div class="btn-group" role="group">
                        <input type="radio" class="btn-check" name="tripType" id="roundTrip" value="roundTrip" checked>
                        <label class="btn btn-outline-secondary" for="roundTrip">Khứ hồi</label>

                        <input type="radio" class="btn-check" name="tripType" id="oneWay" value="oneWay">
                        <label class="btn btn-outline-secondary" for="oneWay">Một chiều</label>

                        <input type="radio" class="btn-check" name="tripType" id="multiCity" value="multiCity">
                        <label class="btn btn-outline-secondary" for="multiCity">Nhiều thành phố</label>
                    </div>
                </div>

                <!-- Single Trip Form -->
                <form id="singleForm">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="departureLocation" class="form-label">Điểm đi</label>
                            <div class="dropdown">
                                <div class="input-group">
                                    <span class="input-group-text">✈️</span>
                                    <input type="text" class="form-control" id="departureLocation"
                                           placeholder="Nhập điểm đi" autocomplete="off">
                                </div>
                                <div class="dropdown-menu location-dropdown" id="departureSuggestions"></div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="arrivalLocation" class="form-label">Điểm đến</label>
                            <div class="dropdown">
                                <div class="input-group">
                                    <span class="input-group-text">✈️</span>
                                    <input type="text" class="form-control" id="arrivalLocation" placeholder="Nhập điểm đến"
                                           autocomplete="off">
                                </div>
                                <div class="dropdown-menu location-dropdown" id="arrivalSuggestions"></div>
                            </div>
                        </div>
                    </div>

                    <!-- Date Inputs -->
                    <div class="row">
                        <div class="col-md-6">
                            <label for="departureDate" class="form-label">Ngày đi</label>
                            <input type="date" class="form-control" id="departureDate" name="departureDate" min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" required>
                        </div>
                        <div class="col-md-6">
                            <label for="returnDate" class="form-label">Ngày về</label>
                            <input type="date" class="form-control" id="returnDate" name="returnDate" min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label for="adults" class="form-label">Người lớn</label>
                            <select class="form-select" id="adults">
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="children" class="form-label">Trẻ em</label>
                            <select class="form-select" id="children">
                                <option value="0">0</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="infants" class="form-label">Em bé</label>
                            <select class="form-select" id="infants">
                                <option value="0">0</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                            </select>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="cabinClass" class="form-label">Hạng vé</label>
                            <select class="form-select" id="cabinClass">
                                <option value="economy">Phổ thông</option>
                                <option value="business">Thương gia</option>
                            </select>
                        </div>
                    </div>

                    <div class="text-center">
                        <button type="submit" class="btn btn-primary btn-lg">Tìm chuyến bay</button>
                    </div>
                </form>

                <!-- Multi City Form -->
                <form id="multiCityForm" style="display: none;">
                    <div id="multiCitySegments"></div>
                    <div class="text-center mb-3">
                        <button type="button" class="btn btn-outline-primary" id="addSegmentBtn">+ Thêm chặng</button>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label for="adultsMulti" class="form-label">Người lớn</label>
                            <select class="form-select" id="adultsMulti">
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="childrenMulti" class="form-label">Trẻ em</label>
                            <select class="form-select" id="childrenMulti">
                                <option value="0">0</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="infantsMulti" class="form-label">Em bé</label>
                            <select class="form-select" id="infantsMulti">
                                <option value="0">0</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                            </select>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="cabinClassMulti" class="form-label">Hạng vé</label>
                            <select class="form-select" id="cabinClassMulti">
                                <option value="economy">Phổ thông</option>
                                <option value="business">Thương gia</option>
                            </select>
                        </div>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary btn-lg">Tìm chuyến bay</button>
                    </div>
                </form>
            </div>
        </div>
                        
                        
                        
    </body>
</html>
