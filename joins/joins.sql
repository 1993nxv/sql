SELECT * FROM pgadmin.usuario
ORDER BY id ASC 

select item.id, item.quantidade, prod.id, prod.descricao, item.id_venda from pgecommerce.venda_item item 
left join pgecommerce.produto prod on 
prod.id = item.id_produto 
where id_venda = 1

select venda.id, usuario.login, funcionario.nome, venda.valor_total from pgecommerce.venda venda 
left join pgadmin.usuario usuario on 
usuario.id = venda.id_usuario_vendedor 
left join pgrh.funcionario funcionario on 
funcionario.id = usuario.id_funcionario