document.addEventListener("DOMContentLoaded", () => {
    const form = document.querySelector("#chat-form");
    const chatHistory = document.querySelector("#chat-history");

    form.addEventListener("ajax:success", (event) => {
        const [data, _status, _xhr] = event.detail;
        chatHistory.innerHTML = "";

        data.messages.forEach((message) => {
            const p = document.createElement("p");
            p.className = message.sender === "Você" ? "text-right text-blue-600 font-semibold" : "text-left text-green-600 font-semibold";
            p.innerHTML = `<strong>${message.sender}:</strong> ${message.text}`;
            chatHistory.appendChild(p);
        });

        form.querySelector("#user_input").value = "";
        form.querySelector("[name='awaiting_pain_level']").value = data.awaiting_pain_level;
    });

    form.addEventListener("ajax:error", () => {
        alert("Erro ao processar a mensagem.");
    });
});