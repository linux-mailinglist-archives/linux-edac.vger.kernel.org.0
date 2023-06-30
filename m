Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD647432D3
	for <lists+linux-edac@lfdr.de>; Fri, 30 Jun 2023 04:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjF3CnN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 29 Jun 2023 22:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjF3CnM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 29 Jun 2023 22:43:12 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6312728
        for <linux-edac@vger.kernel.org>; Thu, 29 Jun 2023 19:42:44 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666ed230c81so1291122b3a.0
        for <linux-edac@vger.kernel.org>; Thu, 29 Jun 2023 19:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688092964; x=1690684964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQzwJC7m5pmMPsN7WozWFdpmJNGjjOSZCRAiDKo1p9E=;
        b=NMcSJ8x3l6vUGOfXRI00MnGZUiQFkbcvwIM0EIatApsMbjg1jLIVlQM691rTy4W/pK
         udk0FbprwB2i/YlqoscyLYIXN+guFiIeBwoI+VWDkl7IPUF/Jk4HyepWXl+m2UdX+MUr
         pzVvESviRj7ErNyoA9rpe2kOOr61T4Tf2aUZ1X6gpCRCF+RtWUvZuVNW8kCGgpdSZwVE
         +vkO/TMFRou9RCo3Ayqap7LAftSJjT3cjRCR8RcnqMokTGFVQLHqDtRDqehzZ7D2bdfn
         6qu8WlKLt6F/HeA7oGzvdlqUKJTq4QK2oDWasdcmpGl/8koalOsZSqnuWSVC9EhfRlnW
         gVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688092964; x=1690684964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQzwJC7m5pmMPsN7WozWFdpmJNGjjOSZCRAiDKo1p9E=;
        b=Op6f17fyVhy2/lG2myeZoIh1qxLebqvAq8KAcfAQBkT1PEmkDg1AhwBV8ANFAkghyJ
         ycE2ZdBQq0f6xxPPZ4MGpn9iCEfWEPKpKtkmxvo5YBoLYglNyDQLZKyWoTNTx3B2G6V+
         jnOj1Sl+QrHXgt1dacLbXp52UVSyuFcgB+HkE834T+FagpGL9LDu+TuigSFSmgzlPjKG
         wmp2r+BNORAE2pK9xlsdAjMhFB63MpmovH8UGsEWFvrz4NPaq3zYzJje6Xje3z3wcKXa
         KJur7HqFLzfCwBLkLGqjNoHpbrm5/uSRr09Zg3ukjjEy2NDCTgE8muneF7T5GhAPcX8r
         GgZw==
X-Gm-Message-State: ABy/qLZiw1LvborMdxtAttvbDN+NBgfEjJad+V/7822V0F+rm8IlPBdW
        mtn1V6nVdtrRZ6Zid2wUFwmvqg==
X-Google-Smtp-Source: APBJJlHrriLNeQ9PcAhiV0izMNSAj3iVomQTBKBAWO9Mgy3URMX0ZpQovlUUHeL9wM/KgCpEvMALUA==
X-Received: by 2002:a05:6a00:17aa:b0:676:ad06:29d7 with SMTP id s42-20020a056a0017aa00b00676ad0629d7mr2313339pfg.15.1688092964347;
        Thu, 29 Jun 2023 19:42:44 -0700 (PDT)
Received: from localhost.localdomain ([203.208.189.12])
        by smtp.gmail.com with ESMTPSA id f4-20020aa78b04000000b0064fd4a6b306sm8938140pfd.76.2023.06.29.19.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 19:42:43 -0700 (PDT)
From:   lizhe.67@bytedance.com
To:     hpa@zytor.com
Cc:     bp@alien8.de, dave.hansen@linux.intel.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, lizefan.x@bytedance.com,
        lizhe.67@bytedance.com, mingo@redhat.com, rafael@kernel.org,
        tglx@linutronix.de, tony.luck@intel.com, viresh.kumar@linaro.org,
        x86@kernel.org, yuanzhu@bytedance.com
