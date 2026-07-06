const app = {
    config: {},
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
    status: {
        talking: false,
        speaker: false,
        recording: false,
        handcuffed: false,
    },

    init: function() {
        console.log('[HUD] App initialized');
        this.setupListeners();
    },

    setupListeners: function() {
        window.addEventListener('message', (event) => {
            const data = event.data;
            
            if (data.action === 'initialize') {
                this.config = data.config;
                console.log('[HUD] Config received:', this.config);
            } else if (data.action === 'updateHud') {
                this.hudData = data.data;
                this.updateDisplay();
            } else if (data.action === 'toggleHud') {
                this.toggleHud(data.state);
            } else if (data.action === 'updateStatus') {
                this.updateStatus(data.status, data.state);
            } else if (data.action === 'notify') {
                this.showNotification(data.data);
            }
        });
    },

    updateDisplay: function() {
        if (this.config.ShowElements?.health !== false) {
            this.updateProgressBar('health', this.hudData.health);
        }

        if (this.config.ShowElements?.armor !== false) {
            this.updateProgressBar('armor', this.hudData.armor);
        }

        if (this.config.ShowElements?.hunger !== false) {
            this.updateProgressBar('hunger', this.hudData.hunger);
        }

        if (this.config.ShowElements?.thirst !== false) {
            this.updateProgressBar('thirst', this.hudData.thirst);
        }

        if (this.config.ShowElements?.stress !== false) {
            this.updateProgressBar('stress', this.hudData.stress);
        }

        if (this.config.ShowElements?.money !== false) {
            document.getElementById('cash-value').textContent = '$' + this.formatNumber(this.hudData.cash);
            document.getElementById('bank-value').textContent = '$' + this.formatNumber(this.hudData.bank);
        }

        if (this.config.ShowElements?.speedometer !== false) {
            document.getElementById('speed-value').textContent = this.hudData.speedometer;
        }

        if (this.config.ShowElements?.minimap !== false) {
            document.getElementById('location').textContent = this.hudData.location || 'Unknown';
        }
        if (this.config.ShowElements?.clock !== false) {
            document.getElementById('time').textContent = this.hudData.time || '00:00';
        }
    },

    updateProgressBar: function(type, value) {
        const element = document.getElementById(type + '-progress');
        const valueElement = document.getElementById(type + '-value');
        
        if (element) {
            element.style.width = Math.max(0, Math.min(100, value)) + '%';
        }
        if (valueElement) {
            valueElement.textContent = Math.floor(value);
        }
    },

    toggleHud: function(state) {
        const container = document.getElementById('hud-container');
        if (state) {
            container.classList.remove('hud-hidden');
        } else {
            container.classList.add('hud-hidden');
        }
    },

    updateStatus: function(status, state) {
        this.status[status] = state;
        const element = document.getElementById(status + '-indicator');
        
        if (element) {
            if (state) {
                element.classList.add('active');
            } else {
                element.classList.remove('active');
            }
        }
    },

    showNotification: function(data) {
        const container = document.getElementById('notifications');
        const notification = document.createElement('div');
        notification.className = 'notification ' + (data.type || 'info');
        notification.innerHTML = `
            <div>
                <div class="notification-title">${data.title || 'Notification'}</div>
                <div class="notification-message">${data.message || ''}</div>
            </div>
        `;
        
        container.appendChild(notification);
        
        setTimeout(() => {
            notification.style.animation = 'fadeOut 0.3s ease';
            setTimeout(() => {
                notification.remove();
            }, 300);
        }, data.duration || 5000);
    },

    formatNumber: function(num) {
        return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    },
};

if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => app.init());
} else {
    app.init();
}
