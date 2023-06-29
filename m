Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56A3742932
	for <lists+linux-edac@lfdr.de>; Thu, 29 Jun 2023 17:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjF2PO4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 29 Jun 2023 11:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjF2POu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 29 Jun 2023 11:14:50 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735A730EC;
        Thu, 29 Jun 2023 08:14:49 -0700 (PDT)
Received: from [127.0.0.1] ([73.231.166.163])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 35TFDVZL1867686
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 29 Jun 2023 08:13:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 35TFDVZL1867686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023061001; t=1688051613;
        bh=VT6ScxQAx1InOOiCecxmoT8mrvGLQoZBicWdt25E8OM=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=B1zI0KT18kgwNJmZXDibpraDclwrlXMr3X9fqCQ7H4RdtQXV0295It0lEfL4rEpDX
         4eLN1CaOdl/Q8kSzbBatCArjd0rqGH1Ui2n6j8j4NiC/ngKbZiRhieaFltmy264b6U
         vT25k+FENHRuiYEgwBzSMMuFnIrUDsX6eEY8YNAfIbzggg+bQZcfuhrgAGGKPwJUlY
         qS6Tw5ikl5id4uxWzD6TM8ncbUbHspPLP11dXD8LIYYwWI6u3WbYut/4Mwvh/HyQsQ
         0rEk2Ems9OchsWTi3LuA8ekGSBhpUYDktz+GL+7Kz97DlnwdqHr6xpBBncJYXrdQF+
         1l9VMBh8DE1yw==
Date:   Thu, 29 Jun 2023 08:13:27 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     lizhe.67@bytedance.com, tony.luck@intel.com, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org
CC:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, lizefan.x@bytedance.com,
        yuanzhu@bytedance.com
Subject: =?US-ASCII?Q?Re=3A_=5BRFC=5D_msr=3A_judge_the_return_val_o?= =?US-ASCII?Q?f_function_rdmsrl=5Fon=5Fcpu=28=29_by_WARN=5FON?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20230629072754.39844-1-lizhe.67@bytedance.com>
References: <20230629072754.39844-1-lizhe.67@bytedance.com>
Message-ID: <1D4C4027-C450-4346-A2EA-CEEC94CFDA64@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On June 29, 2023 12:27:54 AM PDT, lizhe=2E67@bytedance=2Ecom wrote:
>From: Li Zhe <lizhe=2E67@bytedance=2Ecom>
>
>There are ten places call rdmsrl_on_cpu() in the current code without
>judging the return value=2E This may introduce a potential bug=2E For exa=
mple,
>inj_bank_set() may return -EINVAL, show_base_frequency() may show an erro=
r
>freq value, intel_pstate_hwp_set() may write an error value to the relate=
d
>msr register and so on=2E But rdmsrl_on_cpu() do rarely returns an error,=
 so
