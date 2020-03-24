Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E99F19120B
	for <lists+linux-edac@lfdr.de>; Tue, 24 Mar 2020 14:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgCXNwe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 24 Mar 2020 09:52:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44992 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbgCXNwe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 24 Mar 2020 09:52:34 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jGjyC-0006QD-A9; Tue, 24 Mar 2020 14:51:52 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 41C9E100292; Tue, 24 Mar 2020 14:51:51 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [patch V2 09/22] cpufreq: Convert to new X86 CPU match macros
In-Reply-To: <20200320131509.564059710@linutronix.de>
References: <20200320131345.635023594@linutronix.de> <20200320131509.564059710@linutronix.de>
Date:   Tue, 24 Mar 2020 14:51:51 +0100
Message-ID: <87eetheu88.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The new macro set has a consistent namespace and uses C99 initializers
instead of the grufty C89 ones.

Get rid the of most local macro wrappers for consistency. The ones which
make sense for readability are renamed to X86_MATCH*.

In the centrino driver this also removes the two extra duplicates of family
6 model 13 which have no value at all.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
---
V2: Add the dropped terminator in the centrino speedstep driver back. (Andy)
---
 drivers/cpufreq/acpi-cpufreq.c         |    4 -
 drivers/cpufreq/amd_freq_sensitivity.c |    2 
 drivers/cpufreq/e_powersaver.c         |    2 
 drivers/cpufreq/elanfreq.c             |    2 
 drivers/cpufreq/intel_pstate.c         |   71 ++++++++++++++++-----------------
 drivers/cpufreq/longhaul.c             |    2 
 drivers/cpufreq/longrun.c              |    3 -
 drivers/cpufreq/p4-clockmod.c          |    2 
 drivers/cpufreq/powernow-k6.c          |    4 -
 drivers/cpufreq/powernow-k7.c          |    2 
 drivers/cpufreq/powernow-k8.c          |    2 
 drivers/cpufreq/sc520_freq.c           |    2 
 drivers/cpufreq/speedstep-centrino.c   |   14 +-----
 drivers/cpufreq/speedstep-ich.c        |   10 +---
 drivers/cpufreq/speedstep-smi.c        |   10 +---
 15 files changed, 59 insertions(+), 73 deletions(-)

--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -991,8 +991,8 @@ late_initcall(acpi_cpufreq_init);
 module_exit(acpi_cpufreq_exit);
 
 static const struct x86_cpu_id acpi_cpufreq_ids[] = {
-	X86_FEATURE_MATCH(X86_FEATURE_ACPI),
-	X86_FEATURE_MATCH(X86_FEATURE_HW_PSTATE),
+	X86_MATCH_FEATURE(X86_FEATURE_ACPI, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_HW_PSTATE, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, acpi_cpufreq_ids);
--- a/drivers/cpufreq/amd_freq_sensitivity.c
+++ b/drivers/cpufreq/amd_freq_sensitivity.c
@@ -144,7 +144,7 @@ static void __exit amd_freq_sensitivity_
 module_exit(amd_freq_sensitivity_exit);
 
 static const struct x86_cpu_id amd_freq_sensitivity_ids[] = {
-	X86_FEATURE_MATCH(X86_FEATURE_PROC_FEEDBACK),
+	X86_MATCH_FEATURE(X86_FEATURE_PROC_FEEDBACK, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, amd_freq_sensitivity_ids);
--- a/drivers/cpufreq/e_powersaver.c
+++ b/drivers/cpufreq/e_powersaver.c
@@ -385,7 +385,7 @@ static struct cpufreq_driver eps_driver
 /* This driver will work only on Centaur C7 processors with
  * Enhanced SpeedStep/PowerSaver registers */
 static const struct x86_cpu_id eps_cpu_id[] = {
-	{ X86_VENDOR_CENTAUR, 6, X86_MODEL_ANY, X86_FEATURE_EST },
+	X86_MATCH_VENDOR_FAM_FEATURE(CENTAUR, 6, X86_FEATURE_EST, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, eps_cpu_id);
--- a/drivers/cpufreq/elanfreq.c
+++ b/drivers/cpufreq/elanfreq.c
@@ -198,7 +198,7 @@ static struct cpufreq_driver elanfreq_dr
 };
 
 static const struct x86_cpu_id elan_id[] = {
-	{ X86_VENDOR_AMD, 4, 10, },
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 4, 10, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, elan_id);
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1909,51 +1909,51 @@ static const struct pstate_funcs knl_fun
 	.get_val = core_get_val,
 };
 
-#define ICPU(model, policy) \
-	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_APERFMPERF,\
-			(unsigned long)&policy }
+#define X86_MATCH(model, policy)					 \
+	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6, INTEL_FAM6_##model, \
+					   X86_FEATURE_APERFMPERF, &policy)
 
 static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
