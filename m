Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15724EDEDD
	for <lists+linux-edac@lfdr.de>; Thu, 31 Mar 2022 18:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbiCaQfW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 31 Mar 2022 12:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240006AbiCaQfV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 31 Mar 2022 12:35:21 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E57910E578;
        Thu, 31 Mar 2022 09:33:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDOD+kKyyTETxHBNZM+2X+4CKOLi0HbG4BCxoDci4bHb/C6o4GL1Hi29lrbLkEGn6udljMntsSJZooWSXknYNwmJDDTik/4J+iNELCDCDmHvAzuD9iYy8pPCtGEVkH4GG4THiSnvdvVLEZOlnXcloWSX8cawmaqX3lPg9EGJASr2lL01ZRH2kvKGYgt4+IfF1Rz9UahZWelneEAfNCsTfaeTcB2mbn8daMy0ZOsnC98J6jDWv9Njx0yRwmMIA7IeGuxm4MuIKUOAmyjGORT+gdoaEGOXIcRu3U5bjhs47ga76BUxfIosHrY7TiHJ6MUQV5erOKpCTUnlJVjdDynuGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpsQ3P7GLY5eeC0LjnMTlMF06VsykEnUUDgRshVxjqM=;
 b=AW7kmyxBE4IJ3ob3sDW4o5WHSQe+gBH06CGbz6x9OZhyXzvUs2+yABFgbGNgqbyefruFe0lRiF/pUgBNv6B2r3oPR+xj52uXwsHJm6EnDXACXnbf+Xwpo4KnhcP627h2egRJQYY0/MCTZJ6Rlod2T2mDJhiO33kJ1uWNlwXsRDM8qL2iEYrhR6K1DF481EibtBt3I2CGJFNkdAQj4o3gYtX0PRH1lDeqOgUsKiGVioYT870EMEJm4st5sz9QHarNeO3noMPruucRDipOJPAAC57xvyQwja46JtTUC8wEdoIuCfRN2D1hcs/tTHhVFP/QzCdMWIZT3QeXRrjOBR8ELg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpsQ3P7GLY5eeC0LjnMTlMF06VsykEnUUDgRshVxjqM=;
 b=d+xAGa1kh4CfE3pP4300+EE3lbhYS5gOLIVmuGbAytrRpLF6klGnI3+30X5/vrc+bW7L8JHKGWbVc34cGtyJJcQygQTBZzejCaF/6FKsrATy96l7wxX5XXfk7+3YGlrEDFNNrExIvtAM9lxBvERboCuJNen2vsrxS5LMuVjfG6U=
Received: from DM6PR02CA0048.namprd02.prod.outlook.com (2603:10b6:5:177::25)
 by BN9PR12MB5242.namprd12.prod.outlook.com (2603:10b6:408:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Thu, 31 Mar
 2022 16:33:31 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::48) by DM6PR02CA0048.outlook.office365.com
 (2603:10b6:5:177::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.22 via Frontend
 Transport; Thu, 31 Mar 2022 16:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Thu, 31 Mar 2022 16:33:29 +0000
Received: from ethanolx1ade-milan-genesis.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 31 Mar 2022 11:33:28 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <bp@alien8.de>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <bilbao@vt.edu>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v2 2/2] x86/mce: Add messages to describe panic machine errors on AMD's MCEs grading
Date:   Thu, 31 Mar 2022 11:32:14 -0500
Message-ID: <20220331163211.5994-3-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220331163211.5994-1-carlos.bilbao@amd.com>
References: <20220331163211.5994-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 019abf82-1993-4480-4fe1-08da1334307a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5242:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB52427BCCD903475931FF1968F8E19@BN9PR12MB5242.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GZGN8d7NlhXVpu+4ydAGiAnwssEGClJ2RVubavpP8ROEp5JkzkuH0NmyVunh8EyIzNxWvMvCdu7plx3FBbqmS82Rozf52nG5kk9qrkzQvz5Ujvv8uy9NRhNpu4KtAM+5PygrHEcNgadFVGLyxIAdhhzOd3k+GsWL48LsDlZjtwtfaMplEv2/9N9jyZZy/dwHFwcclBdYbbiDmppN6wgeMVFg0rPBaSlEsp/wcpp0W6Zc/ES55P7A6ZtWnude4jr3a9oQVeAfttidQcQtqboS0Sd5VgRZ39Sh+hi7jvFcErSY7uEQcvuvXQUIrXNHOaGtAe8aIdV1ZMp4ZXWMtq+0Fik+iLpZwRaHvEbtUdRSY8XT2gkBg/WT3gzNJdnsWeTG4VEn4lxCIxMWB1pobAK4x9hESouZH7SuZYAmD70KJS3RpzsvF4xtfhNUe1z68FfBmA+bib888siVIwZ0NbZtgBRI4GijoFzbukkm7NgUcYeWF29vPEr6y1Nmg+nuva64exnXRFdJdxC8oyDuXp2Ft2+DhznVO9G7Sjb87QNxq2dkTbE+ORGWVFBC74lui5cJLIFR+zH3RVNgvH8k1eYi9G9otBleBnNisIvhnDiSIrW8GtaEb+zrvCVRr9GFJ6FvlNqOXjGtqgLnABUT53q2jTABnfaz6TE6S1ElhWWAi8RgxvlAGeb7rJFFlnb4EomOTnurmQ0VBDaDYK+jjP3Yaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(356005)(54906003)(316002)(86362001)(7696005)(2616005)(81166007)(6666004)(6916009)(26005)(36756003)(336012)(426003)(83380400001)(1076003)(47076005)(2906002)(186003)(36860700001)(16526019)(15650500001)(5660300002)(508600001)(70206006)(70586007)(4326008)(44832011)(8676002)(82310400004)(40460700003)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 16:33:29.7958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 019abf82-1993-4480-4fe1-08da1334307a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5242
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

When a machine error is graded as PANIC by AMD grading logic, the MCE
handler calls mce_panic(). The notification chain does not come into effect
so the AMD EDAC driver does not decode the errors. In these cases, the
messages displayed to the user are more cryptic and miss information
that might be relevant, like the context in which the error took place.

Fix the above issue including messages on AMD's grading logic for machine
errors graded as PANIC.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 arch/x86/kernel/cpu/mce/severity.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 4d52eef21230..ea4b9407bbad 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -307,6 +307,7 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
 {
 	int ret;
+	char *panic_msg;
 
 	/*
 	 * Default return value: Action required, the error must be handled
@@ -316,6 +317,7 @@ static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **
 
 	/* Processor Context Corrupt, no need to fumble too much, die! */
 	if (m->status & MCI_STATUS_PCC) {
+		panic_msg = "Processor Context Corrupt";
 		ret = MCE_PANIC_SEVERITY;
 		goto amd_severity;
 	}
@@ -339,16 +341,21 @@ static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **
 
 	if (((m->status & MCI_STATUS_OVER) && !mce_flags.overflow_recov)
 	     || !mce_flags.succor) {
+		panic_msg = "Uncorrected unrecoverable error";
 		ret = MCE_PANIC_SEVERITY;
 		goto amd_severity;
 	}
 
 	if (error_context(m, regs) == IN_KERNEL) {
+		panic_msg = "Uncorrected error in kernel context";
 		ret = MCE_PANIC_SEVERITY;
 	}
 
 amd_severity:
 
+	if (msg && panic_msg)
+		*msg = panic_msg;
+
 	return ret;
 }
 
-- 
2.31.1

