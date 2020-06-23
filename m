Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962D42052F4
	for <lists+linux-edac@lfdr.de>; Tue, 23 Jun 2020 15:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbgFWNBU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Jun 2020 09:01:20 -0400
Received: from mail-mw2nam12on2044.outbound.protection.outlook.com ([40.107.244.44]:6117
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729504AbgFWNBU (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 23 Jun 2020 09:01:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtfBjoFc7VDJtmtS3wctK7rXS0QPeOCRYyS6kitelh0C1EmLcr6NMMt60eIhE8FUbmI54p7UQov1R4euIzMu8EfGP0uJ42hSfh3aaNskCsweVzY+3JVkAtXQaLdxxTKrBR6ZCpBjVTEzksnUvfwXEqUr/S2AvS0oGaOitvD1+Mqm+1vLmzmgeHTCPpoSVxLtqurZd2TkWUCm48ckUchqFJxt3yofD+sezt/xmEbYyw0Wv/exlfng/6vpJ4HJjS3wkE264HGZ4D9MIbZAgwsm9/w0bZIo0qOYJUaWgEKSR8Q6LF9U09hCH+V0GZtkB3VUZMG7eVgTlHSqe2emwIsOYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzJL7hxvodkNwKTbGI3eQhM3hzchSpznYsMqyGRUXiM=;
 b=SsAvgz6SQTXTbcBox4WA1NNFCvmm9jhz7U6yCUcrEO0VEcy1W/EEHWShbw+EXW6VCe2OqHwqT8OjQFOVT74vhoO4O4sqHPJScY6+zucY8bEy/kLBHYRXlQveWYo7P9czeLpkqGGH+uV+Tkzgq2ruVh+9RqhCV2wFyC1hIiizXzIFs5kFHeo4NEas1tc6UCZDtjDAKGuXQwfEy05MgFoAnuehVVlwUr8Ah/ltxYNqYDjZYhn6w6qLCALsj8WuB0tR25hpunKEnBfsN0WW//lvatiGphVrTnz+/p4/tEe4sWNRsLyvt7ERBtbHCgS0sxB6fxkoktEIVvmFjifQahCNHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzJL7hxvodkNwKTbGI3eQhM3hzchSpznYsMqyGRUXiM=;
 b=31GeagmPSbuKooBSbMX5dUaTSTMlupC+hjpaj7PeYPUJx1+zdo2FGTkbN0ZspYx4AESM3q48GfgzTR1/3xgT44AlmZ1sVeAr4hGP0f2PvAI0NTUHXHX0yAMFb9pEwBRNdktPJ54bk6Wafn8F8G2RNGuZIQTK740wyrTAWscFFwI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SN1PR12MB2541.namprd12.prod.outlook.com (2603:10b6:802:24::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 13:01:15 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::7864:3a08:ffa8:9123]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::7864:3a08:ffa8:9123%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 13:01:15 +0000
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     Smita.KoralahalliChannabasappa@amd.com, Yazen.Ghannam@amd.com
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Wei Huang <wei.huang2@amd.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mce, edac/mce_amd: Print PPIN in machine check records
Date:   Tue, 23 Jun 2020 08:00:59 -0500
Message-Id: <20200623130059.8870-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: DM6PR11CA0060.namprd11.prod.outlook.com
 (2603:10b6:5:14c::37) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx024ehost.amd.com (165.204.78.1) by DM6PR11CA0060.namprd11.prod.outlook.com (2603:10b6:5:14c::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Tue, 23 Jun 2020 13:01:14 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9f514c41-8bc4-40da-45b2-08d81775835e
X-MS-TrafficTypeDiagnostic: SN1PR12MB2541:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB254165AED80F7CE47C32504690940@SN1PR12MB2541.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uUXrzEBu4C1wbdTnanCr7cauRINXFMOgZQeecGR9fw0X6lPxQYAZW/pBizRF+8Y/69VicsvboNfxC5VNlVEAPnEVcuHg9Gdsp3UabIjWS+/Zlyhi3H+lewi/WwziGs9n7tuUwjTzG3HDInDuPLEjOiHUHUBcwzLtJZ0i6MyU46gZqLbrQZNpV31E7p6/5ozjhDiXgLU6t+qCPOqzKf2gjgxfrx38eSv/aFCC+xAMxQMSej6U0JGXAP/nnuwK1HfD3EW5fo+NJI+WmPUl9jAvgvm6So+a5iXaAtbyPGwkTN/y7ZQ9AUNygygI+p5IFrrz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(956004)(2616005)(36756003)(478600001)(1076003)(6636002)(86362001)(8676002)(83380400001)(8936002)(7416002)(6486002)(26005)(2906002)(16526019)(5660300002)(6666004)(66946007)(66476007)(7696005)(66556008)(54906003)(4326008)(316002)(186003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: FDxhsRId7Ihr7i/Jt9D36jhsz1MDP38bwCNod+If8J82DFr5sGuRKyYUDEqtIVwScTWmHmwK+gNf2OXXvnxRLzSKVy0XHU1yd3C1dyHgFIqPfbCcBnLqMtci54jXWVqTfJ3+5p3xkZT5BlDnvk+cndTQKk1BgxoXmzooN6P5e3rwsC/l//RYMh2ZLDrDcD4ndDnvAyGXLlhqxzGsqaDqVaY5wiBLSqChe1VBpPREy+VSN5Gj2SFKLDsD70PLlDSN0x5SmFCNQn3YhumxKoDL5JRBKaylm8BuelMzBxZ8lIMer/TsyK0tTAxymA3HVLdmOez08NvyPClY3WlcajZQPkrCQntZ60ZF8d6sTXJsrCiwC0ZPOaCNJbo3fvenxWr0Cs2zr84sX3Cl3CEV12eOdjQ8Qfb8Y596eYta5WeZJt0mnd4/r2bANbB1Bg2P4c1T88W1lfcDMmndYgMMSCm/inwehNgP9obcIsbo71dPgmw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f514c41-8bc4-40da-45b2-08d81775835e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 13:01:15.7657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g93lPBm7CZK11OT7k91twfHcuuytab2PDj6EYkSadTpz1mhZFELLkc9QdmDpMuE/2+mm2Sv1atZMUhD0NO/vqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2541
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

For AMD processors that support Protected Processor Identification
Number (PPIN), the PPIN information is included in machine check records.
If present, print it along with other decoded MCA information.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Robert Richter <rrichter@marvell.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Wei Huang <wei.huang2@amd.com>
Cc: x86@kernel.org
Cc: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/cpu/mce/core.c | 2 ++
 drivers/edac/mce_amd.c         | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index ce9120c4f740..0865349502d5 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -244,6 +244,8 @@ static void __print_mce(struct mce *m)
 		pr_cont("ADDR %llx ", m->addr);
 	if (m->misc)
 		pr_cont("MISC %llx ", m->misc);
+	if (m->ppin)
+		pr_cont("PPIN %llx ", m->ppin);
 
 	if (mce_flags.smca) {
 		if (m->synd)
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 2b5401db56ad..325aedf46ff2 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1094,6 +1094,9 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	if (m->status & MCI_STATUS_ADDRV)
 		pr_emerg(HW_ERR "Error Addr: 0x%016llx\n", m->addr);
 
+	if (m->ppin)
+		pr_emerg(HW_ERR "PPIN: 0x%016llx\n", m->ppin);
+
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
 		pr_emerg(HW_ERR "IPID: 0x%016llx", m->ipid);
 
-- 
2.17.1

