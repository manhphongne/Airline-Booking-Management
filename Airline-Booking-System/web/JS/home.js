
// --- Chọn loại chuyến ---
function toggleTripType(tripType) {
    const roundTripBtn = document.getElementById('roundTripBtn');
    const oneWayBtn = document.getElementById('oneWayBtn');
    const returnDateField = document.getElementById('returnDateField');
    const dateFields = document.getElementById('dateFields');

    const isRoundTrip = tripType === 'roundTrip';
    roundTripBtn.classList.toggle('custom-yellow-btn', isRoundTrip);
    roundTripBtn.classList.toggle('btn-secondary', !isRoundTrip);
    oneWayBtn.classList.toggle('custom-yellow-btn', !isRoundTrip);
    oneWayBtn.classList.toggle('btn-secondary', isRoundTrip);

    returnDateField.style.display = isRoundTrip ? 'block' : 'none';
    dateFields.className = isRoundTrip ? 'd-flex' : 'd-block';

    if (!isRoundTrip) {
        returnDate = null;
        document.getElementById('returnDate').textContent = 'Chọn ngày về';
    }
}


// --- Gợi ý địa điểm ---
function suggestLocations(type, value) {
    const suggestionsDiv = document.getElementById(`${type}Suggestions`);
    if (!value.trim()) {
        suggestionsDiv.innerHTML = '';
        return;
    }
    // Gọi API tìm kiếm
    fetch(`search_locations.php?keyword=${encodeURIComponent(value)}`)
            .then(response => response.json())
            .then(data => {
                if (data.error) {
                    console.error('Error:', data.error);
                    return;
                }
                suggestionsDiv.innerHTML = data.length
                        ? data.map(loc => `<div class="location-suggestion" onclick="selectLocation('${type}', '${loc.name}')">${loc.name}</div>`).join('')
                        : '<div class="location-suggestion">Không tìm thấy địa điểm</div>';
                suggestionsDiv.style.display = 'block';
            })
            .catch(error => {
                console.error('Error:', error);
                suggestionsDiv.innerHTML = '<div class="location-suggestion">Lỗi khi tìm kiếm</div>';
                suggestionsDiv.style.display = 'block';
            });
}

function selectLocation(type, location) {
    document.getElementById(`${type}Location`).value = location;
    document.getElementById(`${type}Suggestions`).innerHTML = '';
}



//
// Cache for search results
const suggestionCache = new Map();
let debounceTimeout = null;

// Multi-city segments
let multiCitySegments = [
    { from: '', to: '', date: '' }
];

// Location suggestions with debouncing and keyboard support
function suggestLocations(type, value, idx = null) {
    const isMulti = idx !== null;
    const suggestionsDiv = document.getElementById(isMulti ? `multi${type === 'from' ? 'From' : 'To'}Suggestions${idx}` : `${type}Suggestions`);
    const input = document.getElementById(isMulti ? `multi-${type}-${idx}` : `${type}Location`);
    suggestionsDiv.setAttribute('role', 'listbox');
    suggestionsDiv.setAttribute('aria-live', 'polite');

    if (!value.trim()) {
        suggestionsDiv.innerHTML = '';
        suggestionsDiv.style.display = 'none';
        input.setAttribute('aria-expanded', 'false');
        return;
    }

    suggestionsDiv.innerHTML = '<div class="location-suggestion" role="status">Đang tải...</div>';
    suggestionsDiv.style.display = 'block';
    input.setAttribute('aria-expanded', 'true');

    clearTimeout(debounceTimeout);
    debounceTimeout = setTimeout(async () => {
        const cacheKey = `${type}:${value.toLowerCase()}`;
        if (suggestionCache.has(cacheKey)) {
            renderSuggestions(type, suggestionCache.get(cacheKey), idx);
            return;
        }

        try {
            const response = await fetch(`search_locations.php?keyword=${encodeURIComponent(value)}`);
            if (!response.ok) throw new Error('Network error');
            const data = await response.json();

            if (data.error) {
                suggestionsDiv.innerHTML = '<div class="location-suggestion" role="alert">Lỗi: ' + data.error + '</div>';
                suggestionsDiv.style.display = 'block';
                return;
            }

            suggestionCache.set(cacheKey, data);
            renderSuggestions(type, data, idx);
        } catch (error) {
            console.error('Error:', error);
            try {
                const response = await fetch(`search_locations.php?keyword=${encodeURIComponent(value)}`);
                const data = await response.json();
                suggestionCache.set(cacheKey, data);
                renderSuggestions(type, data, idx);
            } catch (retryError) {
                suggestionsDiv.innerHTML = '<div class="location-suggestion" role="alert">Lỗi khi tìm kiếm. Vui lòng thử lại.</div>';
                suggestionsDiv.style.display = 'block';
            }
        }
    }, 300);
}

