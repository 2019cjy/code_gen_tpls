                <div class="form-group">
                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">${item.comment}</label>
                    <div class="col-xs-12 col-sm-9">
                        <input type="text" name="${item.name}" class="col-xs-12 col-sm-6 ace_datetime" value='<fmt:formatDate value="${r"${o."}${item.name}${r"}"}" pattern="yyyy-MM-dd HH:mm:ss"/>' />
                    </div>
                </div>