Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E10D67EC06
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jan 2023 18:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbjA0RGF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Jan 2023 12:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbjA0RFn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Jan 2023 12:05:43 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20605.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::605])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91314FCE8;
        Fri, 27 Jan 2023 09:05:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URkDvZ2NO2v7ZrOAu2DxV8wCJOnH46rsDz8lSz5NZiN53nJ6EizuJLsQCHhx23xkgsYCkJ0drWZ3XFLXcm+5LYEgjOsWV+NdLtVCT846l05oWt6WkMGBInjJpy0vIwzsXWLFQpa4RKSyN5NRZYHILoT/TjptntPfpydwqKwcDbtdVsdnAlsV3Lo+2xwYApfyIqGq0IOHljFd7auPxLXNpwjVkNU/8m2UVCfu6mvzEKCqu+MEcZ6aXo199dBOCwcEE257y8oYzAkg0tURe1RwCgH3THws7o8+lvOdrKqqVP5lOx0zwFGuVGPUhGqA4peUwb1iOmxoXf0ErW9NwX582A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odn/2RXcMR6jw4C3k6Vwm4w2vPADguM1/yBj1IXt2Ig=;
 b=A6dfjGWG5VOuth9237XEEBJ/lXmQjSvcxaCPn7fX8ozjp0ophNEC+Pawcw7h01HzT6BbrWxT4oZ5ql8dm7VxzoXLoPHTWaUBkG/lv7Oh0LYBMqZk+PElSFnxjrDx9Mn2u7m5A0H1Ir0hueCu7ICFwXMzy/OtIlh5dXTlZusL9GzOC0bCj6mM6rbrNZ0VQv5paEkFSkfBDFSE5nigm3Z/vUCxfRxUYVcNlixEOgAfvSX8wEcOqX31bAolYaJ5vLayXUK3+VjALutTTgdXe7SVt2PFzMEZxYP4bO6aS0m9MazatyN0IRQHrAEJvX63l5Aon06buUfu61LLiCKjmaw8zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odn/2RXcMR6jw4C3k6Vwm4w2vPADguM1/yBj1IXt2Ig=;
 b=b6FduLNPYDNxiUsC6oAG51W6w9YXeRuN07oOiwcDGt6oJsmEn+IJz0hW6Z0dG+jhix2VDt24qMyuSuvTNiw3ThsT+7ih5jsMvaILHQo875QU/iOvqEGEHfkWGWCxVi8UKDL35bRh8ifnpzkAzeycJ2hzllPXetsobdtyAZ21r0I=
Received: from BN8PR04CA0057.namprd04.prod.outlook.com (2603:10b6:408:d4::31)
 by CY8PR12MB7707.namprd12.prod.outlook.com (2603:10b6:930:86::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 17:04:37 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::99) by BN8PR04CA0057.outlook.office365.com
 (2603:10b6:408:d4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25 via Frontend
 Transport; Fri, 27 Jan 2023 17:04:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Fri, 27 Jan 2023 17:04:37 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 11:04:37 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 18/22] EDAC/amd64: Rename f17h_determine_edac_ctl_cap()
Date:   Fri, 27 Jan 2023 17:04:15 +0000
Message-ID: <20230127170419.1824692-19-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127170419.1824692-1-yazen.ghannam@amd.com>
References: <20230127170419.1824692-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|CY8PR12MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: 043998a6-466f-4af2-406c-08db00889281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnJI/g7pA1OuqBjQQrOGuG55B16w6v/pZrxpqQAlOunTI1H3GgAcpoFp1rYEoUfagQD4imxeoeHSD2ZNByLUuVJzOnrGAh2OPUrAx5Q91zwutY4YkjawHoxox40KHeYxQoc32+Xhp4rINwTyUcQbeLq3HpwZ9D2XF/c2KTYec1tGiYXnwbrFz6NVA2Q+evsB5SeCC8gpV9Z/cVslxsmqScet3zK65PhlIicHyk4KV/OZ4T58wEXwHqr7lvlGuTTIT4SflBFwJToxoFJqFKtmtiG6xrkNUD8OyBklgT9AZJLVuVmA50DbhboMEibsg9JrS0fnfS7CF9B9pRakPNSSLkVY5nQzLjtYy5OE6C8irEgawfB/5X/GYLFw/MLi9SnhqhxwkFOcK1ApVfoiwGAiBiq6+Ke9AgnK3RvkK9FdaeHclVMINy3hwt5pWhsZ4V8j1ZNNoiIKVgKzC8Ht8OkmUfwX42+RYtd+7/Xqn/2PJoN3gvddXb8mTvzTMoD0LNj73z4beeqhtaW6Wjn/yjc185NuuYOKcAGeUQccT5PgtNI0No27FvjySq20doEG5ughs5UtkF87hSIMsu72dBev9M3gTqFGfMXIt/U9/IzkMi72UJB52ZiY0vPshXrqcmU9QNNIEGLycWxHdNqsmmBB4mwngF62VxzD/Gpo6zZaR5KJHCI5SDck8V9esbO/lqRjILhBXPmAgcSqjQP6dC4myXKrGcibi9joJOH7fiQC7mJoTMx0aMBPAoNEPHUU9FfCY6Elr35KW79kM0rZBkBgrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(6666004)(356005)(110136005)(54906003)(41300700001)(81166007)(70206006)(8676002)(70586007)(40480700001)(4326008)(86362001)(40460700003)(36756003)(44832011)(8936002)(5660300002)(36860700001)(2906002)(1076003)(316002)(82740400003)(16526019)(26005)(966005)(186003)(7696005)(478600001)(426003)(83380400001)(82310400005)(47076005)(336012)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 17:04:37.6084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 043998a6-466f-4af2-406c-08db00889281
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7707
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

...to match the "umc_" prefix convention.

No functional change is intended.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20220509145534.44912-1-yazen.ghannam@amd.com

v1->v2:
* New in v2.

 drivers/edac/amd64_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index f9254d8da5a3..1062cb56a462 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3586,7 +3586,7 @@ static bool umc_ecc_enabled(struct amd64_pvt *pvt)
 }
 
 static inline void
-f17h_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
+umc_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
 {
 	u8 i, ecc_en = 1, cpk_en = 1, dev_x4 = 1, dev_x16 = 1;
 
@@ -3647,7 +3647,7 @@ static void umc_setup_mci_misc_attrs(struct mem_ctl_info *mci)
 	mci->mtype_cap		= MEM_FLAG_DDR4 | MEM_FLAG_RDDR4;
 	mci->edac_ctl_cap	= EDAC_FLAG_NONE;
 
-	f17h_determine_edac_ctl_cap(mci, pvt);
+	umc_determine_edac_ctl_cap(mci, pvt);
 
 	mci->edac_cap		= determine_edac_cap(pvt);
 	mci->mod_name		= EDAC_MOD_STR;
-- 
2.25.1