>it seems that add a WARN_ON is enough for debugging=2E
>
>Signed-off-by: Li Zhe <lizhe=2E67@bytedance=2Ecom>
>---
> arch/x86/kernel/cpu/mce/inject=2Ec |  2 +-
> drivers/cpufreq/intel_pstate=2Ec   | 18 +++++++++---------
> 2 files changed, 10 insertions(+), 10 deletions(-)
>
>diff --git a/arch/x86/kernel/cpu/mce/inject=2Ec b/arch/x86/kernel/cpu/mce=
/inject=2Ec
>index 12cf2e7ca33c=2E=2E0a34057f4fc6 100644
>--- a/arch/x86/kernel/cpu/mce/inject=2Ec
>+++ b/arch/x86/kernel/cpu/mce/inject=2Ec
>@@ -587,7 +587,7 @@ static int inj_bank_set(void *data, u64 val)
> 	u64 cap;
>=20
> 	/* Get bank count on target CPU so we can handle non-uniform values=2E =
*/
>-	rdmsrl_on_cpu(m->extcpu, MSR_IA32_MCG_CAP, &cap);
>+	WARN_ON(rdmsrl_on_cpu(m->extcpu, MSR_IA32_MCG_CAP, &cap));
> 	n_banks =3D cap & MCG_BANKCNT_MASK;
>=20
> 	if (val >=3D n_banks) {
>diff --git a/drivers/cpufreq/intel_pstate=2Ec b/drivers/cpufreq/intel_pst=
ate=2Ec
>index 2548ec92faa2=2E=2Efe2bdb38d6a0 100644
>--- a/drivers/cpufreq/intel_pstate=2Ec
>+++ b/drivers/cpufreq/intel_pstate=2Ec
>@@ -859,7 +859,7 @@ static ssize_t show_base_frequency(struct cpufreq_pol=
icy *policy, char *buf)
> 	if (ratio <=3D 0) {
> 		u64 cap;
>=20
>-		rdmsrl_on_cpu(policy->cpu, MSR_HWP_CAPABILITIES, &cap);
>+		WARN_ON(rdmsrl_on_cpu(policy->cpu, MSR_HWP_CAPABILITIES, &cap));
> 		ratio =3D HWP_GUARANTEED_PERF(cap);
> 	}
>=20
>@@ -883,7 +883,7 @@ static void __intel_pstate_get_hwp_cap(struct cpudata=
 *cpu)
> {
> 	u64 cap;
>=20
>-	rdmsrl_on_cpu(cpu->cpu, MSR_HWP_CAPABILITIES, &cap);
>+	WARN_ON(rdmsrl_on_cpu(cpu->cpu, MSR_HWP_CAPABILITIES, &cap));
> 	WRITE_ONCE(cpu->hwp_cap_cached, cap);
> 	cpu->pstate=2Emax_pstate =3D HWP_GUARANTEED_PERF(cap);
> 	cpu->pstate=2Eturbo_pstate =3D HWP_HIGHEST_PERF(cap);
>@@ -920,7 +920,7 @@ static void intel_pstate_hwp_set(unsigned int cpu)
> 	if (cpu_data->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE)
> 		min =3D max;
>=20
>-	rdmsrl_on_cpu(cpu, MSR_HWP_REQUEST, &value);
>+	WARN_ON(rdmsrl_on_cpu(cpu, MSR_HWP_REQUEST, &value));
>=20
> 	value &=3D ~HWP_MIN_PERF(~0L);
> 	value |=3D HWP_MIN_PERF(min);
>@@ -1802,7 +1802,7 @@ static int core_get_min_pstate(int cpu)
> {
> 	u64 value;
>=20
>-	rdmsrl_on_cpu(cpu, MSR_PLATFORM_INFO, &value);
>+	WARN_ON(rdmsrl_on_cpu(cpu, MSR_PLATFORM_INFO, &value));
> 	return (value >> 40) & 0xFF;
> }
>=20
>@@ -1810,7 +1810,7 @@ static int core_get_max_pstate_physical(int cpu)
> {
> 	u64 value;
>=20
>-	rdmsrl_on_cpu(cpu, MSR_PLATFORM_INFO, &value);
>+	WARN_ON(rdmsrl_on_cpu(cpu, MSR_PLATFORM_INFO, &value));
> 	return (value >> 8) & 0xFF;
> }
>=20
>@@ -1855,7 +1855,7 @@ static int core_get_max_pstate(int cpu)
> 	int tdp_ratio;
> 	int err;
>=20
>-	rdmsrl_on_cpu(cpu, MSR_PLATFORM_INFO, &plat_info);
>+	WARN_ON(rdmsrl_on_cpu(cpu, MSR_PLATFORM_INFO, &plat_info));
> 	max_pstate =3D (plat_info >> 8) & 0xFF;
>=20
> 	tdp_ratio =3D core_get_tdp_ratio(cpu, plat_info);
>@@ -1887,7 +1887,7 @@ static int core_get_turbo_pstate(int cpu)
> 	u64 value;
> 	int nont, ret;
>=20
>-	rdmsrl_on_cpu(cpu, MSR_TURBO_RATIO_LIMIT, &value);
>+	WARN_ON(rdmsrl_on_cpu(cpu, MSR_TURBO_RATIO_LIMIT, &value));
> 	nont =3D core_get_max_pstate(cpu);
> 	ret =3D (value) & 255;
> 	if (ret <=3D nont)
>@@ -1921,7 +1921,7 @@ static int knl_get_turbo_pstate(int cpu)
> 	u64 value;
> 	int nont, ret;
>=20
>-	rdmsrl_on_cpu(cpu, MSR_TURBO_RATIO_LIMIT, &value);
>+	WARN_ON(rdmsrl_on_cpu(cpu, MSR_TURBO_RATIO_LIMIT, &value));
> 	nont =3D core_get_max_pstate(cpu);
> 	ret =3D (((value) >> 8) & 0xFF);
> 	if (ret <=3D nont)
>@@ -2974,7 +2974,7 @@ static int intel_cpufreq_cpu_init(struct cpufreq_po=
licy *policy)
>=20
> 		intel_pstate_get_hwp_cap(cpu);
>=20
>-		rdmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, &value);
>+		WARN_ON(rdmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, &value));
> 		WRITE_ONCE(cpu->hwp_req_cached, value);
>=20
> 		cpu->epp_cached =3D intel_pstate_get_epp(cpu, value);

Be careful here: if a return value of zero is acceptable as an equivalent =
of no return, the code is correct, as we always return zero if the MSR faul=
ts=2E
