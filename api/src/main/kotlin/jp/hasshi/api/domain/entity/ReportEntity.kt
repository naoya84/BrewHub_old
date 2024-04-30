package jp.hasshi.api

import jakarta.persistence.*

@Entity(name = "report")
data class ReportEntity(
    @Id @GeneratedValue var id: Long = 0,
    var text: String = ""
){
    fun toReport(): Report{
        return Report(id = id, text = text)
    }
}