-	ICPU(INTEL_FAM6_SANDYBRIDGE,		core_funcs),
-	ICPU(INTEL_FAM6_SANDYBRIDGE_X,		core_funcs),
-	ICPU(INTEL_FAM6_ATOM_SILVERMONT,	silvermont_funcs),
-	ICPU(INTEL_FAM6_IVYBRIDGE,		core_funcs),
-	ICPU(INTEL_FAM6_HASWELL,		core_funcs),
-	ICPU(INTEL_FAM6_BROADWELL,		core_funcs),
-	ICPU(INTEL_FAM6_IVYBRIDGE_X,		core_funcs),
-	ICPU(INTEL_FAM6_HASWELL_X,		core_funcs),
-	ICPU(INTEL_FAM6_HASWELL_L,		core_funcs),
-	ICPU(INTEL_FAM6_HASWELL_G,		core_funcs),
-	ICPU(INTEL_FAM6_BROADWELL_G,		core_funcs),
-	ICPU(INTEL_FAM6_ATOM_AIRMONT,		airmont_funcs),
-	ICPU(INTEL_FAM6_SKYLAKE_L,		core_funcs),
-	ICPU(INTEL_FAM6_BROADWELL_X,		core_funcs),
-	ICPU(INTEL_FAM6_SKYLAKE,		core_funcs),
-	ICPU(INTEL_FAM6_BROADWELL_D,		core_funcs),
-	ICPU(INTEL_FAM6_XEON_PHI_KNL,		knl_funcs),
-	ICPU(INTEL_FAM6_XEON_PHI_KNM,		knl_funcs),
-	ICPU(INTEL_FAM6_ATOM_GOLDMONT,		core_funcs),
-	ICPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS,     core_funcs),
-	ICPU(INTEL_FAM6_SKYLAKE_X,		core_funcs),
+	X86_MATCH(SANDYBRIDGE,		core_funcs),
+	X86_MATCH(SANDYBRIDGE_X,	core_funcs),
+	X86_MATCH(ATOM_SILVERMONT,	silvermont_funcs),
+	X86_MATCH(IVYBRIDGE,		core_funcs),
+	X86_MATCH(HASWELL,		core_funcs),
+	X86_MATCH(BROADWELL,		core_funcs),
+	X86_MATCH(IVYBRIDGE_X,		core_funcs),
+	X86_MATCH(HASWELL_X,		core_funcs),
+	X86_MATCH(HASWELL_L,		core_funcs),
+	X86_MATCH(HASWELL_G,		core_funcs),
+	X86_MATCH(BROADWELL_G,		core_funcs),
+	X86_MATCH(ATOM_AIRMONT,		airmont_funcs),
+	X86_MATCH(SKYLAKE_L,		core_funcs),
+	X86_MATCH(BROADWELL_X,		core_funcs),
+	X86_MATCH(SKYLAKE,		core_funcs),
+	X86_MATCH(BROADWELL_D,		core_funcs),
+	X86_MATCH(XEON_PHI_KNL,		knl_funcs),
+	X86_MATCH(XEON_PHI_KNM,		knl_funcs),
+	X86_MATCH(ATOM_GOLDMONT,	core_funcs),
+	X86_MATCH(ATOM_GOLDMONT_PLUS,	core_funcs),
+	X86_MATCH(SKYLAKE_X,		core_funcs),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
 
 static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] __initconst = {
-	ICPU(INTEL_FAM6_BROADWELL_D, core_funcs),
-	ICPU(INTEL_FAM6_BROADWELL_X, core_funcs),
-	ICPU(INTEL_FAM6_SKYLAKE_X, core_funcs),
+	X86_MATCH(BROADWELL_D,		core_funcs),
+	X86_MATCH(BROADWELL_X,		core_funcs),
+	X86_MATCH(SKYLAKE_X,		core_funcs),
 	{}
 };
 
 static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[] = {
-	ICPU(INTEL_FAM6_KABYLAKE, core_funcs),
+	X86_MATCH(KABYLAKE,		core_funcs),
 	{}
 };
 
 static const struct x86_cpu_id intel_pstate_hwp_boost_ids[] = {
-	ICPU(INTEL_FAM6_SKYLAKE_X, core_funcs),
-	ICPU(INTEL_FAM6_SKYLAKE, core_funcs),
+	X86_MATCH(SKYLAKE_X,		core_funcs),
+	X86_MATCH(SKYLAKE,		core_funcs),
 	{}
 };
 
