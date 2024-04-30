package jp.hasshi.api

import org.springframework.stereotype.Service

interface ReportService {
    fun getAll(): List<Report>
    fun create(text: String): Report
}

@Service
class ReportServiceImpl(var reportRepository: ReportRepository): ReportService{
    override fun getAll(): List<Report> {
        return reportRepository.findAll().map( ReportEntity::toReport )
    }
    override fun create(text: String): Report {
        return reportRepository.save(ReportEntity(text = text)).toReport()
    }
}