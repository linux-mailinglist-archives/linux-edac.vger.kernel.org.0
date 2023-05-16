Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A197058C2
	for <lists+linux-edac@lfdr.de>; Tue, 16 May 2023 22:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjEPUZJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 May 2023 16:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjEPUY5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 May 2023 16:24:57 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698D01BC;
        Tue, 16 May 2023 13:24:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6FvlB2gZP0qak6Gj/hdfj1Mws5mDBkSJz1EdUzV+3eTS672ZmNdTyJURXB4Tqa8vbcu2bZ4rnsE8LcBBGUMXGAU3a0QPiTuGZ0PftNlT2OhawtlUp1zpmmJBjwMx778Okbm6k+czsuuHyx+ijY304KV1d8iFStlWdT5y0QDRif0cZlvsvK1fV3/sgs5YnQKorFrXqJBFDXfUjqFSSpm86NuU04WXuEXUEPdhu+10lDdiw9ELdiUwm+VnFxVR2TX+fSRXXkJ9IySR3PrIKHr+ZVCNUq2+kCgiBV6dfSegUg2FG3vvLsg901GfQutlDGYjkT6xwsHRopn72HGmDp9Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aexl6TLvJ/4QZ7zfoc/S19jZVCUFyKnSkpg5FHlRV/s=;
 b=Djd16SJyO3c602TgEP7DMcDeKHPlIjaWhkv39j0d7QdlrSsLVwBKmHQPrAQUw96h5H5aZw03IZG6v5i6JpbziUGOHdww/NqGClGp/fckcT1iRzfb9FPK2AOo25iepU4fwSYaEh32B5/BR7ipP63rXPuEtPWeTaGJ5FW3ztJnz7O+lBLNvPLfMQ/x8HR2d4pbaXYmaFcFWA5r1g7Y9T49kRTkjcuCP3y44lPIdk78Ji1+c18yyOlVZP/JxRl8i4EoD7W7LvBtcY+pUkF5RcBmVN4MRhzrvIc4GuA8AoJBMJG0vQ++54C7m2pGLBrNQLKCX72bPhvuFIG3wv7J+mpuUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aexl6TLvJ/4QZ7zfoc/S19jZVCUFyKnSkpg5FHlRV/s=;
 b=oVHGw7gfGT9qYbcXCLFvZdtuxZkchWAmikIkoQuKgDHDVsNiEx9q8t0KH1noSkIiLM9pXXq30c8cYzAdlo0xVxid+6Fgn9uaOhdb8varAr/Mm7T5gS2ePZI0KNiASiDH+tR5lIT2wtxVNIf1y0ruOY6vlnkv0n2Fwq0aj57x4+Q=
Received: from BN6PR17CA0028.namprd17.prod.outlook.com (2603:10b6:405:75::17)
 by DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 20:24:54 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::a4) by BN6PR17CA0028.outlook.office365.com
 (2603:10b6:405:75::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 20:24:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 20:24:53 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 15:24:48 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <markgross@kernel.org>,
        <hdegoede@redhat.com>, <Shyam-sundar.S-k@amd.com>,
        <linux-edac@vger.kernel.org>, <clemens@ladisch.de>,
        <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <mario.limonciello@amd.com>,
        <babu.moger@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 4/6] x86/amd_nb: Enhance SMN access error checking
Date:   Tue, 16 May 2023 15:24:28 -0500
Message-ID: <20230516202430.4157216-5-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516202430.4157216-1-yazen.ghannam@amd.com>
References: <20230516202430.4157216-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT054:EE_|DM4PR12MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 5791c221-8708-44cb-b7ac-08db564b9bd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gX4egV8B8NT36U0Do0L4iR/MYa/EvWw//z64yXqauTHf6i39O5DnQ4jkTq0ukUB0W5p6YAlcpjqTKo99KT/RQXRXOiF8n5lzDVnj4QeMrKvdF97FzdyPsocgFHZqnOxJD4CsBJbLo97aznaKBfq/s1RBrbJ4wPZ6XaFH1iUHn4vxwTvAcQfQbzxxX6N6IiEJYlk+a3SXy7VJSnJNcx4vQWAX87JPjpz0dp1AppF/B7PxZOPA7z5PVbvrV2t/e4jcJx2UXEMT/Ezm2L1TDykTQTPRGRQC0PDofInoSpFOmk8BZpWheIvYXbb/ccxrML/V8XplHY55NVinKGRcmlJa9l9VmyZBGxDfJ6pyTB/0zJkoOm8oMUHnTYHGNeQOj/gGeGTSY1gnqwm7O7TP/c7xSttvU+zuF6A4iqxbBIaDw1tXhptuRuRwmMmCwCstvBPR0JJgbIPDhTGLrXyqfrYrVxztwY9PyuT3/V9X57HFmzJAXWdLHX6f/4zng8wtsUtU+nEjuy9WZKfJ7NjvxBoBT4l1Q15jUJ7N1xGNtU78dzLRG2dYw3L/XuBwSbxPh6pm9YH8+dF4H7RM0PVLDrIFaYd+viqSZRZnrbytQdbhX2zV8hMPIlPbAo/J2sFXq217RLKdzD/jMc8JyUnsnasAbp9XB4M+MKoLWjOHSoKdM+6Din65ZGU1SR39YLpkP/FW/mj8uZ18zJt7dgPv0HlecpiLJZspfzKZaonEQa3Tp/+nyFh06YTEAFh9UezA3AxDEKOsEQ0UbKC5cC8TcqJZmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(5660300002)(8936002)(8676002)(86362001)(44832011)(7416002)(426003)(336012)(2616005)(83380400001)(47076005)(36860700001)(82310400005)(81166007)(82740400003)(1076003)(356005)(26005)(186003)(16526019)(40460700003)(478600001)(7696005)(6666004)(40480700001)(41300700001)(316002)(70206006)(70586007)(54906003)(36756003)(6916009)(4326008)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 20:24:53.9402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5791c221-8708-44cb-b7ac-08db564b9bd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

