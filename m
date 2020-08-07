Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A92D23EF07
	for <lists+linux-edac@lfdr.de>; Fri,  7 Aug 2020 16:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgHGO3F (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 Aug 2020 10:29:05 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:28088 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgHGO3E (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 7 Aug 2020 10:29:04 -0400
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 077ESrl4004514;
        Fri, 7 Aug 2020 14:28:53 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 32qtumu0hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 14:28:53 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id ADE724F;
        Fri,  7 Aug 2020 14:28:17 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
        id 472C0200F784F; Fri,  7 Aug 2020 09:28:17 -0500 (CDT)
From:   Kyle Meyer <kyle.meyer@hpe.com>
Cc:     russ.anderson@hpe.com, steve.wahl@hpe.com, kyle.meyer@hpe.com,
        tony.luck@intel.com, bp@alien8.de, linux-edac@vger.kernel.org
Subject: [PATCH] x86/MCE: Set the MCE's status and misc members
Date:   Fri,  7 Aug 2020 09:27:50 -0500
Message-Id: <20200807142750.270548-1-kyle.meyer@hpe.com>
X-Mailer: git-send-email 2.12.3
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_09:2020-08-06,2020-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008070105
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The MCE's status and misc members are initialized to zero
within mce_setup. Set the MCE's status and misc members to the
corresponding values passed in by the mem_err argument. This provides
support for the RAS: Corrected Errors Collector (CEC) which uses the
MCE.

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
---
 arch/x86/include/asm/mce.h     | 6 ++++--
 arch/x86/kernel/cpu/mce/apei.c | 8 ++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index cf503824529c..2346d900a232 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -79,8 +79,10 @@
 #define MCACOD_INSTR	0x0150	/* Instruction Fetch */
 
 /* MCi_MISC register defines */
-#define MCI_MISC_ADDR_LSB(m)	((m) & 0x3f)
-#define MCI_MISC_ADDR_MODE(m)	(((m) >> 6) & 7)
+#define MCI_MISC_ADDR_LSB(m)		((m) & 0x3f)
+#define MCI_MISC_ADDR_LSB_SET(x) 	((x) & 0x3f)
+#define MCI_MISC_ADDR_MODE(m)		(((m) >> 6) & 7)
+#define MCI_MISC_ADDR_MODE_SET(x) 	(((x) & 7) << 6)
 #define  MCI_MISC_ADDR_SEGOFF	0	/* segment offset */
 #define  MCI_MISC_ADDR_LINEAR	1	/* linear address */
 #define  MCI_MISC_ADDR_PHYS	2	/* physical address */
diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index af8d37962586..efdfb55b934a 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -38,6 +38,14 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 	/* Fake a memory read error with unknown channel */
 	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | 0x9f;
 
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN) {
+		m.status |= MCI_STATUS_MISCV;
+		m.misc |= MCI_MISC_ADDR_LSB_SET(ffs(
+					mem_err->physical_addr_mask) - 1) |
+			  MCI_MISC_ADDR_MODE_SET(MCI_MISC_ADDR_PHYS);
+	}
+
 	if (severity >= GHES_SEV_RECOVERABLE)
 		m.status |= MCI_STATUS_UC;
 
-- 
2.26.2

