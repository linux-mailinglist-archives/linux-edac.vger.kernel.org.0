Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8116A7420F3
	for <lists+linux-edac@lfdr.de>; Thu, 29 Jun 2023 09:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjF2H2S (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 29 Jun 2023 03:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjF2H2Q (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 29 Jun 2023 03:28:16 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA012705
        for <linux-edac@vger.kernel.org>; Thu, 29 Jun 2023 00:28:14 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b809354a15so1387235ad.1
        for <linux-edac@vger.kernel.org>; Thu, 29 Jun 2023 00:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688023694; x=1690615694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bdqfLgDUuJb07iu/eyFucllYJFRkleKz3YPajRNTUfQ=;
        b=MALEqPsBbcdOGOv3lUZJ9vMaPuk03aN+0l0/R2cId89A9k8aOU39fjgLiaOGjIqd7c
         OWOw4ZNugdZyOychlN6O3vnHjXwKP1dZnB2VB1O38DBs76BXk3z0Stvt9By/a8AzzNj8
         x0iUQ21LKxW0tRmTXWZfVMQ54MYZyHCuH9KIry95c2tas2rVS3gCTckMt1LkibG7TJCc
         7/rOHfLH1G/QX7ljW2Ur/Ti8Jwpc7eO2lPGKrnNC71KtPNmqCK2Jbi11xPOJatNV4q3s
         aydh42c/jSBdWj1kq3twayU1ka9pJioollyPYFFmHoDB3Bn6zP3u1IXbGDX/p211EmuN
         YRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688023694; x=1690615694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdqfLgDUuJb07iu/eyFucllYJFRkleKz3YPajRNTUfQ=;
        b=cVmcZR3Pixhcx9q5k2Jc7BmNbNTYkt/+7a6cYN7UiFlnxb0FjCK3Hgtvsng3+isgJo
         1S/aOoi9kyoj+AEnhmyZut/d1T/C8MCi+mNnKdgducfvwn4w1UNlDvUd5PT7QV1dcKGu
         7TURrQszmLYKmY4qk4ZypLvAYVF5ceKuM3OOJ5nSZ5GjXJpeOXY/FzT8kZPHp6f9kZfQ
         6Lg/79lJ7qRZimdMyBfLbdXcBycCvpgdf9Eyh64xGi5F7vVa3imGJDDPY0MMrxcrfSSq
         5Vfbfz256oq5eWMJDvVpuYrY+AKd9YQl4EBMqaaK4plgxYDK/U8lV19isBMgK9NsWept
         q9vQ==
X-Gm-Message-State: AC+VfDxA5zMRspH9BOQWWIKXZK9FhCr4uemtLwTDtH7lWRQ8K1PCdJzI
        knBANaJnWV7z/d36NyrZ9LaLIw==
X-Google-Smtp-Source: ACHHUZ4DRxYqRjjAIvQ5tkZF0JIo2v/rtV+thDhBRXHeE4toAqp6lOKKy5HrUDq4Bp5PsXKGRFwnKw==
X-Received: by 2002:a17:902:bc4c:b0:1b7:facb:2e79 with SMTP id t12-20020a170902bc4c00b001b7facb2e79mr8624136plz.18.1688023693996;
        Thu, 29 Jun 2023 00:28:13 -0700 (PDT)
Received: from localhost.localdomain ([203.208.189.13])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902aa8700b001b0358848b0sm8626844plr.161.2023.06.29.00.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 00:28:13 -0700 (PDT)
From:   lizhe.67@bytedance.com
To:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, lizefan.x@bytedance.com,
        yuanzhu@bytedance.com, lizhe.67@bytedance.com
Subject: [RFC] msr: judge the return val of function rdmsrl_on_cpu() by WARN_ON
Date:   Thu, 29 Jun 2023 15:27:54 +0800
Message-Id: <20230629072754.39844-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Li Zhe <lizhe.67@bytedance.com>

There are ten places call rdmsrl_on_cpu() in the current code without
judging the return value. This may introduce a potential bug. For example,
inj_bank_set() may return -EINVAL, show_base_frequency() may show an error
freq value, intel_pstate_hwp_set() may write an error value to the related
msr register and so on. But rdmsrl_on_cpu() do rarely returns an error, so
it seems that add a WARN_ON is enough for debugging.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 arch/x86/kernel/cpu/mce/inject.c |  2 +-
 drivers/cpufreq/intel_pstate.c   | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 12cf2e7ca33c..0a34057f4fc6 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -587,7 +587,7 @@ static int inj_bank_set(void *data, u64 val)
 	u64 cap;
 
 	/* Get bank count on target CPU so we can handle non-uniform values. */
-	rdmsrl_on_cpu(m->extcpu, MSR_IA32_MCG_CAP, &cap);
+	WARN_ON(rdmsrl_on_cpu(m->extcpu, MSR_IA32_MCG_CAP, &cap));
 	n_banks = cap & MCG_BANKCNT_MASK;
 
 	if (val >= n_banks) {
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 2548ec92faa2..fe2bdb38d6a0 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -859,7 +859,7 @@ static ssize_t show_base_frequency(struct cpufreq_policy *policy, char *buf)
 	if (ratio <= 0) {
 		u64 cap;
 
-		rdmsrl_on_cpu(policy->cpu, MSR_HWP_CAPABILITIES, &cap);
+		WARN_ON(rdmsrl_on_cpu(policy->cpu, MSR_HWP_CAPABILITIES, &cap));
 		ratio = HWP_GUARANTEED_PERF(cap);
 	}
 
@@ -883,7 +883,7 @@ static void __intel_pstate_get_hwp_cap(struct cpudata *cpu)
 {
 	u64 cap;
 
-	rdmsrl_on_cpu(cpu->cpu, MSR_HWP_CAPABILITIES, &cap);
+	WARN_ON(rdmsrl_on_cpu(cpu->cpu, MSR_HWP_CAPABILITIES, &cap));
 	WRITE_ONCE(cpu->hwp_cap_cached, cap);
 	cpu->pstate.max_pstate = HWP_GUARANTEED_PERF(cap);
 	cpu->pstate.turbo_pstate = HWP_HIGHEST_PERF(cap);
@@ -920,7 +920,7 @@ static void intel_pstate_hwp_set(unsigned int cpu)
 	if (cpu_data->policy == CPUFREQ_POLICY_PERFORMANCE)
 		min = max;
 
-	rdmsrl_on_cpu(cpu, MSR_HWP_REQUEST, &value);
+	WARN_ON(rdmsrl_on_cpu(cpu, MSR_HWP_REQUEST, &value));
 
 	value &= ~HWP_MIN_PERF(~0L);
 	value |= HWP_MIN_PERF(min);
@@ -1802,7 +1802,7 @@ static int core_get_min_pstate(int cpu)
 {
 	u64 value;
 
-	rdmsrl_on_cpu(cpu, MSR_PLATFORM_INFO, &value);
+	WARN_ON(rdmsrl_on_cpu(cpu, MSR_PLATFORM_INFO, &value));
 	return (value >> 40) & 0xFF;
 }
 
@@ -1810,7 +1810,7 @@ static int core_get_max_pstate_physical(int cpu)
 {
 	u64 value;
 
-	rdmsrl_on_cpu(cpu, MSR_PLATFORM_INFO, &value);
+	WARN_ON(rdmsrl_on_cpu(cpu, MSR_PLATFORM_INFO, &value));
 	return (value >> 8) & 0xFF;
 }
 
@@ -1855,7 +1855,7 @@ static int core_get_max_pstate(int cpu)
 	int tdp_ratio;
 	int err;
 
-	rdmsrl_on_cpu(cpu, MSR_PLATFORM_INFO, &plat_info);
+	WARN_ON(rdmsrl_on_cpu(cpu, MSR_PLATFORM_INFO, &plat_info));
 	max_pstate = (plat_info >> 8) & 0xFF;
 
 	tdp_ratio = core_get_tdp_ratio(cpu, plat_info);
@@ -1887,7 +1887,7 @@ static int core_get_turbo_pstate(int cpu)
 	u64 value;
 	int nont, ret;
 
-	rdmsrl_on_cpu(cpu, MSR_TURBO_RATIO_LIMIT, &value);
+	WARN_ON(rdmsrl_on_cpu(cpu, MSR_TURBO_RATIO_LIMIT, &value));
 	nont = core_get_max_pstate(cpu);
 	ret = (value) & 255;
 	if (ret <= nont)
@@ -1921,7 +1921,7 @@ static int knl_get_turbo_pstate(int cpu)
 	u64 value;
 	int nont, ret;
 
-	rdmsrl_on_cpu(cpu, MSR_TURBO_RATIO_LIMIT, &value);
+	WARN_ON(rdmsrl_on_cpu(cpu, MSR_TURBO_RATIO_LIMIT, &value));
 	nont = core_get_max_pstate(cpu);
 	ret = (((value) >> 8) & 0xFF);
 	if (ret <= nont)
@@ -2974,7 +2974,7 @@ static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 		intel_pstate_get_hwp_cap(cpu);
 
-		rdmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, &value);
+		WARN_ON(rdmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, &value));
 		WRITE_ONCE(cpu->hwp_req_cached, value);
 
 		cpu->epp_cached = intel_pstate_get_epp(cpu, value);
-- 
2.20.1