@@ -2726,13 +2726,14 @@ static inline void intel_pstate_request_
 
 #define INTEL_PSTATE_HWP_BROADWELL	0x01
 
-#define ICPU_HWP(model, hwp_mode) \
-	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_HWP, hwp_mode }
+#define X86_MATCH_HWP(model, hwp_mode)					\
+	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6, INTEL_FAM6_##model, \
+					   X86_FEATURE_APERFMPERF, hwp_mode)
 
 static const struct x86_cpu_id hwp_support_ids[] __initconst = {
-	ICPU_HWP(INTEL_FAM6_BROADWELL_X, INTEL_PSTATE_HWP_BROADWELL),
-	ICPU_HWP(INTEL_FAM6_BROADWELL_D, INTEL_PSTATE_HWP_BROADWELL),
-	ICPU_HWP(X86_MODEL_ANY, 0),
+	X86_MATCH_HWP(BROADWELL_X,	INTEL_PSTATE_HWP_BROADWELL),
+	X86_MATCH_HWP(BROADWELL_D,	INTEL_PSTATE_HWP_BROADWELL),
+	X86_MATCH_HWP(ANY,		0),
 	{}
 };
 
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -910,7 +910,7 @@ static struct cpufreq_driver longhaul_dr
 };
 
 static const struct x86_cpu_id longhaul_id[] = {
-	{ X86_VENDOR_CENTAUR, 6 },
+	X86_MATCH_VENDOR_FAM(CENTAUR, 6, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, longhaul_id);
--- a/drivers/cpufreq/longrun.c
+++ b/drivers/cpufreq/longrun.c
@@ -281,8 +281,7 @@ static struct cpufreq_driver longrun_dri
 };
 
 static const struct x86_cpu_id longrun_ids[] = {
-	{ X86_VENDOR_TRANSMETA, X86_FAMILY_ANY, X86_MODEL_ANY,
-	  X86_FEATURE_LONGRUN },
+	X86_MATCH_VENDOR_FEATURE(TRANSMETA, X86_FEATURE_LONGRUN, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, longrun_ids);
--- a/drivers/cpufreq/p4-clockmod.c
+++ b/drivers/cpufreq/p4-clockmod.c
@@ -231,7 +231,7 @@ static struct cpufreq_driver p4clockmod_
 };
 
 static const struct x86_cpu_id cpufreq_p4_id[] = {
-	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_ACC },
+	X86_MATCH_VENDOR_FEATURE(INTEL, X86_FEATURE_ACC, NULL),
 	{}
 };
 