function renderSuggestions(type, data, idx = null) {
    const isMulti = idx !== null;
    const suggestionsDiv = document.getElementById(isMulti ? `multi${type === 'from' ? 'From' : 'To'}Suggestions${idx}` : `${type}Suggestions`);
    suggestionsDiv.innerHTML = data.length
        ? data.map((loc, index) => `
            <div class="location-suggestion" 
                 role="option" 
                 id="${isMulti ? `multi-${type}-suggestion-${idx}-${index}` : `${type}-suggestion-${index}`}" 
                 onclick="selectLocation('${type}', '${loc.name}', ${idx})"
                 onmouseenter="focusSuggestion('${type}', ${index}, ${idx})">
                ${loc.name}
            </div>`).join('')
        : '<div class="location-suggestion" role="alert">Không tìm thấy địa điểm</div>';
    suggestionsDiv.style.display = 'block';
}

function selectLocation(type, location, idx = null) {
    const isMulti = idx !== null;
    if (isMulti) {
        multiCitySegments[idx][type] = location;
        document.getElementById(`multi-${type}-${idx}`).value = location;
        document.getElementById(`multi${type === 'from' ? 'From' : 'To'}Suggestions${idx}`).innerHTML = '';
        document.getElementById(`multi${type === 'from' ? 'From' : 'To'}Suggestions${idx}`).style.display = 'none';
    } else {
        document.getElementById(`${type}Location`).value = location;
        document.getElementById(`${type}Suggestions`).innerHTML = '';
        document.getElementById(`${type}Suggestions`).style.display = 'none';
    }
}

function focusSuggestion(type, index, idx = null) {
    const isMulti = idx !== null;
    const suggestions = document.getElementById(isMulti ? `multi${type === 'from' ? 'From' : 'To'}Suggestions${idx}` : `${type}Suggestions`).querySelectorAll('.location-suggestion[role="option"]');
    suggestions.forEach((s, i) => {
        if (i === index) {
            s.setAttribute('data-focused', 'true');
            s.style.backgroundColor = '#f8f9fa';
            s.scrollIntoView({ block: 'nearest' });
        } else {
            s.removeAttribute('data-focused');
            s.style.backgroundColor = '';
        }
    });
}

function handleKeyboardNavigation(type, event, idx = null) {
    const isMulti = idx !== null;
    const suggestionsDiv = document.getElementById(isMulti ? `multi${type === 'from' ? 'From' : 'To'}Suggestions${idx}` : `${type}Suggestions`);
    const suggestions = suggestionsDiv.querySelectorAll('.location-suggestion[role="option"]');
    if (!suggestions.length) return;

    let focusedIndex = Array.from(suggestions).findIndex(s => s.hasAttribute('data-focused'));
    if (focusedIndex === -1) focusedIndex = 0;

    if (event.key === 'ArrowDown') {
        event.preventDefault();
        focusedIndex = Math.min(focusedIndex + 1, suggestions.length - 1);
        focusSuggestion(type, focusedIndex, idx);
    } else if (event.key === 'ArrowUp') {
        event.preventDefault();
        focusedIndex = Math.max(focusedIndex - 1, 0);
        focusSuggestion(type, focusedIndex, idx);
    } else if (event.key === 'Enter' && focusedIndex >= 0) {
        event.preventDefault();
        const location = suggestions[focusedIndex].textContent.trim();
        selectLocation(type, location, idx);
    } else if (event.key === 'Escape') {
        suggestionsDiv.innerHTML = '';
        suggestionsDiv.style.display = 'none';
        document.getElementById(isMulti ? `multi-${type}-${idx}` : `${type}Location`).setAttribute('aria-expanded', 'false');
    }
}

