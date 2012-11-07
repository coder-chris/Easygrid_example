<jq:jquery>
    jQuery("#${gridConfig.id}_table").jqGrid(
            {
        datatype: 'json',
        url: '${g.createLink(action: "${gridConfig.id}Rows", params: [selectionComp:params.selectionComp])}',
    <g:each in="${gridConfig.jqgrid}" var="property">
        "${property.key}":${property.value},
    </g:each>
    <g:if test="${gridConfig.inlineEdit}">
        editurl: '${g.createLink(action: "${gridConfig.id}InlineEdit")}',
        cellurl: '${g.createLink(action: "${gridConfig.id}InlineEdit")}',
    </g:if>
    colNames: [
    <grid:eachColumn gridConfig="${gridConfig}" >
        '${message(code: col.label, default: col.label)}'<g:if test="${!last}">,</g:if>
    </grid:eachColumn>
%{--
    <g:each in="${gridConfig.columns}" var="col" status="idx">
        '${message(code: col.label, default: col.label)}'<g:if test="${idx < gridConfig.columns.size() - 1}">,</g:if>
    </g:each>
--}%
    ],
   colModel: [
    <grid:eachColumn gridConfig="${gridConfig}" >
        {name:'${col.jqgrid.name}',
        <g:findAll in="${col.jqgrid}" expr="${!(it.key in ['name', 'searchClosure'])}">
            "${it.key}":${it.value},
        </g:findAll>
        },
    </grid:eachColumn>
%{--
    <g:each in="${gridConfig.columns}" var="column">
        {name:'${column.jqgrid.name}',
        <g:findAll in="${column.jqgrid}" expr="${!(it.key in ['name', 'searchClosure'])}">
            "${it.key}":${it.value},
        </g:findAll>
        },
    </g:each>
--}%
    ],
   viewrecords: true,
   pager: '#${gridConfig.id}Pager',
    <g:if test="${gridConfig.inlineEdit}">
        onSelectRow: function(id){

            jQuery("#${gridConfig.id}_table").jqGrid('editRow', id //, true
                , {
                    keys:true,
                    aftersavefunc:function (rowid, response) {
                    //todo
                    }
                }
            );
        }
    </g:if>
    });

    jQuery('#${gridConfig.id}_table').navGrid('#${gridConfig.id}Pager',
        {
            add: false,
            edit:false,
            del: false,
            search: false,
            refresh: true
        });


    jQuery('#${gridConfig.id}_table').filterToolbar(
        {
            autosearch: true,
            searchOnEnter: true
        });

</jq:jquery>

<table id="${gridConfig.id}_table"></table>
<div id="${gridConfig.id}Pager"></div>

