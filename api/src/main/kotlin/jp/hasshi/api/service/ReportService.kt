package jp.hasshi.api.service

import jp.hasshi.api.domain.model.Report
import jp.hasshi.api.domain.entity.ReportEntity
import jp.hasshi.api.repository.ReportRepository
import org.springframework.stereotype.Service

interface ReportService {
    fun getAll(): List<Report>
    fun create(text: String): Report
}

@Service
class ReportServiceImpl(var reportRepository: ReportRepository): ReportService {
    override fun getAll(): List<Report> {
        return reportRepository.findAll().map( ReportEntity::toReport )
    }
    override fun create(text: String): Report {
        return reportRepository.save(ReportEntity(text = text)).toReport()
    }
}