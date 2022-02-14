Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7974B5E55
	for <lists+linux-edac@lfdr.de>; Tue, 15 Feb 2022 00:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiBNXhO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Feb 2022 18:37:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiBNXhL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 14 Feb 2022 18:37:11 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F219D114762;
        Mon, 14 Feb 2022 15:37:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/ZEDF5iMeM24ggNRAHWQSp1z2VjiQwhXUbhHYkr7lPFtn1ovhrBnk8GuwOxJtDBf4gkZ0RhJMfFy7+ROFhnQk46AUyRAtXTpSde6/PvEoQbavlrITHCY40UGOb09rOKOplmhO7InmS8+EJ1VUTBp2N1ko6b9ZEkxnUA//sm2zwD2e05l1H7dJyfy3YAC5LaQakh8y5CuCZ5HGf5iJvb2SU3/yN66T/GBp5UhnYE7Ds4cUz3IEL0oVuKUN5ZNuUndZ3ZQcgeRdv8QCDyWPz+T4pmTGqFZG6qsvVuplyTwAUsA/pzN7/WiFCU8n53RQgPeUI3ZWaBnZPNIZ8obLXJAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWDHjpqlIoHTcfZofOE61pV1GoOi7JgMuu/Inw3NFkg=;
 b=YgODI8gWFrTMfb8bYl/NDRgnze6XWUbBgJaF2Ca6YTuEQqyhUbNoFY1sEbmudoRlLqfquX8z/bS92CTToQeWmFE9cudhj0RVxvLyiMAmhnzQhkfhBpABFlbARpGZ87ud8REWHCVs2VU7z2lM58IuQJouhI5psnA5SlZILGKmxKH2eR+di0V5V6YOAIlZ80zSWn2XoTT8gJ1dxsT+PsiGEwv2AeJWou/FdSvvIx86FglTknIn3ZeRGHNNznbYk7bWbESJguNpUEfx3Al51iSjhHYve33EGPSTheiNX5mmw5NmJj9HbET0akV3FsM2qfyMU6muTvlXaiQF02utuQ0aHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWDHjpqlIoHTcfZofOE61pV1GoOi7JgMuu/Inw3NFkg=;
 b=S8nJElZFoyNI3n+LXSLJ3W15zZUrg3YYA2G3NG9Itg+0VcKAmKhZNVdzWoOLSwZMPUsEZoxue/yljbz+K5HIOZlVBVej0U0/KnS50nZ7KQBClMyv/CcJ+XBJZuucJwGfDLacSm0OojTQ0pSnhBsu63iFw4xLnFmLv5z+C5aWHsY=
Received: from MW4PR04CA0161.namprd04.prod.outlook.com (2603:10b6:303:85::16)
 by DM5PR12MB1356.namprd12.prod.outlook.com (2603:10b6:3:74::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 23:36:57 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::cf) by MW4PR04CA0161.outlook.office365.com
 (2603:10b6:303:85::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.16 via Frontend
 Transport; Mon, 14 Feb 2022 23:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 23:36:56 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 14 Feb
 2022 17:36:55 -0600
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v4 2/2] x86/mce/mce-inject: Return appropriate error code if CPUs are offline
Date:   Mon, 14 Feb 2022 17:36:40 -0600
Message-ID: <20220214233640.70510-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220214233640.70510-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20220214233640.70510-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 097a0b91-be80-4b5f-8619-08d9f012e3b2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1356:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1356AACACC4ABF6ADFE56EFC90339@DM5PR12MB1356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0jso8sz1vHhpAx39LC1/3n1qZWSN3ilkmliAhpEr4igEsENA5PCCo2YySaIsTTkbAVqVAV48lMUxJG3JDmCNcs+xgLFM9Sx3GGjKV6eqvs6KRUI4ypP8eSpGmI1kXh0c/vsCasKbzI1H2KiCJPfa/ZTcQUqp9POI7Qq7MKJeX/oIMvw+2VXZeXGN3V7MjYTnOm0Kv/Ip0d+GfHSjciyc/rqc5wogIkUZncTnu9DriqXbCRwgiTNCfdAAgf3BGwnRarFjsPYXjfDMmHn2Fg8VFkW1Muh/GFFTmv4rIq/kE+O4EumG3Wb39JD7OqosWexH13HzZrrmY5Nx1Otk9k1vXyhtZDbUyb8u4VdSso4AAiPTFg6a+PtvLNrMbY2ldYyKtOceoB72tBzktY4sG1F3wIlXDDwMsOB91efDYlRENcZ5sNTTOxWHdG87CDczneClaZF4VDrRveO1ZqtoSVhnPNo68PSG4y8ufAq7VBbnb3BalGJstGQA19khgdjSiTKzqBR+Ps3AXbs3Ng0dk82+LOh/gkdXs3YPgnscTYSvfv4s+73Zr0HugYda9ddpDZ44BMTIyc/2SqDXU0T6maNElPAFB6lSk9IEuGSTWNEXXbXlnZnfWx3iKDgUEom3mIyAX8FUU1i4wREicdnr4ul/X2p1rYAA8xE9zS6xlQ7szc1DOcPMd3I+3Eus3A9bLZoKVDQNUHO9pWrVSpj34hLPQ0iPxwg42fG4unRnMCzo9P3kzNT2uXzqdMllAbhcLs4Uzp+C2OltSMoHdHMnAQU0yrZ/WJotmjNtOQDN37YcHS0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(4326008)(47076005)(2906002)(356005)(82310400004)(36860700001)(40460700003)(110136005)(316002)(70586007)(8676002)(81166007)(70206006)(54906003)(83380400001)(6666004)(8936002)(86362001)(2616005)(426003)(5660300002)(336012)(26005)(186003)(966005)(7696005)(36756003)(16526019)(508600001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 23:36:56.8435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 097a0b91-be80-4b5f-8619-08d9f012e3b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1356
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Assign appropriate error code when no CPUs are available online.

Return this error code with appropriate message to user when injection
fails.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20211019233641.140275-6-Smita.KoralahalliChannabasappa@amd.com

v2:
	Added pr_err() along with error code.
v3:
	Rephrased the statement: No online CPUs available for error
	injection -> Chosen CPU is not online.
v4:
	Prefixed "mce-inject" so the user knows that the message is
	coming from this module.
	Printed CPU number along with the error message.
---
 arch/x86/kernel/cpu/mce/inject.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 43ba63b7dc73..b293db2788d4 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -573,8 +573,11 @@ static void do_inject(void)
 	}
 
 	cpus_read_lock();
-	if (!cpu_online(cpu))
+	if (!cpu_online(cpu)) {
+		pr_err("mce-inject: Chosen CPU %d is not online\n", cpu);
+		mce_err.err = -ENODEV;
 		goto err;
+	}
 
 	toggle_hw_mce_inject(cpu, true);
 
-- 
2.17.1

