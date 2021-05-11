Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0D537AAA7
	for <lists+linux-edac@lfdr.de>; Tue, 11 May 2021 17:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhEKP13 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 May 2021 11:27:29 -0400
Received: from mail-eopbgr760087.outbound.protection.outlook.com ([40.107.76.87]:3470
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231955AbhEKP11 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 11 May 2021 11:27:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U88Rapyyd//kCW3FhXVffcVPCKZUtDPW0XSMhkkoqNyRdmrNTfpnEsvjUieh3+XMPAgY9HnrmXBjSp/v+KcnQO2ypYM23BjnLpSvcCDIZtsuEya/3FZ4KsTOUEi/LGd64UKGzsWvExi1QzG4LD+AM/cyxEK8JF2RagViY4Y15xWssvZPkSffz7nGnqafDtwMskUkBsI6CNenaoXAq59maMGv3K7eyu7tV38dbt/zl4NM4FJBscr/0Q2ZhKtOZbxWBNE6gJ8gL1JsUqMtaQkQ/iF6gKb/gAwb9SFXtRrrVnXHgyNBl/qX04ClYLHAyD6SBDXjybN0UsFLFvseCcDFig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgSeeTandTe6p0eSaEd9ZH1d9GD6Y+BiMlYioOJiR2c=;
 b=F5swrPdz7TGFF/fhtbwOjicEjc5o4fmofHpzinN7CTmj3hCwuRurjQGd2i49OuAqn+HIhNqw6qb0Xeks8nsBlhkT9YXSRwHhgcTrJ/DU/WUV1YRqzS5uTpSke3vCZTHESiOmrSNBbwXaUHEg8kdzkVomksGUiaHrmbmcSdsj5LzG9E5gsIrX0iXkScQGz3sJBIdd1bdhs212/4gctwKHPcOLUkYyB4XPrseNNhewGl3jd+MDH3fdFgl8jEyH6fyy5oF7tOoDR2gSw2briIq5MrPx7iDcs8cckouwegs/SqgeXU/6W6yXCR1Pv0xzSUtQnsDnDsieBPQa/poolUDutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgSeeTandTe6p0eSaEd9ZH1d9GD6Y+BiMlYioOJiR2c=;
 b=sFfOXSLk09UqCPZ8PztcksF5gHW08viHe8K/ojGyLmAOGbprT5dp0Gv0jyPKqyldB9Lv+mf66DTOZ4DPPvE/rzEfjLweOYAj9uC2yZz/FRVW/AhJyg3QLdzit/oAfwp8qZXVvNREEl8CQY4PC0TlXJwYWjNzhl0jemu32xSwlPQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 11 May
 2021 15:26:18 +0000
Received: from DM6PR12MB4388.namprd12.prod.outlook.com
 ([fe80::9030:4dbb:df11:c961]) by DM6PR12MB4388.namprd12.prod.outlook.com
 ([fe80::9030:4dbb:df11:c961%5]) with mapi id 15.20.4108.032; Tue, 11 May 2021
 15:26:18 +0000
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     linux-edac@vger.kernel.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH 2/3] x86/MCE/AMD: Helper function to check UMC v2
Date:   Tue, 11 May 2021 20:55:37 +0530
Message-Id: <20210511152538.148084-2-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210511152538.148084-1-nchatrad@amd.com>
References: <20210511152538.148084-1-nchatrad@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MA1PR0101CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::14) To DM6PR12MB4388.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from milan-ETHANOL-X.amd.com (165.204.156.251) by MA1PR0101CA0004.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 11 May 2021 15:26:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97d8850f-948a-43d7-9609-08d914911f50
X-MS-TrafficTypeDiagnostic: DM6PR12MB4402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4402EEC68B14EFFA08CD30D0E8539@DM6PR12MB4402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8A+cNYrqAHdBhd/tSg8mMwzigIuRuiaegYcSjcc9MJC19wUf//WwRP9TTEy+s/bfXPZ8sUJMstpbPJb8bFXP1HNFh7rPuf5s9Fi8VN7mIqgvlMvIGzzPjS8Od3pdWvg1Mh4XKr5CWOs/DqbKGvjTkiEPOSU7CnlVgORHSlOVXb/PAn/ug+wpz4b9Seiz/DWUDXmyFLtKIXyNa+g3i/UPB2BEU0R8jpxiJ021MoOjB/KK8Oadfhv9VcwRJ85zp/q0AQ52tOyxqJmn2tos4Be2KPOJb6uayZGHOabrXzZ2hdQem9r6dobLcl/NoKewDrdTcWSpmhrDz+HmWnvtNG7vOwaBi6TcdHVxvSHehqeb4Q8R6i9A34dX9ODcTdV6lU4WHPd2Scaez5EGFTjhOeeAPWYohWs0hTofE2dn7JkAOPgq9xKkYTOocICfKfxKeP7A0wuiO10BKMQjsYRvMWjc9jMLKQTjPiV2XKmXUP61vnlnJ6tIBV3115YSne0V7vaxaGpd0PsqG2KFbe2zCeYu5Lw2EybWC1aez/y+hk7gK9X0SVqWJ1aCWrWxbLTKS1S1EPkgolnh9sCUnYSALCmO+NC8bHe93qbQMXFa+kyTL15LgZn2sZu+Z3C+T24Enk+Rd6exueU4Gk7oHc9QMd/12w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(2616005)(66946007)(4326008)(1076003)(316002)(83380400001)(2906002)(6486002)(52116002)(7696005)(6666004)(16526019)(186003)(8936002)(8676002)(478600001)(26005)(956004)(5660300002)(36756003)(38100700002)(66476007)(38350700002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?H7CCbEQfuSSXAJZg1rFpqzoqAgBMtAUKkrjqmGH0QRLzQoqS0jHG3+MM8Jvf?=
 =?us-ascii?Q?FcS1e4W4pq4N6ZH1q+2TADN4m62thQC/0pB0b+LI+6EvYjOJZWZ5RoHeau1E?=
 =?us-ascii?Q?5UGrgqC8Qq3U0PUs3zEyM48N06sozXQP85U7xLOqQkB4NUuvsruUGx1ZzvYJ?=
 =?us-ascii?Q?ZsdYt+trBFuQNxJcTOxfAI94Z+z1Huf2KJ5KeIPaEq1IZNTOxSVXTuuUT25p?=
 =?us-ascii?Q?Z9/V3Gc8zg8jajNHs9KTQUN1ZdGZFnPdawpezN1aypjK5yrIjD0mCgDbv5V5?=
 =?us-ascii?Q?at8bV/OS1mQBBeoQRMUMX1ZbWbZiAW773fdRWNa2sGb1Mu4fbdnuGypuIQ9/?=
 =?us-ascii?Q?/YlCGpikgk9969lten/b6cAqfJ82rAySOYOZRBWFkj3/sakakLiusT7yZ11Y?=
 =?us-ascii?Q?b5/VPgEKeAFTzA2PkDzwuKqy4+OGfiaeduhdsiXJ2ERTRCjEd3Q79HVunHih?=
 =?us-ascii?Q?Dw9S9NTZhM6D3g+6V69xRqf3rL3kMBuB/lRiVe6Fv3UsGMKOgKXMFvNWG1l0?=
 =?us-ascii?Q?cBDZ9gi1R8RvZbQNnq6X87MJ9K0Xqmk5P34c6VwX6ysj+nJQlmsYRWDxNwdB?=
 =?us-ascii?Q?tezYHI3Ip416I0UyBuyO8zt5WaEtsDuVNvfX6Vzo+P3J5LRnJ44FEW7jmzGM?=
 =?us-ascii?Q?8R1pbBoLkvEn0BuRsUUL9zRbZWKyBH/2BqdXoHjFgpvXOqVfVY12CZmQAmF1?=
 =?us-ascii?Q?q6TJg6ECUw5bcs5e9WxWDBhXeoz7WPpNhNOFtr6oDnIzZwt1R9pdVehwBB+h?=
 =?us-ascii?Q?k4Qa4jfdnoF7ZF56xMNUwxwBom1VJAUSrbgLRuWv0EDtWbEXsgzUyP5Ik3wB?=
 =?us-ascii?Q?zBEXOkO32sVOf2MVODeJCfDySn5QvYCcQLZLLALQ9nmv8nG5rCrhmYtCMQVx?=
 =?us-ascii?Q?jMNHQ+E45Ky/vVVN2WRZdx7sGbdt2nq2+iWH+NQhK88jxgnmZE4uGEaTMQKN?=
 =?us-ascii?Q?SjFTJWvTkp7uC5cHVMsMc7CI4iCN/qrf6+XPuGXoOF7ITlQ1NakFnIp2tpym?=
 =?us-ascii?Q?YA78MkJPqntPKqDrALG0rJnIi4vQEQOgG11OwMNgCdkI6ObaDQgtGdFhbsDr?=
 =?us-ascii?Q?VGB/bLkJ8R1SC7b+v8/RIfHt5deu8E0zY9IHmSkCB2e/GLXvi9wSvWJRKw0Y?=
 =?us-ascii?Q?vD5DL36sXf7crtHL6JrJZINrj7jHgE+Bz5ifHXU7nddg1I6NgXUeoOze9JmM?=
 =?us-ascii?Q?qQFwxFHt9owi4MRvkTGaDHFnUIfCEt4k/qAbm42Lk1/LQ7MTmk1erHRUE2Jd?=
 =?us-ascii?Q?lEFXe+IguCMzmh75Shl5YPCVrdyd1Lk02DNGAIb9rWE2ZwvctrzyUSRqwjTF?=
 =?us-ascii?Q?V+P2gR+X7Fa7Hxi9NKsHrBNu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d8850f-948a-43d7-9609-08d914911f50
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 15:26:17.9656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNyJ0cPq1Me6wHiQg3L2qYKUdB0+ZEeW/Xe/uqX2Ash6nOcMi7MLlkr3kq+5Q5tP3ajZ2QXOxwop/38b4wi0wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Mukul Joshi <mukul.joshi@amd.com>

Add a helper function to check if a given bank is
UMCv2 or not.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: John Clements <John.Clements@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h    | 2 ++
 arch/x86/kernel/cpu/mce/amd.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index cf7f35fdf2c8..8cbe7221a253 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -357,6 +357,7 @@ extern int mce_threshold_remove_device(unsigned int cpu);
 
 void mce_amd_feature_init(struct cpuinfo_x86 *c);
 int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr);
+bool is_smca_umc_v2(int bank);
 
 #else
 
@@ -366,6 +367,7 @@ static inline bool amd_mce_is_memory_error(struct mce *m)		{ return false; };
 static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
 static inline int
 umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)	{ return -EINVAL; };
+static inline bool is_smca_umc_v2(int bank)				{ return false;	};
 #endif
 
 static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_amd_feature_init(c); }
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 055f3a0acf5e..41718e3111f2 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1542,3 +1542,9 @@ int mce_threshold_create_device(unsigned int cpu)
 	mce_threshold_remove_device(cpu);
 	return err;
 }
+
+bool is_smca_umc_v2(int bank)
+{
+	return (smca_get_bank_type(bank) == SMCA_UMC_V2);
+}
+EXPORT_SYMBOL_GPL(is_smca_umc_v2);
-- 
2.17.1