--- a/drivers/cpufreq/powernow-k6.c
+++ b/drivers/cpufreq/powernow-k6.c
@@ -258,8 +258,8 @@ static struct cpufreq_driver powernow_k6
 };
 
 static const struct x86_cpu_id powernow_k6_ids[] = {
-	{ X86_VENDOR_AMD, 5, 12 },
-	{ X86_VENDOR_AMD, 5, 13 },
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 5, 12, NULL),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 5, 13, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, powernow_k6_ids);
--- a/drivers/cpufreq/powernow-k7.c
+++ b/drivers/cpufreq/powernow-k7.c
@@ -109,7 +109,7 @@ static int check_fsb(unsigned int fsbspe
 }
 
 static const struct x86_cpu_id powernow_k7_cpuids[] = {
-	{ X86_VENDOR_AMD, 6, },
+	X86_MATCH_VENDOR_FAM(AMD, 6, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, powernow_k7_cpuids);
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -452,7 +452,7 @@ static int core_voltage_post_transition(
 
 static const struct x86_cpu_id powernow_k8_ids[] = {
 	/* IO based frequency switching */
-	{ X86_VENDOR_AMD, 0xf },
+	X86_MATCH_VENDOR_FAM(AMD, 0xf, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, powernow_k8_ids);
--- a/drivers/cpufreq/sc520_freq.c
+++ b/drivers/cpufreq/sc520_freq.c
@@ -95,7 +95,7 @@ static struct cpufreq_driver sc520_freq_
 };
 
 static const struct x86_cpu_id sc520_ids[] = {
-	{ X86_VENDOR_AMD, 4, 9 },
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 4, 9, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, sc520_ids);
--- a/drivers/cpufreq/speedstep-centrino.c
+++ b/drivers/cpufreq/speedstep-centrino.c
@@ -520,18 +520,12 @@ static struct cpufreq_driver centrino_dr
  * or ASCII model IDs.
  */
 static const struct x86_cpu_id centrino_ids[] = {
-	{ X86_VENDOR_INTEL, 6, 9, X86_FEATURE_EST },
-	{ X86_VENDOR_INTEL, 6, 13, X86_FEATURE_EST },
-	{ X86_VENDOR_INTEL, 6, 13, X86_FEATURE_EST },
-	{ X86_VENDOR_INTEL, 6, 13, X86_FEATURE_EST },
-	{ X86_VENDOR_INTEL, 15, 3, X86_FEATURE_EST },
-	{ X86_VENDOR_INTEL, 15, 4, X86_FEATURE_EST },
+	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL,  6,  9, X86_FEATURE_EST, NULL),
+	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL,  6, 13, X86_FEATURE_EST, NULL),
+	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 15,  3, X86_FEATURE_EST, NULL),
+	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 15,  4, X86_FEATURE_EST, NULL),
 	{}
 };
-#if 0
-/* Autoload or not? Do not for now. */
-MODULE_DEVICE_TABLE(x86cpu, centrino_ids);
-#endif
 
 /**
  * centrino_init - initializes the Enhanced SpeedStep CPUFreq driver
--- a/drivers/cpufreq/speedstep-ich.c
+++ b/drivers/cpufreq/speedstep-ich.c
@@ -319,15 +319,11 @@ static struct cpufreq_driver speedstep_d
 };
 
 static const struct x86_cpu_id ss_smi_ids[] = {
-	{ X86_VENDOR_INTEL, 6, 0xb, },
-	{ X86_VENDOR_INTEL, 6, 0x8, },
-	{ X86_VENDOR_INTEL, 15, 2 },
+	X86_MATCH_VENDOR_FAM_MODEL(INTEL,  6, 0x8, 0),
+	X86_MATCH_VENDOR_FAM_MODEL(INTEL,  6, 0xb, 0),
+	X86_MATCH_VENDOR_FAM_MODEL(INTEL, 15, 0x2, 0),
 	{}
 };
-#if 0
-/* Autoload or not? Do not for now. */
-MODULE_DEVICE_TABLE(x86cpu, ss_smi_ids);
-#endif
 
 /**
  * speedstep_init - initializes the SpeedStep CPUFreq driver
--- a/drivers/cpufreq/speedstep-smi.c
+++ b/drivers/cpufreq/speedstep-smi.c
@@ -299,15 +299,11 @@ static struct cpufreq_driver speedstep_d
 };
 
 static const struct x86_cpu_id ss_smi_ids[] = {
-	{ X86_VENDOR_INTEL, 6, 0xb, },
-	{ X86_VENDOR_INTEL, 6, 0x8, },
-	{ X86_VENDOR_INTEL, 15, 2 },
+	X86_MATCH_VENDOR_FAM_MODEL(INTEL,  6, 0x8, 0),
+	X86_MATCH_VENDOR_FAM_MODEL(INTEL,  6, 0xb, 0),
+	X86_MATCH_VENDOR_FAM_MODEL(INTEL, 15, 0x2, 0),
 	{}
 };
-#if 0
-/* Not auto loaded currently */
-MODULE_DEVICE_TABLE(x86cpu, ss_smi_ids);
-#endif
 
 /**
  * speedstep_init - initializes the SpeedStep CPUFreq driver
