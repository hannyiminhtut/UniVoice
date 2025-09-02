package com.univoice.controllers;

import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.univoice.DAOS.FeedbackAnalyticsRepo;
import com.univoice.DAOS.FeedbackDAO;
import com.univoice.DAOS.FeedbackSessionDAO;
import com.univoice.models.FeedbackQuestions;
import com.univoice.models.FeedbackSession;

@Controller
@RequestMapping("admin-dashboard/viewfeedback")   // <— important
public class AdminFeedbackAnalyticsController {

    @Autowired private FeedbackSessionDAO feedbackSessionDAO;
    @Autowired private FeedbackDAO feedbackDAO;
    @Autowired private FeedbackAnalyticsRepo analyticsRepo;

    // /admin-dashboard/viewfeedback
    @GetMapping("")
    public String sessions(Model model) {
        model.addAttribute("sessions", feedbackSessionDAO.findAll());
        return "view-feedback";
    }

    // /admin-dashboard/viewfeedback/{sessionId}
    @GetMapping("{sessionId}")
    public String sessionQuestions(@PathVariable int sessionId, Model model) {
        FeedbackSession s = feedbackSessionDAO.findById(sessionId);
        List<FeedbackQuestions> qs = feedbackDAO.findQuestionsBySession(sessionId);
        model.addAttribute("session", s);
        model.addAttribute("questions", qs);
        return "view-feedback-questions";
    }

    @GetMapping(value = "api/question/{questionId}", produces = "application/json")
    @ResponseBody
    public Map<String, Object> breakdown(@PathVariable int questionId) {
        Map<String, Object> resp = new HashMap<>();
        try {
            Map<String, Integer> map = analyticsRepo.answerBreakdown(questionId); // may throw if repo not wired/SQL issue
            List<String> labels = new ArrayList<>(map.keySet());
            List<Integer> counts = new ArrayList<>();
            for (String k : labels) counts.add(map.get(k));
            resp.put("labels", labels);
            resp.put("counts", counts);
        } catch (Exception e) {
            // Log the server-side error so you can see the real root cause in logs
            e.printStackTrace();
            // Fallback payload so the UI still shows a chart instead of failing
            resp.put("labels", List.of("No responses yet"));
            resp.put("counts", List.of(1));
        }
        return resp;
    }


}
