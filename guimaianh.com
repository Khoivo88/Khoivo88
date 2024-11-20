<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tặng người đặc biệt</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Pacifico&display=swap');
        body {
            font-family: 'Pacifico', cursive;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #fff5f8;
            overflow: hidden;
            position: relative;
        }
        .background-emojis {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
        }
        .emoji {
            position: absolute;
            font-size: 2rem;
            animation: float 10s infinite;
        }
        @keyframes float {
            0% {
                transform: translateY(0);
                opacity: 1;
            }
            100% {
                transform: translateY(-200px);
                opacity: 0;
            }
        }
        .container {
            text-align: center;
            margin-bottom: 20px;
        }
        #message {
            font-size: 1rem;
            margin-bottom: 10px;
            color: #ff5c5c;
        }
        .button {
            padding: 10px 20px;
            font-size: 1rem;
            color: white;
            background-color: #ff5c5c;
            border: none;
            cursor: pointer;
            border-radius: 10px;
            transition: background-color 0.3s;
            margin: 5px;
        }
        .button:hover {
            background-color: #ff8585;
        }
        .frames-container {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 20px;
        }
        .photo-frame {
            width: 150px;
            height: 150px;
            border: 3px dashed #ff5c5c;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            position: relative;
            overflow: hidden;
            transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
        }
        .photo-frame img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .photo-frame:hover {
            transform: scale(1.1);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.4);
        }
        .love-message {
            font-size: 1.2rem;
            color: #ff5c5c;
            display: none;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="background-emojis">
        <span class="emoji" style="top: 10%; left: 15%;">💖</span>
        <span class="emoji" style="top: 30%; left: 70%;">🌟</span>
        <span class="emoji" style="top: 50%; left: 40%;">✨</span>
        <span class="emoji" style="top: 70%; left: 80%;">🌸</span>
        <span class="emoji" style="top: 90%; left: 20%;">🎀</span>
    </div>

    <div class="container">
        <p id="message">"Đối với anh, em luôn là người đặc biệt nhất. Mặc dù anh hay văn vở nhưng khi đứng trước em anh lại lúng túng không nói nên lời. Anh muốn nói là... anh yêu em rất nhiều. Liệu em có thể làm bạn gái anh không?"</p>
        <button class="button" onclick="shootHearts()">Đồng ý</button>
        <button class="button" id="noButton" onclick="changeText()">Không</button>
    </div>

    <div id="frames-container" class="frames-container">
        <!-- Khung ảnh với hình ảnh tải lên từ các URL -->
        <div class="photo-frame">
            <img src="https://i.imgur.com/nFtD2ux.jpeg" alt="Ảnh 1">
        </div>
        <div class="photo-frame">
            <img src="https://i.imgur.com/0u2C5iT.jpeg" alt="Ảnh 2">
        </div>
        <div class="photo-frame">
            <img src="https://i.imgur.com/upPDF6J.jpeg" alt="Ảnh 3">
        </div>
    </div>

    <p id="loveMessage" class="love-message">Anh yêu em rất nhiều!</p>

    <script>
        function createHeart(x, y) {
            const heart = document.createElement('div');
            heart.className = 'heart';
            heart.style.left = `${x}px`;
            heart.style.top = `${y}px`;
            document.body.appendChild(heart);

            setTimeout(() => {
                heart.remove();
            }, 2000);
        }

        function shootHearts() {
            const button = document.querySelector('.button');
            const rect = button.getBoundingClientRect();
            const centerX = rect.left + rect.width / 2;
            const centerY = rect.top + window.scrollY;

            for (let i = 0; i < 100; i++) {
                const angle = Math.random() * 2 * Math.PI;
                const radius = Math.random() * 200 + 50;
                const x = centerX + radius * Math.cos(angle);
                const y = centerY + radius * Math.sin(angle);
                createHeart(x, y);
            }

            // Hiển thị thông điệp "Anh yêu em rất nhiều!"
            document.getElementById('loveMessage').style.display = 'block';
        }

        function changeText() {
            const noButton = document.getElementById('noButton');
            noButton.innerText = "Không thể yêu ai ngoài anh";
        }
    </script>
</body>
</html>