AMD Zen-based systems use a System Management Network (SMN) that
provides access to implementation-specific registers.

SMN accesses are done indirectly through an index/data pair in PCI
config space. The PCI config access may fail and return an error code.
This would prevent the "read" value from being updated, and it would
give an indication to the caller that the read or write operation failed.

However for reads, the PCI config access may succeed, but the return
value may be invalid. This is in similar fashion to PCI bad reads, i.e.
return all bits set.

Most systems will return 0 for SMN addresses that are not accessible.
This is in line with AMD convention that unavailable registers are
Read-as-Zero/Writes-Ignored.

However, some systems will return a "PCI Error Response" instead. This
value, along with an error code of 0 from the PCI config access, will
confuse callers of the amd_smn_read() function.

Check for this condition and set a proper error code for SMN reads.

Furthermore, require error checking for callers of amd_smn_read() and
amd_smn_write(). This is needed because many error conditions cannot
be checked by these functions.

Also, drop the extern keyword as it's not needed. And remove a warning
that will not be trigger in many cases.

Fixes: ddfe43cdc0da ("x86/amd_nb: Add SMN and Indirect Data Fabric access for AMD Fam17h")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
---
 arch/x86/include/asm/amd_nb.h |  4 +--
 arch/x86/kernel/amd_nb.c      | 46 ++++++++++++++++++++++++++++++-----
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index ed0eaf65c437..e6fe405aa567 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -21,8 +21,8 @@ extern int amd_numa_init(void);
 extern int amd_get_subcaches(int);
 extern int amd_set_subcaches(int, unsigned long);
 
-extern int amd_smn_read(u16 node, u32 address, u32 *value);
-extern int amd_smn_write(u16 node, u32 address, u32 value);
+int __must_check amd_smn_read(u16 node, u32 address, u32 *value);
+int __must_check amd_smn_write(u16 node, u32 address, u32 value);
 
 struct amd_l3_cache {
 	unsigned indices;
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 7e331e8f3692..c37754354cd8 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -157,6 +157,38 @@ static struct pci_dev *next_northbridge(struct pci_dev *dev,
 	return dev;
 }
 
+/*
+ * SMN accesses may fail in ways that are difficult to detect here in the called
+ * functions smn_read() and smn_write(). Therefore, callers of these functions
+ * must do their own checking based on what behavior they expect.
+ *
+ * For SMN reads, the returned SMN value may be zero if the register is
+ * Read-as-Zero . Or it may be a "PCI Error Response", e.g. all 0xFFs. The "PCI
+ * Error Response" can be checked here, and a proper error code can be returned.
+ * But the Read-as-Zero response cannot be verified here. A value of 0 may be
+ * correct in some cases, so callers must check that this correct is for the
+ * register/fields they need.
+ *
+ * For SMN writes, success can be determined through a "write and read back"
+ * procedure. However, this is not robust when done here.
+ *
+ * Possible issues:
+ * 1) Bits that are "Write-1-to-Clear". In this case, the read value should
+ *    *not* match the write value.
+ * 2) Bits that are "Read-as-Zero"/"Writes-Ignored". This information cannot be
+ *    known here.
+ * 3) Bits that are "Reserved / Set to 1". Ditto above.
+ *
+ * Callers of amd_smn_write() should do the "write and read back" check themselves,
+ * if needed.
+ *
+ * For #1, they can see if their target bits got cleared.
+ *
+ * For #2 and #3, they can check if their target bits got set as intended.
+ *
+ * This matches what is done for rdmsr/wrmsr. As long as there's no #GP, then
+ * the operation is considered a success, and the caller does their own checking.
+ */
 static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 {
 	struct pci_dev *root;
@@ -179,9 +211,6 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 
 	err = (write ? pci_write_config_dword(root, 0x64, *value)
 		     : pci_read_config_dword(root, 0x64, value));
-	if (err)
-		pr_warn("Error %s SMN address 0x%x.\n",
-			(write ? "writing to" : "reading from"), address);
 
 out_unlock:
 	mutex_unlock(&smn_mutex);
@@ -190,13 +219,18 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 	return err;
 }
 
-int amd_smn_read(u16 node, u32 address, u32 *value)
+int __must_check amd_smn_read(u16 node, u32 address, u32 *value)
 {
-	return __amd_smn_rw(node, address, value, false);
+	int err = __amd_smn_rw(node, address, value, false);
+
+	if (PCI_POSSIBLE_ERROR(*value))
+		err = -ENODEV;
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(amd_smn_read);
 
-int amd_smn_write(u16 node, u32 address, u32 value)
+int __must_check amd_smn_write(u16 node, u32 address, u32 value)
 {
 	return __amd_smn_rw(node, address, &value, true);
 }
-- 
2.34.1

