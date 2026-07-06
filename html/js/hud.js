function updateHud(data) {
    window.postMessage({
        action: 'updateHud',
        data: data,
    }, '*');
}

function showHud() {
    window.postMessage({
        action: 'toggleHud',
        state: true,
    }, '*');
}

function hideHud() {
    window.postMessage({
        action: 'toggleHud',
        state: false,
    }, '*');
}

function toggleHud() {
    const container = document.getElementById('hud-container');
    const isHidden = container.classList.contains('hud-hidden');
    window.postMessage({
        action: 'toggleHud',
        state: isHidden,
    }, '*');
}

function setValue(type, value) {
    const element = document.getElementById(type + '-value');
    const progressElement = document.getElementById(type + '-progress');
    
    if (element) {
        element.textContent = Math.floor(value);
    }
    if (progressElement) {
        progressElement.style.width = Math.max(0, Math.min(100, value)) + '%';
    }
}

function setHealth(value) {
    setValue('health', value);
}

function setArmor(value) {
    setValue('armor', value);
}

function setHunger(value) {
    setValue('hunger', value);
}

function setThirst(value) {
    setValue('thirst', value);
}

function setStress(value) {
    setValue('stress', value);
}

function setMoney(cash, bank) {
    if (cash !== undefined) {
        const cashElement = document.getElementById('cash-value');
        if (cashElement) {
            cashElement.textContent = '$' + cash.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
        }
    }
    if (bank !== undefined) {
        const bankElement = document.getElementById('bank-value');
        if (bankElement) {
            bankElement.textContent = '$' + bank.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
        }
    }
}

function setLocation(location) {
    const element = document.getElementById('location');
    if (element) {
        element.textContent = location;
    }
}

function setTime(time) {
    const element = document.getElementById('time');
    if (element) {
        element.textContent = time;
    }
}

function setSpeed(speed) {
    const element = document.getElementById('speed-value');
    if (element) {
        element.textContent = speed;
    }
}

function showNotification(title, message, type = 'info', duration = 5000) {
    window.postMessage({
        action: 'notify',
        data: {
            title: title,
            message: message,
            type: type,
            duration: duration,
        },
    }, '*');
}

function setStatusIndicator(status, active) {
    window.postMessage({
        action: 'updateStatus',
        status: status,
        state: active,
    }, '*');
}

function setTalking(state) {
    setStatusIndicator('talking', state);
}

function setSpeaker(state) {
    setStatusIndicator('speaker', state);
}

function setRecording(state) {
    setStatusIndicator('recording', state);
}

function setHandcuffed(state) {
    setStatusIndicator('handcuffed', state);
}

function showElement(type) {
    const element = document.querySelector('[data-type="' + type + '"]');
    if (element) {
        element.style.display = 'flex';
    }
}

function hideElement(type) {
    const element = document.querySelector('[data-type="' + type + '"]');
    if (element) {
        element.style.display = 'none';
    }
}

function log(message) {
    console.log('[HUD] ' + message);
}

function logError(message) {
    console.error('[HUD ERROR] ' + message);
}
