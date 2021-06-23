Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF273B2118
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhFWTYM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:24:12 -0400
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com ([40.107.243.41]:25341
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231137AbhFWTXo (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:23:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWn/MHkMtxiISP7C7WuFkM2wg1VZ5EejcZdLCcy/aFbCsg/ciXQMKBKSOMzKmBLDoouABIPwgfDtTuELA7kKCZed6hgab4y/2QBwB6vBUaSA/UzY1EQ9gt8udhRc6jSAI5gWPHBpSnxRxCMcOb8HgM2r7sEkDt0/ip6RYHamfiYh+nJBGHMOvJtV+LZQMVagcfCSHY+RNpAmSfMl7Ohx4VTBIIZ9f5BaYf1QHRmrSwcj9scZSb+YY+BRASDR8r4NPEpu07LBkffWcSrzouDiMJDQQqpdfFPEcdKKRXL0XXOcQJDARaOIRMxHv0V5ab+jVscwfwKIXN1nOysNqLIOTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oh6U44yBDt2WHECznV8IpYYwub/rQ9MTHTJTv2E8F6U=;
 b=h7JVlRWuk/7BWtpp98iXkzey4Nn2WmonQ4jlKIK1dRYPx6FrtRcmOW3DutVEqCYgvGqjH7Oh2lZgFCxUDzONHSHwtGe3XWASjhHMqvRa+IVT/oGGBDIGa6a2genXjlQ3UkZGiGGC+TfY+hyrTFXE42rZnMqGsYRljT4kj/mmASGh356S8qqQ6rjUdJkF7t/7t95dVYQJU/+gS829CDg5k2aSnoYCUkt3PnigLwgUvSm/19V0G8+P19Yi0nr70/Ng8dr2NRGfB8frfdmu5UcLRmSpFuExPpScHo+omeIemJhexnCh7hAAMA6VflUM7jUXnGZh7Yddsq4UayfOkcao4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oh6U44yBDt2WHECznV8IpYYwub/rQ9MTHTJTv2E8F6U=;
 b=a1GZTjcPAoncJnAmCXMtwWFcJN+bI0XBL2ALXnxdZcg1T03dqRhDYDYHSj4qrLjA7ibv4evo6lLWwHtOE+NspF/uygYUwacESXsLg25S8ibccOd1kgLJmQLPGFI5FlNS9GqDmXaWLX7wuqvi4fBa0JFi464h50qXnhngpi1Ei2c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1187.namprd12.prod.outlook.com (2603:10b6:404:1b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 19:20:50 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:20:50 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 14/31] EDAC/amd64: Remove goto statements
Date:   Wed, 23 Jun 2021 19:19:45 +0000
Message-Id: <20210623192002.3671647-15-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210623192002.3671647-1-yazen.ghannam@amd.com>
References: <20210623192002.3671647-1-yazen.ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.184.1]
X-ClientProxiedBy: BLAPR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:208:32a::22) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:20:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f22547e-be81-4f03-a7e5-08d9367c0304
X-MS-TrafficTypeDiagnostic: BN6PR12MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1187AA1695E1AAEDF5764ABEF8089@BN6PR12MB1187.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gSGZZ9u7iZDPmF8xbbmjoAog9wcj03UWhcJLZ/VddUTCvZfkcY4gaqySASANqhJGE6H5/wtVmVSTwHkcLoYKne5GazPl97nY1HCg4u6NBYy3yf5BSFd3NMdC3CMznFXQgiyWPdoMwk9Pyz9t56DQXfvxyCjl35WzCZLqN0ot5cFnrzThKdlqZUJRPBU9Mi02jMxepepUS4A3du4VFxoFCSWSfDTWvloAKAwsVZrC/b0LcL4sTpRURJEwwVBXaIZ882WvYeod/DdCkaxKJ428phLUBrlxybjrPiAqiPSmDHx+vzl1f0QO/40dtiS4uCw53O2c85OXCzOXXa3JM/ANpP6g7SWahU52C8BF5kogjFcwqdkdPHYFZQhEMLPIC0/795zkuuzdMDAJdNHrEi5rLSVOBhT1VzMOxl8h31+VQOKtS89h5w/5iAc/y7a26g/Oz1rboDg0DyZnJ84yxe4kO4+leqebhGks2v2rwVxfpGAmY8sh8qVM8QPhj/o5WdzlKbQ307m4F41kmDNKr+EefexpcG83yMCn/HZQAdKXNpiTc9OAM31GbvT3IqVIuRZOFpCm9ae6iELczUapHVcoJczAq4eBf+O1QQcGw/TplqFv1Buz/IsBrCeJXT+GHLSDKfYGQQCjwpC59Jn0ttLtLLw4LtNSSal01WNqemT9c/MwppxETzQGJTb5spTa4lwRABrLThbqjishSWJ29Imfj3nSiNOJMquuerEsdmfAkiANbcTU4LKVAfcMusEJdBJp+zPmIsFuQxYV0yi29y3b9RAMxIQMcCN+OYOg3WpMprtJjXGt87cAaSTuuuYMlaR5uA6lOVKVYWYptN1TC/In0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(966005)(36756003)(38350700002)(38100700002)(44832011)(83380400001)(6916009)(26005)(7696005)(5660300002)(186003)(16526019)(66946007)(6486002)(4326008)(52116002)(8676002)(478600001)(6666004)(1076003)(2906002)(86362001)(66476007)(2616005)(66556008)(8936002)(316002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7k8XLIAx7Hfdt83ZKgoZotmDpwf8LfqEvmC+WB0mDyi6zOu4XLhvfGsyQQet?=
 =?us-ascii?Q?ibVbkTMUpDaDoa41orpIchKg4EO8u1N9T928j6FWaCrdMu1lTh93dbywu0hB?=
 =?us-ascii?Q?VAo+uY/IJBB3QCDnj9YO+BPh6TtUKTE6tBPik2BvyGGPhqz8xDWWqTPMT1yB?=
 =?us-ascii?Q?6cAo11Riwc9bLJSEL9+N79lKUrzya90egX1jT0jOwrmXec6zzv9dbBvbgp/r?=
 =?us-ascii?Q?GlHKlFx/Q9tVqo93VTUrXPhr7czSqoIX5blX+3QK6VfNE/TybVRm7YFEvsss?=
 =?us-ascii?Q?sI5t2Uz6LZM+lLdZ79VJrzl3txqBoPasBe+ycC+Vj2SrzThi/nndEyJmf5l8?=
 =?us-ascii?Q?VAEOw+sPBelrE8zuWjndHfFqzNndXhjaUPzsQCpy0TiEU/uK+obKvl0Y0AXJ?=
 =?us-ascii?Q?4u/UEN52QIpVQBilWDQH8AE31bN9cuETG6xrCbSU0fapvih+8Gyb/+Tv98Ch?=
 =?us-ascii?Q?4HGsvqjRYAAr/P4XwVvFP39RquGRUhV7UKZpgTE5EKkN7cpt9dajzA9XyPGY?=
 =?us-ascii?Q?zwM8QSpG8e+2KumsEkwlctSRaC4D5HOGGti5X9trg7rqDuisYikCm/PDZNQ4?=
 =?us-ascii?Q?qrrLoQ+59i6z52/C5DohnnW2CZXjZXpcP5ocgYkWyFoX9bp7K5DRfS/eZ8yu?=
 =?us-ascii?Q?CRcvxsVdLgwRgsAlZPRD9Qa9mIHaMpAxfJBPF84bOx6z0lk91AcWUBjGVJ2v?=
 =?us-ascii?Q?Jha8cA4i96rZ769KGA9NTwaJfDfYyfhnFWUY1JOBqy57VoFRp+pjxZAHz7xZ?=
 =?us-ascii?Q?hiTxHSUylMhHaRv4bi4ZVuU35LxFZ8Lpi0n94zz71KGpeTdJbftGruuI/ck1?=
 =?us-ascii?Q?phKjsFI3Z521MfauDXwNBAt29PK3ZJ9MttGwZHPXBP29aYkUrz9YBZzPB2EK?=
 =?us-ascii?Q?KHkLnuKx7Nu+zYHaj3qxkbw6K3kjsGNYAtSCS5zktavns7bmx3+Pqc3FJIWS?=
 =?us-ascii?Q?x3qx8Hn5uZRMaQyMNu7ihQQyGa1KiVxZMfdDsWmSxUparKCc/8N/RsOHdwqw?=
 =?us-ascii?Q?Curnl/zwUDuWt//HakjFAhPn3deal1wiav6726xi6wjVQbfarjO1+zbkvVyj?=
 =?us-ascii?Q?C+4a3gUnFFshKGQE6VhKtX9+FDj4lGdcGzxQbo+URNcV0dkpLaQEn1yX1uHN?=
 =?us-ascii?Q?G86LjO3mwCOHg7rol1NcrYcJuYy3LWYa4KKwkukN50fp8DK133w94MUe9tHY?=
 =?us-ascii?Q?unnL/en7bCcT3y3hMDHX4FNDYI/URno1rTATSIG4ocTXB3oKh3i0RmCw2rBw?=
 =?us-ascii?Q?gKlTr6XjfzkyXV9hc2dYk2hA3kbaOOtFEmeAqhwHHtOVcwV5uf6cOFLyeHg5?=
 =?us-ascii?Q?VeEA6zlQmw0DlSNVI+++R7Ss?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f22547e-be81-4f03-a7e5-08d9367c0304
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:20:50.6535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ke/NSIB7zVWf9y4Sj8bkFipdU0oyINnHvGxGBEr8btfJu7mLMj7K+DWv2gEi+OsuAfZ4p/Ugt/tT8XUg+oOf4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1187
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

...and just return error codes directly.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210507190140.18854-11-Yazen.Ghannam@amd.com

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index de80a224ef12..3f1ff5adce4a 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1390,28 +1390,25 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		return -EINVAL;
 
 	if (get_dram_addr_map(&ctx))
-		goto out_err;
+		return -EINVAL;
 
 	if (df_ops->get_intlv_mode(&ctx))
-		goto out_err;
+		return -EINVAL;
 
 	if (denormalize_addr(&ctx))
-		goto out_err;
+		return -EINVAL;
 
 	if (add_base_and_hole(&ctx))
-		goto out_err;
+		return -EINVAL;
 
 	if (ctx.dehash_addr && ctx.dehash_addr(&ctx))
-		goto out_err;
+		return -EINVAL;
 
 	if (addr_over_limit(&ctx))
-		goto out_err;
+		return -EINVAL;
 
 	*sys_addr = ctx.ret_addr;
 	return 0;
-
-out_err:
-	return -EINVAL;
 }
 
 static int get_channel_from_ecc_syndrome(struct mem_ctl_info *, u16);
-- 
2.25.1

