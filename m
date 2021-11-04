Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF18445BED
	for <lists+linux-edac@lfdr.de>; Thu,  4 Nov 2021 22:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhKDWBy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 4 Nov 2021 18:01:54 -0400
Received: from mail-co1nam11on2078.outbound.protection.outlook.com ([40.107.220.78]:61057
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232304AbhKDWBx (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 4 Nov 2021 18:01:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OP3Ml3VfE0Ia4dfBQAjypUuxrAHxM6+HoP20RlehZdlP+xLaClDn0MMYlrZqLHMEjpKiLupwRy8HZd62f7U1oXA13Uv7Rrivat/yOhcBh4zpw+0HHZRd6QpK9imi7tVhtmf9wepSmO0tOJ1OjZSEFyEe/RcXm4FAI+w2XphIlE1yP/ZywEvYEQSJgvZGoGaKcENhi8KkRN8rBJhLHZNWONI1VrUHE3ADPTrLXRwemGC2wEzdtcFf6O0iJiHpCQee73ItI2PSnZIDLt2NUjBI1B6KBNlTvL2Rocb3qXHtsVXSukxwwyTSX4DkSEj4RFHtbcAfVpHWErS9YHZSQXjUUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Vmn+s+yOAjQWdDbwFI8ZU56+zjnZr7bs7IObAkevoc=;
 b=N9fyZnGNvAKMzW23M4SZ37IH08+r5/Gmid+42xsmUlM3ImOlXu/X90Eohoi8aejTxcIdRFWrs02KP7RmjHUIKQys3ssfebmO9RedwUosjpirBEsCnNwp+Rn0XHUpmPvqztKMhWKAjw/lUd92dAIu47rVU4DelwAp4qmUpfl6bOhVpWbySn0OhqYoSSmCKmJCQUVE53o60sTptPeAjbS9DJm/AtTCDZRjaycNJPHUeOS6F2TpOVe96o2qa5jZ+E4gLl0nBPQMItryqeuuNfELYNiNG4MV453nQhP2zuDcBc7psCeJR9Jt1T15UW093/O9hojrZ4k3WKnEd2T3++lo3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Vmn+s+yOAjQWdDbwFI8ZU56+zjnZr7bs7IObAkevoc=;
 b=OF0xPHp5uyMH29EcAKFHFavri9oUEvYQvF7Sbpb5Aa83HjoY9sokDXc6coOPnrR668h0muDqWiwMQ8EZufk1ZlfI6rGVBmUGzHjs6bPfCVFZVk1JOM2TeKQysvOR+yvvVxHQsLlbNZI/19k/Rocz+LVEP8efxHgsj3MME8fW+yQ=
Received: from MWHPR11CA0026.namprd11.prod.outlook.com (2603:10b6:300:115::12)
 by MW3PR12MB4378.namprd12.prod.outlook.com (2603:10b6:303:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Thu, 4 Nov
 2021 21:59:12 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::e1) by MWHPR11CA0026.outlook.office365.com
 (2603:10b6:300:115::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 21:59:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 21:59:12 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 16:59:10 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        <yazen.ghannam@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v3 5/6] x86/mce/inject: Restructure prepare_msrs()
Date:   Thu, 4 Nov 2021 16:58:45 -0500
Message-ID: <20211104215846.254012-6-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211104215846.254012-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20211104215846.254012-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef007fec-e16b-4252-fb9e-08d99fde55f3
X-MS-TrafficTypeDiagnostic: MW3PR12MB4378:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4378D732BB946AEA19FBADD1908D9@MW3PR12MB4378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TjVd8ZxDTWCtXeOG6gVOhO7LLqai54lmuyfJH097jb4zNuBYT9GwP/j2FGfbmYjm3WHg5JyWM9D/1rDBh/9I9QtLhKnYWAyftOZySSwxF2DnNQ75H9CO4VO4rUBn9cXD1q4BGHPq+V9bI8nIBxLnh53kIy+SBGpKR2GRtj/1Pw8LnAs9dCLsjWAEiAI9xnT2bpNHQ97B9xO7TRRdQz4kCQ2WEv2agogrPb7uI42VGEC/r0xIenN5IMyMeTUP7h/d99St4ILBs3vzMK+a1mQ+XIh9Vxet5aiDAk9V6p6gm+XM1MBAWQ5DWEmE3l12OvEvYwmnQrwIuClOa4Vu5/k0Wzxs/WafSrcWWq9leU5mshjeovhqPPE032rkNl0LqnuKByAwtigHUNU7PkENVv9mbomPiURE7fwFQPHigSq3w57/vqFLefsOD13gOGdyKNJsgoYi9H460C9Qei0b52MKG4U91br9NPOIjeTaOESMA55Ko9QT+HO4ZWnoI//kZzAjqFpVDhZsEdXnFO7EjiZyp6qoJSdTPq1Yt1zH3waHshQ8ne/Zhxu1412gPXiwVwHS8qVOBwexSr02K5P/ArjLQGwWH5sRv7MHY+81lndPHH5PFgM8vb6uHOLDP84WKWm+WxsYE5Ex1+FtkmRvNaCau6VhvOc4aTppvKdSIzBJBwG1HYhECu+uMOgk+UDCOflT15glZUr5HQrMQYFXCUtXOeyQMaHndoSzYZD75nJB40s=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(8676002)(508600001)(336012)(110136005)(1076003)(4326008)(316002)(83380400001)(16526019)(36860700001)(36756003)(47076005)(186003)(70206006)(81166007)(26005)(8936002)(6666004)(70586007)(82310400003)(5660300002)(356005)(2616005)(2906002)(7696005)(86362001)(426003)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 21:59:12.1326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef007fec-e16b-4252-fb9e-08d99fde55f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4378
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Rearrange the calls and write to registers MCx_{ADDR, MISC, SYND} and
MCG_STATUS so that they are only done if error injection is available.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 arch/x86/kernel/cpu/mce/inject.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 8772d8820994..d4e6d753018f 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -484,23 +484,19 @@ static void prepare_msrs(void *info)
 	u8 b = m.bank;
 
 	u32 status_reg = MSR_IA32_MCx_STATUS(b);
-
-	wrmsrl(MSR_IA32_MCG_STATUS, m.mcgstatus);
+	u32 addr_reg   = MSR_IA32_MCx_ADDR(b);
+	u32 misc_reg   = MSR_IA32_MCx_MISC(b);
 
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
 		if (m.inject_flags == DFR_INT_INJ) {
 			status_reg = MSR_AMD64_SMCA_MCx_DESTAT(b);
-			wrmsrl(MSR_AMD64_SMCA_MCx_DEADDR(b), m.addr);
+			addr_reg   = MSR_AMD64_SMCA_MCx_DEADDR(b);
 		} else {
 			status_reg = MSR_AMD64_SMCA_MCx_STATUS(b);
-			wrmsrl(MSR_AMD64_SMCA_MCx_ADDR(b), m.addr);
+			addr_reg   = MSR_AMD64_SMCA_MCx_ADDR(b);
 		}
 
-		wrmsrl(MSR_AMD64_SMCA_MCx_MISC(b), m.misc);
-		wrmsrl(MSR_AMD64_SMCA_MCx_SYND(b), m.synd);
-	} else {
-		wrmsrl(MSR_IA32_MCx_ADDR(b), m.addr);
-		wrmsrl(MSR_IA32_MCx_MISC(b), m.misc);
+		misc_reg = MSR_AMD64_SMCA_MCx_MISC(b);
 	}
 
 	wrmsrl(status_reg, m.status);
@@ -511,6 +507,13 @@ static void prepare_msrs(void *info)
 		i_mce_err->err = -EINVAL;
 		return;
 	}
+
+	wrmsrl(MSR_IA32_MCG_STATUS, m.mcgstatus);
+	wrmsrl(addr_reg, m.addr);
+	wrmsrl(misc_reg, m.misc);
+
+	if (boot_cpu_has(X86_FEATURE_SMCA))
+		wrmsrl(MSR_AMD64_SMCA_MCx_SYND(b), m.synd);
 }
 
 static void do_inject(void)
-- 
2.17.1