// Render multi-city segments
function renderMultiCitySegments() {
    const container = document.getElementById('multiCitySegments');
    const today = new Date().toISOString().split('T')[0];
    container.innerHTML = multiCitySegments.map((seg, idx) => `
        <div class="row align-items-end mb-2 multi-segment-row" data-segment="${idx}">
            <div class="col-lg-4 col-12 mb-3">
                <label class="mb-1">Điểm đi</label>
                <div class="dropdown">
                    <div class="input-group w-100">
                        <span class="input-group-text">✈️</span>
                        <input type="text" class="form-control multi-from" id="multi-from-${idx}" 
                               placeholder="Điểm khởi hành" value="${seg.from}" data-idx="${idx}" 
                               autocomplete="off" aria-autocomplete="list">
                    </div>
                    <div class="dropdown-menu location-dropdown" id="multiFromSuggestions${idx}"></div>
                </div>
            </div>
            <div class="col-lg-4 col-12 mb-3">
                <label class="mb-1">Điểm đến</label>
                <div class="dropdown">
                    <div class="input-group w-100">
                        <span class="input-group-text">✈️</span>
                        <input type="text" class="form-control multi-to" id="multi-to-${idx}" 
                               placeholder="Điểm đến" value="${seg.to}" data-idx="${idx}" 
                               autocomplete="off" aria-autocomplete="list">
                    </div>
                    <div class="dropdown-menu location-dropdown" id="multiToSuggestions${idx}"></div>
                </div>
            </div>
            <div class="col-lg-3 col-12 mb-3">
                <label class="mb-1">Ngày đi</label>
                <input type="date" class="form-control" id="multi-date-${idx}" 
                       value="${seg.date}" min="${today}" data-idx="${idx}">
            </div>
            <div class="col-lg-1 col-12 mb-3 d-flex align-items-center justify-content-center">
                <button type="button" class="btn btn-outline-danger btn-sm" 
                        onclick="removeSegment(${idx})" ${multiCitySegments.length <= 1 ? 'disabled' : ''}>Xóa</button>
            </div>
        </div>`).join('');

    // Attach event listeners
    container.querySelectorAll('.multi-from').forEach(input => {
        input.addEventListener('input', () => suggestLocations('from', input.value, input.dataset.idx));
        input.addEventListener('focus', () => suggestLocations('from', input.value, input.dataset.idx));
        input.addEventListener('keydown', (e) => handleKeyboardNavigation('from', e, input.dataset.idx));
    });
    container.querySelectorAll('.multi-to').forEach(input => {
        input.addEventListener('input', () => suggestLocations('to', input.value, input.dataset.idx));
        input.addEventListener('focus', () => suggestLocations('to', input.value, input.dataset.idx));
        input.addEventListener('keydown', (e) => handleKeyboardNavigation('to', e, input.dataset.idx));
    });
    container.querySelectorAll('input[type="date"]').forEach(input => {
        input.addEventListener('change', () => {
            const idx = input.dataset.idx;
            multiCitySegments[idx].date = input.value;
        });
    });
}

// Add a new segment
function addSegment() {
    multiCitySegments.push({ from: multiCitySegments[multiCitySegments.length - 1].to, to: '', date: '' });
    renderMultiCitySegments();
}

// Remove a segment
function removeSegment(idx) {
    if (multiCitySegments.length > 1) {
        multiCitySegments.splice(idx, 1);
        renderMultiCitySegments();
    }
}

