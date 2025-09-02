package com.univoice.DAOS;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class FeedbackAnalyticsRepo {

    @Autowired private JdbcTemplate jdbc;

    public Map<String,Integer> answerBreakdown(int questionId) {
        Map<String,Integer> result = new LinkedHashMap<>();

        // 1) If MCQ options exist, count against them
        List<String> options = jdbc.query(
            "SELECT option_text FROM feedback_options WHERE question_id=?",
            (rs, n) -> rs.getString("option_text"),
            questionId
        );

        if (!options.isEmpty()) {
            // Count responses by answer_value and match to options
            String sql = """
                SELECT o.option_text AS label, COALESCE(x.cnt,0) AS cnt
                FROM feedback_options o
                LEFT JOIN (
                    SELECT answer_value AS ans, COUNT(*) AS cnt
                    FROM feedback_answers
                    WHERE question_id=?
                    GROUP BY answer_value
                ) x ON x.ans = o.option_text
                WHERE o.question_id=?
                ORDER BY cnt DESC, o.option_text ASC
            """;
            jdbc.query(sql, rs -> {
                String label = rs.getString("label");
                if (label == null || label.isBlank()) label = "(No answer)";
                result.put(label, rs.getInt("cnt"));
            }, questionId, questionId);

        } else {
            // 2) For rating/free-text-like questions stored in answer_value
            String sql = """
                SELECT answer_value AS label, COUNT(*) AS cnt
                FROM feedback_answers
                WHERE question_id=?
                GROUP BY answer_value
                ORDER BY cnt DESC
            """;
            jdbc.query(sql, rs -> {
                String label = rs.getString("label");
                if (label == null || label.isBlank()) label = "(No answer)";
                result.put(label, rs.getInt("cnt"));
            }, questionId);
        }

        if (result.isEmpty()) {
            result.put("No responses yet", 1);
        }
        return result;
    }
}

