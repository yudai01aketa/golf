<%= form_tag(users_path, method: :get, enforce_utf8: false) do %>
  <%= autocomplete_field_tag 'user[name]', nil,  autocomplete_user_name_users_path %>
<% end %>

<%= autocomplete_field_tag 'user[name]', nil,  autocomplete_user_name_users_path %>



courses = RakutenWebService::Gora::Course
courses = RakutenWebService::Gora::Course.search(keyword: params[:term].to_s)

items[0].item.itemName

name = golf_course_name

<form action="xxx.php" method="post">
<fieldset>
エリア:
<input type="text" name="yourarea" autocomplete="on" list="tokyo">
<datalist id="tokyo">
<% courses.each do |course| %>
  <option value="#{course.name}">
<% end %>
</datalist><br>
<input type="submit" value="送信">
</fieldset>
</form>



<tr class="search-tr">
  <td class="search-item-head">
    <div>
      ゴルフ場名
    </div>
  </td>
  <td class="search-item-body">
    <div class="w-100">
      <%= f.search_field :place_cont, id: :place_id, placeholder: "入力に応じて候補が表示されます",
        class: "search-item-text" %>
      <%= f.hidden_field :course_id, id: :course_id %>
    </div>
  </td>
</tr>