// Passenger summary
function updatePassengerSummary(isMulti = false) {
    const prefix = isMulti ? 'Multi' : '';
    const adults = parseInt(document.getElementById(`adults${prefix}`).value) || 0;
    const children = parseInt(document.getElementById(`children${prefix}`).value) || 0;
    const infants = parseInt(document.getElementById(`infants${prefix}`).value) || 0;
    const form = document.getElementById(isMulti ? 'multiCityForm' : 'singleForm');
    form.dataset.passengers = JSON.stringify({ adults, children, infants });
}

document.addEventListener('DOMContentLoaded', function() {
    // Trip type handling
    const tripRadios = document.querySelectorAll('input[name="tripType"]');
    const singleForm = document.getElementById('singleForm');
    const multiCityForm = document.getElementById('multiCityForm');
    const returnDateCol = document.getElementById('returnDateCol');

    tripRadios.forEach(radio => {
        radio.addEventListener('change', function() {
            if (this.value === 'multiCity') {
                singleForm.style.display = 'none';
                multiCityForm.style.display = 'block';
                renderMultiCitySegments();
            } else {
                singleForm.style.display = 'block';
                multiCityForm.style.display = 'none';
                returnDateCol.style.display = this.value === 'oneWay' ? 'none' : 'block';
            }
        });
    });
    if (document.querySelector('input[name="tripType"]:checked').value === 'oneWay') {
        returnDateCol.style.display = 'none';
    }

    // Location input listeners for single form
    ['departure', 'arrival'].forEach(type => {
        const input = document.getElementById(`${type}Location`);
        input.setAttribute('aria-autocomplete', 'list');
        input.addEventListener('input', () => suggestLocations(type, input.value));
        input.addEventListener('focus', () => suggestLocations(type, input.value));
        input.addEventListener('keydown', (e) => handleKeyboardNavigation(type, e));
    });

    // Add segment button
    document.getElementById('addSegmentBtn').addEventListener('click', addSegment);

    // Passenger listeners
    ['adults', 'children', 'infants'].forEach(id => {
        document.getElementById(id).addEventListener('change', () => updatePassengerSummary());
    });
    ['adultsMulti', 'childrenMulti', 'infantsMulti'].forEach(id => {
        document.getElementById(id).addEventListener('change', () => updatePassengerSummary(true));
    });
    updatePassengerSummary();
    updatePassengerSummary(true);

    // Form submission
    singleForm.addEventListener('submit', (e) => {
        e.preventDefault();
        const tripType = document.querySelector('input[name="tripType"]:checked').value;
        const departure = document.getElementById('departureLocation').value;
        const arrival = document.getElementById('arrivalLocation').value;
        const departureDate = document.getElementById('departureDate').value;
        const returnDate = document.getElementById('returnDate').value;
        const passengers = JSON.parse(singleForm.dataset.passengers || '{}');
        const cabinClass = document.getElementById('cabinClass').value;

        if (!departure || !arrival) {
            alert('Vui lòng chọn điểm đi và điểm đến.');
            return;
        }
        if (!departureDate) {
            alert('Vui lòng chọn ngày đi.');
            return;
        }
        if (tripType === 'roundTrip' && !returnDate) {
            alert('Vui lòng chọn ngày về.');
            return;
        }
        if (!passengers.adults) {
            alert('Vui lòng chọn ít nhất một người lớn.');
            return;
        }

        console.log({ tripType, departure, arrival, departureDate, returnDate, passengers, cabinClass });
        alert('Đã gửi thông tin đặt vé!');
    });

    multiCityForm.addEventListener('submit', (e) => {
        e.preventDefault();
        const passengers = JSON.parse(multiCityForm.dataset.passengers || '{}');
        const cabinClass = document.getElementById('cabinClassMulti').value;

        if (multiCitySegments.some(seg => !seg.from || !seg.to || !seg.date)) {
            alert('Vui lòng điền đầy đủ thông tin cho tất cả các chặng.');
            return;
        }
        if (!passengers.adults) {
            alert('Vui lòng chọn ít nhất một người lớn.');
            return;
        }

        console.log({ tripType: 'multiCity', segments: multiCitySegments, passengers, cabinClass });
        alert('Đã gửi thông tin đặt vé!');
    });

    // Initialize multi-city form
    renderMultiCitySegments();
});

