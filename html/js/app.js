const app = {
    hudData: {
        health: 100,
        armor: 0,
        hunger: 100,
        thirst: 100,
        stress: 0,
        cash: 0,
        bank: 0,
        job: 'Unemployed',
        jobGrade: '',
        speed: 0,
        location: 'Los Santos',
        street: 'Unknown Street',
        time: '00:00',
        players: 0,
    },

    init: function() {
        console.log('[QB-HUD] UI Loaded');
        this.setupListeners();
    },

    setupListeners: function() {
        window.addEventListener('message', (event) => {
            const data = event.data;
            
            if (data.action === 'initialize') {
                this.updateAllElements(data.data);
                console.log('[QB-HUD] Initialized');
            } else if (data.action === 'updateData') {
                this.hudData = data.data;
                this.updateAllElements(data.data);
            } else if (data.action === 'setVisible') {
                const container = document.getElementById('hud-container');
                if (container) {
                    if (data.visible) {
                        container.classList.remove('hud-hidden');
                        container.classList.add('hud-visible');
                    } else {
                        container.classList.add('hud-hidden');
                        container.classList.remove('hud-visible');
                    }
                }
            }
        });
    },

    updateAllElements: function(data) {
        // Health
        this.updateBar('health', data.health);
        
        // Armor
        this.updateBar('armor', data.armor);
        
        // Hunger
        this.updateBar('hunger', data.hunger);
        
        // Thirst
        this.updateBar('thirst', data.thirst);
        
        // Stress
        this.updateBar('stress', data.stress);
        
        // Location & Street
        const location = document.getElementById('location');
        if (location) location.textContent = data.location || 'Unknown';
        
        const street = document.getElementById('street');
        if (street) street.textContent = data.street || 'Unknown Street';
        
        // Time
        const time = document.getElementById('time');
        if (time) time.textContent = data.time || '00:00';
        
        // Players
        const players = document.getElementById('players');
        if (players) players.textContent = '👥 ' + (data.players || 0);
        
        // Job
        const job = document.getElementById('job');
        if (job) job.textContent = data.job || 'Unemployed';
        
        const jobGrade = document.getElementById('job-grade');
        if (jobGrade) jobGrade.textContent = data.jobGrade || '';
        
        // Money
        const cash = document.getElementById('cash');
        if (cash) cash.textContent = '$' + this.formatMoney(data.cash);
        
        const bank = document.getElementById('bank');
        if (bank) bank.textContent = '$' + this.formatMoney(data.bank);
        
        // Speed & Speedometer
        const speedometer = document.getElementById('speedometer-container');
        if (speedometer) {
            if (data.speed > 0) {
                speedometer.style.display = 'block';
            } else {
                speedometer.style.display = 'none';
            }
        }
        
        const speed = document.getElementById('speed');
        if (speed) speed.textContent = data.speed || 0;
    },

    updateBar: function(type, value) {
        value = Math.max(0, Math.min(100, value));
        
        const fill = document.getElementById(type + '-fill');
        if (fill) fill.style.width = value + '%';
        
        const valueEl = document.getElementById(type + '-value');
        if (valueEl) valueEl.textContent = Math.floor(value);
    },

    formatMoney: function(amount) {
        amount = parseInt(amount) || 0;
        return amount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    },
};

if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => app.init());
} else {
    app.init();
}
