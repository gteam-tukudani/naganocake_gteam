<%= form_with model: @order, url: '/orders/confirm' , local: true do |f| %>
  <h4>支払い方法</h4>
  <%= f.radio_button :payment_method, "credit_card" %>
  <%= f.label :payment_method_credit_card, "クレジットカード" %>
  <%= f.radio_button :payment_method, "transfer" %>
  <%= f.label :payment_method_transfer, "銀行振込" %>

  <h3>お届け先</h3>
  <p><%= f.radio_button :select_address, 0 %>自身の住所</p>
     <%= current_end_user.full_address%>

登録済み住所
  <p><%= f.radio_button :select_address, 1 %>登録済み住所</p>
 <p><%= f.select :address_id , options_from_collection_for_select(@addresses, :id, :full_address) %></p>

新しいお届け先
  <p><%= f.radio_button :select_address, 2 %>新しいお届け先</p>

  <table>
    <tr>
      <td>郵便番号</td>
      <td> <%= f.text_field :postal_code %></td>
    </tr>
    <tr>
      <td>住所</td>
      <td><%= f.text_field :address %></td>
    </tr>
    <tr>
      <td>宛名</td>
      <td><%= f.text_field :name %></td>
    </tr>
  </table>

  <%= f.submit "確認画面へ進む" %>

<% end %>