#encoding: UTF-8

class Auditoria < ActiveRecord::Base

  ### SITUAÇÃO
  PENDENTE   = 63524
  LIBERADA   = 19326
  RESPONDIDA = 98743


  def self.verifica_e_libera_auditoria
    begin
      Thread.abort_on_exception = false
      Thread.new do
        while true do
          # p "********* ENTREI NA THREAD: #{DateTime.now} *********"
          auditoria = Auditoria.where(situacao: PENDENTE)
                               .order('created_at ASC')
                               .first rescue nil
          p auditoria

          if auditoria.present?
            auditoria.update_column(:situacao, LIBERADA)
          end
          # p "A THREAD DORMIU: #{DateTime.now}"
          sleep(5)
          # p "A THREAD ACORDOU: #{DateTime.now}"
        end
      end
    rescue Exception => e
      p e.message
      p e.backtrace
    end
  end

end
