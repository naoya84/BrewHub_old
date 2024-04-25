package jp.hasshi.api

import org.springframework.stereotype.Service

interface ReportService {
    fun create(): Report
}

@Service
class ReportServiceImpl(): ReportService{
    override fun create(): Report {
        TODO("Not yet implemented")
    }
}