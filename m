Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D913A87F6
	for <lists+linux-edac@lfdr.de>; Tue, 15 Jun 2021 19:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhFORqc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Jun 2021 13:46:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:51071 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229732AbhFORq2 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 15 Jun 2021 13:46:28 -0400
IronPort-SDR: W9uQ1ST1mex8IgrJ52EPYOsZacveFibpuGXhLkc1LZf40gLuKz+A2u6xMzKlHiCLOq6TtiCJhC
 1F8mKW1ESjBA==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="291671796"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="291671796"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 10:44:21 -0700
IronPort-SDR: l47LUkdWoVQ/zabuEhLtkieiOnwUhulNSP61W50VBD24uNpBaGkijIV12Jh9ONefd8vfUzsIvh
 X0PbZ+YSyVsw==
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="484550066"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 10:44:21 -0700
Date:   Tue, 15 Jun 2021 10:44:19 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
Subject: [PATCH v2] EDAC/Intel: Do not load EDAC driver when running as a
 guest
Message-ID: <20210615174419.GA1087688@agluck-desk2.amr.corp.intel.com>
References: <YMfRxX/M4rJ5gM/R@zn.tnic>
 <16a34b6834f94f139444c2ff172645e9@intel.com>
 <YMhwAZaFr4d1QOGG@zn.tnic>
 <20210615150846.GA409@aus-x-yghannam.amd.com>
 <YMjE2iwRFWVrfzLL@zn.tnic>
 <20210615160009.GA29258@aus-x-yghannam.amd.com>
 <YMjRGFiqp2HNWUrZ@zn.tnic>
 <20210615163221.GA2991@aus-x-yghannam.amd.com>
 <20210615164525.GA1087213@agluck-desk2.amr.corp.intel.com>
 <YMjcpCDF1ZIGYinq@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMjcpCDF1ZIGYinq@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

There's little to no point in loading an EDAC driver running in a guest:
1) The CPU model reported by CPUID may not represent actual h/w
2) The hypervisor likely does not pass in access to memory controller devices
3) Hypervisors generally do not pass corrected error details to guests

Add a check in each of the Intel EDAC drivers for X86_FEATURE_HYPERVISOR
and simply return -ENODEV in the init routine.

Acked-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---

V2: Boris: s/boot_cpu_has/cpu_feature_enabled/

 drivers/edac/i10nm_base.c | 3 +++
 drivers/edac/pnd2_edac.c  | 3 +++
 drivers/edac/sb_edac.c    | 3 +++
 drivers/edac/skx_base.c   | 3 +++
 4 files changed, 12 insertions(+)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 238a4ad1e526..37b4e875420e 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -278,6 +278,9 @@ static int __init i10nm_init(void)
 	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
 		return -EBUSY;
 
+	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+		return -ENODEV;
+
 	id = x86_match_cpu(i10nm_cpuids);
 	if (!id)
 		return -ENODEV;
diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 928f63a374c7..c94ca1f790c4 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1554,6 +1554,9 @@ static int __init pnd2_init(void)
 	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
 		return -EBUSY;
 
+	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+		return -ENODEV;
+
 	id = x86_match_cpu(pnd2_cpuids);
 	if (!id)
 		return -ENODEV;
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 93daa4297f2e..4c626fcd4dcb 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -3510,6 +3510,9 @@ static int __init sbridge_init(void)
 	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
 		return -EBUSY;
 
+	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+		return -ENODEV;
+
 	id = x86_match_cpu(sbridge_cpuids);
 	if (!id)
 		return -ENODEV;
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index 6a4f0b27c654..4dbd46575bfb 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -656,6 +656,9 @@ static int __init skx_init(void)
 	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
 		return -EBUSY;
 
+	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+		return -ENODEV;
+
 	id = x86_match_cpu(skx_cpuids);
 	if (!id)
 		return -ENODEV;
-- 
2.29.2

