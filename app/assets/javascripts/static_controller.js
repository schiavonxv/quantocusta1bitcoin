$(document).ready(function(){

        var message = document.getElementById("message");

        // Redimensiona o input de acordo com o tamanho.
        function resizeInput() {
            $(this).attr('size', $(this).val().length);
        }

        // // Mostra mensagem de carregando enquanto AJAX não foi completado.
        // $(document).ajaxStart(function(){
        //     message.value = "Perguntando a cotação para a raposa...";
        // });

        // Requisições ao servidor
        var atualizarCotacao = function(){

            // Mostrando mensagem de instrução na primeira vez que o usuário usa o recurso de cotação.
            if(message.getAttribute("data-count") == 0) {
                message.innerHTML = "Para calcular o preço, digite a quantidade de bitcoins desejada e pressione \"Enter\".";
                message.setAttribute("data-count", 1);
            } else {
                message.className = "hidden";
            }

            // Fazendo chamada à API do site
            $.ajax({
                url: "/api/v1/cotacao",
                data: { amount: document.getElementById("btc").value },
                type: "POST"
            }).done(function(json){

                json = jQuery.parseJSON(json);

                // Se a tela for menor do que 767px, mostra o R$ dentro do input.
                if ($(window).width() <= 767) {
                    document.getElementById("price").value = "R$ " + json.price;
                } else {
                    document.getElementById("price").value = json.price;
                }

                // Se BTC's disponíveis < valor pedido
                if (json.amount < json.requestedAmount) {
                    document.getElementById("btc").value = json.amount;
                    message.innerHTML = "Quantidade de bitcoins indisponível, mostrando apenas quantidade disponível."
                    message.className = "";
                }

                jQuery("#price")[0].resizeInput();

            }).fail(function(){
                message.innerHTML = "Wow, parece que algo de errado aconteceu. Tente novamente mais tarde.";
                message.className = "";
            });
        }

        // Atualiza cotação ao entrar na página
        atualizarCotacao();

        // Atualiza cotação ao pressionar Enter ou ao sair do input.
        // $("#btc").on("blur keyup", function(event){
        //     isEnter = (event.type === "keyup" && event.keyCode == 13);
        //     isBlur = (event.type === "blur");
        //     if(isEnter || isBlur) {
        //         atualizarCotacao();
        //     }
        // });

        $("#btc").on("keyup", function(event){
            atualizarCotacao();
        });



    });
