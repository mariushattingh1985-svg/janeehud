const app = {
    hudData: {
        health: 100,
        armor: 0,
        hunger: 100,
        thirst: 100,
        stress: 0,
        cash: 0,
        bank: 0,
        speedometer: 0,
        location: 'Unknown',
        time: '00:00',
    },

    init: function() {
        console.log('[HUD] App initialized');
        this.setupListeners();
    },

    setupListeners: function() {
        window.addEventListener('message', (event) => {
            const data = event.data;
            
            if (data.action === 'initialize') {
                console.log('[HUD] Initialized');
            } else if (data.action === 'updateHud') {
                this.hudData = data.data;
                this.updateDisplay();
            } else if (data.action === 'toggleHud') {
                this.toggleHud(data.state);
            }
        });
    },

    updateDisplay: function() {
        // Update Health
        const healthProgress = document.getElementById('health-progress');
        const healthValue = document.getElementById('health-value');
        if (healthProgress) healthProgress.style.width = Math.max(0, Math.min(100, this.hudData.health)) + '%';
        if (healthValue) healthValue.textContent = Math.floor(this.hudData.health);

        // Update Armor
        const armorProgress = document.getElementById('armor-progress');
        const armorValue = document.getElementById('armor-value');
        if (armorProgress) armorProgress.style.width = Math.max(0, Math.min(100, this.hudData.armor)) + '%';
        if (armorValue) armorValue.textContent = Math.floor(this.hudData.armor);

        // Update Hunger
        const hungerProgress = document.getElementById('hunger-progress');
        const hungerValue = document.getElementById('hunger-value');
        if (hungerProgress) hungerProgress.style.width = Math.max(0, Math.min(100, this.hudData.hunger)) + '%';
        if (hungerValue) hungerValue.textContent = Math.floor(this.hudData.hunger);

        // Update Thirst
        const thirstProgress = document.getElementById('thirst-progress');
        const thirstValue = document.getElementById('thirst-value');
        if (thirstProgress) thirstProgress.style.width = Math.max(0, Math.min(100, this.hudData.thirst)) + '%';
        if (thirstValue) thirstValue.textContent = Math.floor(this.hudData.thirst);

        // Update Stress
        const stressProgress = document.getElementById('stress-progress');
        const stressValue = document.getElementById('stress-value');
        if (stressProgress) stressProgress.style.width = Math.max(0, Math.min(100, this.hudData.stress)) + '%';
        if (stressValue) stressValue.textContent = Math.floor(this.hudData.stress);

        // Update Money
        const cashValue = document.getElementById('cash-value');
        const bankValue = document.getElementById('bank-value');
        if (cashValue) cashValue.textContent = '$' + this.formatNumber(this.hudData.cash);
        if (bankValue) bankValue.textContent = '$' + this.formatNumber(this.hudData.bank);

        // Update Speedometer
        const speedValue = document.getElementById('speed-value');
        if (speedValue) speedValue.textContent = Math.floor(this.hudData.speedometer);

        // Update Location
        const location = document.getElementById('location');
        if (location) location.textContent = this.hudData.location || 'Unknown';

        // Update Time
        const time = document.getElementById('time');
        if (time) time.textContent = this.hudData.time || '00:00';
    },

    toggleHud: function(state) {
        const container = document.getElementById('hud-container');
        if (container) {
            if (state) {
                container.classList.remove('hud-hidden');
            } else {
                container.classList.add('hud-hidden');
            }
        }
    },

    formatNumber: function(num) {
        num = parseInt(num) || 0;
        return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    },
};

if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => app.init());
} else {
    app.init();
}
