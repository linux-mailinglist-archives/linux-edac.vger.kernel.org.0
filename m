Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065A26A7541
	for <lists+linux-edac@lfdr.de>; Wed,  1 Mar 2023 21:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCAU0s (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 1 Mar 2023 15:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCAU0r (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 1 Mar 2023 15:26:47 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A51360A2;
        Wed,  1 Mar 2023 12:26:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/RA1t5sJrgTjD8+s4CC6qKxog3AgUP6knhluO5/6Ddynnb27SzwhctDxsfE3EVp+r8mWUOGfVgk/mzvOAJO7vSDsscZ6z+spjxcT1nM79fU3MqoVCDkXdYA9wwPQGR5S5+WNB1L3e8Bo5iqbmrSRkY7RyGSxWNzpB8dEoMCaA8mUGEkGg7GhcDZMpBQIkA9MYov3WcWwBa0bBCZ84w8Jg371oagHWvquS7bTjiTewYqaTyBcz9m4TbIJtykDACVTeb1aDdJZIdxISQJSt0Eb8yNTQHsyX+GyeZELol5BfPc3zHdfoN3G8tCW/P3gZZ3blGCOtz73ro/r+4oESz2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1vkW4kj0AqepSN9e00aaEHydSyzm3pAldaFfd/V4Ro=;
 b=KX69KDSaXvyjn4atYw0sWbXH/eAEm6UOdZiaB8xUOZM7syOaZlZSGs1vHpDlO3SlZuZiI+v6DNHnctUfREeenvPdlVVI4TqkJQpBUr9TlmR0GXCnSZlWrTs12mwJY4kPk+YPbdqG3bz03c2IjhCt1+sL/VfvMMZ51oowWQTrNZ3zPYI+b4SxktbMsZLySEPk9kSz6E7eIQE7SVI6BHRAu8ze3AI0ndNwwOBAdwPN5Q/FUiW+crAtCLkX9g6VkXrvGkPJP6EXDS5/EQjt6gI8+GlV3XUh1PeXV/sCRcOGBg91m+/5HkvAUzRxoEJnoOzT4M4JhCcgkjK4TQIRwGz/7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1vkW4kj0AqepSN9e00aaEHydSyzm3pAldaFfd/V4Ro=;
 b=U5/PEkQDHWoyEOIt5GMrYPUu0XZbTEoJLu3tpZvy0ZmA/IPTHypo9/ScYFYDKdgkgalhPRqbeT/mm5HMnk984RrAbYP4lUE+v/kxxYQrwDdbco2Y9Zyi3Dlv13VNUG9/Z7kwuhhyfO1a6FaDtylvyyTp4d/uqYE5uV+DfJzrX6Y=
Received: from DS7PR03CA0123.namprd03.prod.outlook.com (2603:10b6:5:3b4::8) by
 MW3PR12MB4587.namprd12.prod.outlook.com (2603:10b6:303:5d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.18; Wed, 1 Mar 2023 20:26:40 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::6b) by DS7PR03CA0123.outlook.office365.com
 (2603:10b6:5:3b4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30 via Frontend
 Transport; Wed, 1 Mar 2023 20:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.18 via Frontend Transport; Wed, 1 Mar 2023 20:26:39 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 14:26:38 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH] x86/mce: Schedule work after restart from sysfs update
Date:   Wed, 1 Mar 2023 20:26:23 +0000
Message-ID: <20230301202623.2092271-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|MW3PR12MB4587:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da5e38c-d71b-42e7-6daf-08db1a934370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYBpuHgDwTLavpTLdJZCIdG5yhxpYKlpcAhefxo2oi11RFrhjH6PbGLOKrVVrVR4nrWM+ueJpkv+aBWf9NAaDw2PKw3fCBMLySMEQIORcIz9qYGoVwsB35GNaCJEcfTqCPoQYQdhL+8PXKDGPwiJU+HzTMtYEcuw9H4zeBR9Ayc120XfR41AHDVoRlDEaCjeAIux53GvgQuR51mSbF8h3NDCf36ZQ7yI19wF4KHt3VHOw434SKlwdjDhwpNDtAG0ghKUjYpwUXrdKLfFx1OO65/gcKwnx7ADrz4Lt+zEA/M+nlh9h5Gmdq86zqbJDnNmDmw4BKyIFXV5Wk3tQRTxNWoeLcwNS8GHZsljP5DB2uDC2dKluBFu59tvGeQCDnexdg5aXTMHPsMCl58ojnF59RZBMYuFpvhtYprsAldDrC41iLj2xGXrr+4ySrc+tdNgV1gdrA2AF4UzubRarUvE00iB7UlPm8Z1lp+taDOvpFSiOQ9IofOYJ87a+NolgM+LmuVc5445xHTWOov5BroPFFaOYvsprwbk6rzl8W5YZZGsEMU5Rc8f7xB9jlO9/+TW/rCbgFBQ/XGGWdi/ANqaBtdV6qOeKQh3eC7O/MLRn634PSzAmrKbsegbythnkwyVjC7VofhYAFrrJTL+6xaJ1AFzR0hgQoyKKnx5cF71lmJ02AfYABP5oMt0u2l11e6+bhutNobARvIEu3fqA3jG0iCcbhK0YFL6c+IpIA+jE38=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199018)(36840700001)(46966006)(40470700004)(82310400005)(83380400001)(478600001)(336012)(47076005)(54906003)(316002)(36756003)(426003)(82740400003)(4326008)(81166007)(36860700001)(8676002)(6916009)(40460700003)(2616005)(1076003)(186003)(26005)(6666004)(16526019)(7696005)(70206006)(70586007)(5660300002)(40480700001)(15650500001)(44832011)(86362001)(8936002)(2906002)(41300700001)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 20:26:39.6232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da5e38c-d71b-42e7-6daf-08db1a934370
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4587
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

A recent change introduced a flag to queue up errors found during
boot-time polling. These errors will be processed during late init once
the MCE subsystem is fully set up.

A number of sysfs updates call mce_cpu_restart() which goes through a
subset of the CPU init flow. This includes polling MCA banks and logging
any errors found. Since the same function is used as boot-time polling,
errors will be queued. However, the system is now past late init, so the
errors will remain queued until another error is found and the workqueue
is triggered.

Call mce_schedule_work() at the end of mce_cpu_restart() so that queued
errors are processed.

Fixes: 3bff147b187d ("x86/mce: Defer processing of early errors")
Cc: stable@vger.kernel.org
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7832a69d170e..2eec60f50057 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2355,6 +2355,7 @@ static void mce_restart(void)
 {
 	mce_timer_delete_all();
 	on_each_cpu(mce_cpu_restart, NULL, 1);
+	mce_schedule_work();
 }
 
 /* Toggle features for corrected errors */
-- 
2.34.1

