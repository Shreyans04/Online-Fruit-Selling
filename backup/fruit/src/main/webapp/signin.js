

function showSignUp() {
    document.getElementById('signupDiv').style.display = 'block';
    document.querySelector('.signin').style.display = 'none';
}
function showCustomer() {
    document.getElementById('customerDiv').style.display = 'block';
    document.querySelector('.signup').style.display = 'none';
}
function showFarmer() {
    document.getElementById('farmerDiv').style.display = 'block';
    document.querySelector('.signup').style.display = 'none';
}
function showCustomerAddress() {
    document.getElementById('addressDiv').style.display = 'block';
    document.querySelector('.customer').style.display = 'none';
}
function showFarmerAddress() {
    document.getElementById('addressDiv').style.display = 'block';
    document.querySelector('.farmer').style.display = 'none';
}


function validateCustomer() {
    const firstName = document.getElementById('firstname');
    if(!/^[a-zA-Z]+$/.test(firstName.value.trim())) {
        alert('Please enter valid First Name. Only alphabets allowed');
        firstName.focus();
        return false;
    }

    const lastName = document.getElementById('lastname');
    if(!/^[a-zA-Z]+$/.test(lastName.value.trim())) {
        alert('Please enter your Last Name.');
        lastName.focus();
        return false;
    }

    const phoneNumber = document.getElementById('phonenumber');
    if(!/^\d{10}$/.test(phoneNumber.value)) {
        alert('Please enter a valid 10 digit phone number');
        phoneNumber.focus();
        return false;
    }

    const email = document.getElementById('emailid');
    if(!/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/i.test(email.value)) {
        alert('Please enter a valid email address.');
        email.focus();
        return false;
    }

    const registrationDate = new Date(document.getElementById('registrationdate').value);
    if(!isToday(registrationDate)) {
        alert('Registration date must be today\'s date');
        return false;
    }

    return true;
}

function isToday(date) {
    const today = new Date();
    return date.getDate() === today.getDate() &&
        date.getMonth() === today.getMonth() &&
        date.getFullYear() === today.getFullYear();
}

function validateFarmer() {
    const firstName = document.getElementById('firstname');
    if(!/^[a-zA-Z]+$/.test(firstName.value.trim())) {
        alert('Please enter valid First Name. Only alphabets allowed');
        firstName.focus();
        return false;
    }

    const lastName = document.getElementById('lastname');
    if(!/^[a-zA-Z]+$/.test(lastName.value.trim())) {
        alert('Please enter your Last Name.');
        lastName.focus();
        return false;
    }

    const phoneNumber = document.getElementById('phonenumber');
    if(!/^\d{10}$/.test(phoneNumber.value)) {
        alert('Please enter a valid 10 digit phone number');
        phoneNumber.focus();
        return false;
    }

    const email = document.getElementById('emailid');
    if(!/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/i.test(email.value)) {
        alert('Please enter a valid email address.');
        email.focus();
        return false;
    }

    const farm = document.getElementById('farmdetails');
    if(!/^[a-zA-Z0-9 ]+$/i.test(farm.value)) {
        alert('Enter Valid Farm details');
        farm.focus();
        return false;
    }

    const registrationDate = new Date(document.getElementById('registrationdate').value);
    if(!isToday(registrationDate)) {
        alert('Registration date must be today\'s date');
        return false;
    }

    return true;
}

function validateAddress() {
    const address = document.getElementById('address');
    if(!/^[a-zA-Z0-9\s,.'-]{3,}$/.test(address.value)) {
        alert('Please enter a valid Address. It should contain at least 3 characters.');
        address.focus();
        return false;
    }

    const city = document.getElementById('city');
    if(!/^[a-zA-Z\s]{2,}$/.test(city.value)) {
        alert('Please enter a valid City. It should contain at least 2 alphabets.');
        city.focus();
        return false;
    }

    const state = document.getElementById('state');
    if(!/^[a-zA-Z\s]{2,}$/.test(state.value)) {
        alert('Please enter a valid State. It should contain at least 2 alphabets.');
        state.focus();
        return false;
    }

    const country = document.getElementById('country');
    if(!/^[a-zA-Z\s]{2,}$/.test(country.value)) {
        alert('Please enter a valid Country. It should contain at least 2 alphabets.');
        country.focus();
        return false;
    }

    const pincode = document.getElementById('pincode');
    if(!/^[0-9]{6}$/.test(pincode.value)) {
        alert('Please enter a valid 6 digit Pincode.');
        pincode.focus();
        return false;
    }

    return true;
}