Subject: Re: [RFC] msr: judge the return val of function rdmsrl_on_cpu() by WARN_ON
Date:   Fri, 30 Jun 2023 10:42:34 +0800
Message-Id: <20230630024234.76075-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <1D4C4027-C450-4346-A2EA-CEEC94CFDA64@zytor.com>
References: <1D4C4027-C450-4346-A2EA-CEEC94CFDA64@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 29 Jun 2023 08:13:27 -0700, hpa@zytor.com wrote:
>>There are ten places call rdmsrl_on_cpu() in the current code without
>>judging the return value. This may introduce a potential bug. For example,
>>inj_bank_set() may return -EINVAL, show_base_frequency() may show an error
>>freq value, intel_pstate_hwp_set() may write an error value to the related
>>msr register and so on. But rdmsrl_on_cpu() do rarely returns an error, so
>>it seems that add a WARN_ON is enough for debugging.
>>
>>Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
>>---
>> arch/x86/kernel/cpu/mce/inject.c |  2 +-
>> drivers/cpufreq/intel_pstate.c   | 18 +++++++++---------
>> 2 files changed, 10 insertions(+), 10 deletions(-)
>>
>>diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
>>index 12cf2e7ca33c..0a34057f4fc6 100644
>>--- a/arch/x86/kernel/cpu/mce/inject.c
>>+++ b/arch/x86/kernel/cpu/mce/inject.c
>>@@ -587,7 +587,7 @@ static int inj_bank_set(void *data, u64 val)
>> 	u64 cap;
>> 
>> 	/* Get bank count on target CPU so we can handle non-uniform values. */
>>-	rdmsrl_on_cpu(m->extcpu, MSR_IA32_MCG_CAP, &cap);
>>+	WARN_ON(rdmsrl_on_cpu(m->extcpu, MSR_IA32_MCG_CAP, &cap));
>> 	n_banks = cap & MCG_BANKCNT_MASK;
>> 
>> 	if (val >= n_banks) {
>>diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
>>index 2548ec92faa2..fe2bdb38d6a0 100644
>>--- a/drivers/cpufreq/intel_pstate.c
>>+++ b/drivers/cpufreq/intel_pstate.c
>>@@ -859,7 +859,7 @@ static ssize_t show_base_frequency(struct cpufreq_policy *policy, char *buf)
>> 	if (ratio <= 0) {
>> 		u64 cap;
>> 
>>-		rdmsrl_on_cpu(policy->cpu, MSR_HWP_CAPABILITIES, &cap);
>>+		WARN_ON(rdmsrl_on_cpu(policy->cpu, MSR_HWP_CAPABILITIES, &cap));
>> 		ratio = HWP_GUARANTEED_PERF(cap);
>> 	}
>> 
>>@@ -883,7 +883,7 @@ static void __intel_pstate_get_hwp_cap(struct cpudata *cpu)
>> {
>> 	u64 cap;
>> 
>>-	rdmsrl_on_cpu(cpu->cpu, MSR_HWP_CAPABILITIES, &cap);
>>+	WARN_ON(rdmsrl_on_cpu(cpu->cpu, MSR_HWP_CAPABILITIES, &cap));
>> 	WRITE_ONCE(cpu->hwp_cap_cached, cap);
>> 	cpu->pstate.max_pstate = HWP_GUARANTEED_PERF(cap);
>> 	cpu->pstate.turbo_pstate = HWP_HIGHEST_PERF(cap);
>>@@ -920,7 +920,7 @@ static void intel_pstate_hwp_set(unsigned int cpu)
>> 	if (cpu_data->policy == CPUFREQ_POLICY_PERFORMANCE)
>> 		min = max;
>> 
>>-	rdmsrl_on_cpu(cpu, MSR_HWP_REQUEST, &value);
>>+	WARN_ON(rdmsrl_on_cpu(cpu, MSR_HWP_REQUEST, &value));
>> 
>> 	value &= ~HWP_MIN_PERF(~0L);
>> 	value |= HWP_MIN_PERF(min);
>>@@ -1802,7 +1802,7 @@ static int core_get_min_pstate(int cpu)
>> {
>> 	u64 value;
>> 
>>-	rdmsrl_on_cpu(cpu, MSR_PLATFORM_INFO, &value);
>>+	WARN_ON(rdmsrl_on_cpu(cpu, MSR_PLATFORM_INFO, &value));
>> 	return (value >> 40) & 0xFF;
>> }
>> 
>>@@ -1810,7 +1810,7 @@ static int core_get_max_pstate_physical(int cpu)
>> {
>> 	u64 value;
>> 
>>-	rdmsrl_on_cpu(cpu, MSR_PLATFORM_INFO, &value);
>>+	WARN_ON(rdmsrl_on_cpu(cpu, MSR_PLATFORM_INFO, &value));
>> 	return (value >> 8) & 0xFF;
>> }
>> 
>>@@ -1855,7 +1855,7 @@ static int core_get_max_pstate(int cpu)
>> 	int tdp_ratio;
>> 	int err;
>> 
>>-	rdmsrl_on_cpu(cpu, MSR_PLATFORM_INFO, &plat_info);
>>+	WARN_ON(rdmsrl_on_cpu(cpu, MSR_PLATFORM_INFO, &plat_info));
>> 	max_pstate = (plat_info >> 8) & 0xFF;
>> 
>> 	tdp_ratio = core_get_tdp_ratio(cpu, plat_info);
>>@@ -1887,7 +1887,7 @@ static int core_get_turbo_pstate(int cpu)
>> 	u64 value;
>> 	int nont, ret;
>> 
>>-	rdmsrl_on_cpu(cpu, MSR_TURBO_RATIO_LIMIT, &value);
>>+	WARN_ON(rdmsrl_on_cpu(cpu, MSR_TURBO_RATIO_LIMIT, &value));
>> 	nont = core_get_max_pstate(cpu);
>> 	ret = (value) & 255;
>> 	if (ret <= nont)
>>@@ -1921,7 +1921,7 @@ static int knl_get_turbo_pstate(int cpu)
>> 	u64 value;
>> 	int nont, ret;
>> 
>>-	rdmsrl_on_cpu(cpu, MSR_TURBO_RATIO_LIMIT, &value);
>>+	WARN_ON(rdmsrl_on_cpu(cpu, MSR_TURBO_RATIO_LIMIT, &value));
>> 	nont = core_get_max_pstate(cpu);
>> 	ret = (((value) >> 8) & 0xFF);
>> 	if (ret <= nont)
>>@@ -2974,7 +2974,7 @@ static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
>> 
>> 		intel_pstate_get_hwp_cap(cpu);
>> 
>>-		rdmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, &value);
>>+		WARN_ON(rdmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, &value));
>> 		WRITE_ONCE(cpu->hwp_req_cached, value);
>> 
>> 		cpu->epp_cached = intel_pstate_get_epp(cpu, value);
>
>Be careful here: if a return value of zero is acceptable as an equivalent of no return, the code is correct, as we always return zero if the MSR faults.

Thanks for your advice. I will take tglx@linutronix.de's advice to analysis each callsite.
