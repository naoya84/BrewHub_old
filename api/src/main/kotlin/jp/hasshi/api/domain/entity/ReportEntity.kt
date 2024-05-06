package jp.hasshi.api.domain.entity

import jakarta.persistence.*
import jp.hasshi.api.domain.model.Report

@Entity(name = "report")
data class ReportEntity(
    @Id @GeneratedValue var id: Long = 0,
    var text: String = ""
){
    fun toReport(): Report {
        return Report(id = id, text = text)
    }
}
