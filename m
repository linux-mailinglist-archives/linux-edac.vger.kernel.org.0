Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08778731D55
	for <lists+linux-edac@lfdr.de>; Thu, 15 Jun 2023 18:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbjFOQDv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 15 Jun 2023 12:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbjFOQDt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 15 Jun 2023 12:03:49 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23638273E;
        Thu, 15 Jun 2023 09:03:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQiQEBVVmC5qcLRWc4EBv7lo6Vb37CRuh4SLBiweNqQxxrkNdO4Qugm8ZSqlseaIwDn5KmCZyrYkJdCkmITPnZAoIEd5KEV/NTlsb8ov+2lGTDFbiFIpn1msJYSIOigEyyxVWmxW72tMS6GGFEsJvzLaqCnDK3AnlCMrDfmpjy7k/nqE6tnYxNmafUDx9AltUpf4GjBy7JI+tJDozfU41345GFB4vt1HDDsq5Bx4w0KidC3k82Vn7gDwsoNioAUtK9LHy2qq1aFQUeTDKemoLWR/zCmuC7FguG0mxRVr0KBME4Z4cpuV9x0Nsukqp/1TkvAwHEf5ljeTETiLyF/DXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtJwBKizAGp9kKoGXBrxKv24NxCNB76IKoZe2sOvSII=;
 b=h/g3Ld2B9ZN5Hk5lgZhe7t7a7yyTP7TS6Wu3hXK/T2wyM4rqrwI7WsGsJStQZS3USCeq53bMvX0eCf7X/MCSRURSKOGvYaX2TWRFKINurjIyA3lpZJPuFuGdDUrg/8EehAf28wYSVb0dQMaWGHlOb/SFNE5ZUOcgqhp9Xed8MSCxgOFb+fNz5L+99RmrEKi+yBGtyi8rrTxB6Tq6PKebuUsmKvBt0kNEDqVNhZpCPbqy27HzFUBosr0/U6BUWdmGf9kbsvS9DP8W/4ytz9YVNRnkMHIr9dbK0nj52oRixlTBhpwgxp/L+C65PiO9zqJ1hwJn5ueREJ2RnILbQZMaDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtJwBKizAGp9kKoGXBrxKv24NxCNB76IKoZe2sOvSII=;
 b=2kebBYgGvs9IYW/QfCUCEHXnp5QUg7G4jm3NOEV87XPCvfCOTYKD4RcfW9KTGdq1zLXHz9Hg9lxXD/pvEtNslT4curoHW+AfDN/WoOdypQWZT91kQycYJc68YlF7TUPemBy+R1Imio63rcrxzkFwzbWD2C99ZCePqy8piiunPv8=
Received: from MW4PR03CA0257.namprd03.prod.outlook.com (2603:10b6:303:b4::22)
 by PH0PR12MB5468.namprd12.prod.outlook.com (2603:10b6:510:ea::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 16:03:45 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::fa) by MW4PR03CA0257.outlook.office365.com
 (2603:10b6:303:b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27 via Frontend
 Transport; Thu, 15 Jun 2023 16:03:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Thu, 15 Jun 2023 16:03:45 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 11:03:44 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <markgross@kernel.org>,
        <hdegoede@redhat.com>, <Shyam-sundar.S-k@amd.com>,
        <linux-edac@vger.kernel.org>, <clemens@ladisch.de>,
        <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <mario.limonciello@amd.com>,
        <babu.moger@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 4/6] x86/amd_nb: Enhance SMN access error checking
Date:   Thu, 15 Jun 2023 11:03:26 -0500
Message-ID: <20230615160328.419610-5-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230615160328.419610-1-yazen.ghannam@amd.com>
References: <20230615160328.419610-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|PH0PR12MB5468:EE_
X-MS-Office365-Filtering-Correlation-Id: 713b32c8-d8eb-4953-fccb-08db6dba18fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BfRbm1fwZ1UO996pszlvpmGUyFis1+N4dVI7Kf7DnU1PJZgcZsubX4SouNcsgsDxslchoD/0gqF981z7bavyIt4XI8cOVu8SiyFT3KpRAQ5CZm9csDvXKJ2aO0neTKLNSB2HmAKK7w5wDuLKPuBUkWUOJrhXAncQhIamHv7etbV4jU2dk+dUAt8Xow7jv6azD0U/J2Q3tLXEPJjY7CMYQFETgsjpmHsuyqWcixY4Kpn/2CrNjHafm2QE1tnBDNIDQZKRA9A5kvTMKJ57sJJIP5RUjIcmUAhk0mDBQ74cyQ+C3Pc7BtIOif+mT9zeebIoVJMH4qwojRntKyxJgG3PzT6/0yD615JVpEA16jqxfm2AZ4ApsE5/LJ2VrZ+B4kl6z3f1Lel9/ct6Igcnex96Fj5rYp2EF/kxWLLRN5VLsknClxlqAA+dhVfzgHcCVK0LTgnPyo4lBHJAsNWNqEDMU6yOELScHNPbswStbA5VIh5LU+Rjg2ZflnNn/q/xLLV3cAzEeK8PuVaLsA5NNEivR5J5jw+QapDndL9DEq8tImhcGFGWPARz/WF5iA9SsscynlA2oNXtj3uM6fBoFaAXy5f/SrJVlx+wg+9T1EYaJbuPmqZ5bBzeq1A4nLop598vrDh2BLjs7EnB0PS/Sw/feFSRjG/SFX4nfKUmxNOT2nz9N0JnGmr1etDLzGsRh/zagjemHMCmiJghhhGwZouYMYAE+nGk/CEHxI8yKbYtQwrzXM7FgTZYdQFwuFHewM2aTMvY0oZYfzl1B2w0ACj+BA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(5660300002)(82740400003)(966005)(81166007)(356005)(336012)(2616005)(83380400001)(426003)(1076003)(186003)(16526019)(2906002)(26005)(36860700001)(7416002)(47076005)(44832011)(478600001)(40480700001)(6916009)(70206006)(316002)(6666004)(8936002)(8676002)(41300700001)(7696005)(86362001)(82310400005)(70586007)(36756003)(4326008)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 16:03:45.2006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 713b32c8-d8eb-4953-fccb-08db6dba18fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5468
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
Link:
https://lore.kernel.org/r/20230516202430.4157216-5-yazen.ghannam@amd.com

v1->v2:
* No changes.

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
index 035a3db5330b..60bebf6d4a37 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -163,6 +163,38 @@ static struct pci_dev *next_northbridge(struct pci_dev *dev,
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
@@ -185,9 +217,6 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 
 	err = (write ? pci_write_config_dword(root, 0x64, *value)
 		     : pci_read_config_dword(root, 0x64, value));
-	if (err)
-		pr_warn("Error %s SMN address 0x%x.\n",
-			(write ? "writing to" : "reading from"), address);
 
 out_unlock:
 	mutex_unlock(&smn_mutex);
@@ -196,13 +225,18 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
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

