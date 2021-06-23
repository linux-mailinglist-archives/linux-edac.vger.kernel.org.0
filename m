Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B740D3B20F2
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhFWTXE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:23:04 -0400
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com ([40.107.243.41]:25341
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230048AbhFWTXD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:23:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQoWkG2BBZOfykONModEkVk9tDviAhyMjPqMOiQja0jV+r1Z4ow8fTvg2fHwmI1vj2bhFYsFfoQ1mjlMlHTyYzX2RW7akDrlVlxARsmbnxdRq3xUh5Qi6bXOmtpWzffE5R30f5rBWOHqaEmcXV0qYeSB7H4Z17E69yjVtEWKyj07IzkwNaaJcvwwVgK+QNTdno+xjB7laHp894syee1eocmJF0/U7uneYcjJdFXkGrzOWlMJlA7tk5HavgWsngYAUnDo5VQ/pfadtX2zWCCRNQ8dMOK8NRUXf2nVKIu/sBbZ4SCRauKx4A3sHdLQwGZ5jpz60STmPA8NnWOqD59PQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UUKhtkWNY10D782RnVAx6N5rSrtJo9q3WxHlAb3Lu0=;
 b=X5N7Pd5KvtpYL8e1U4Ekgndj3u/r4S97cfdbSIK5hkWDJAsJfApbvjxR49WupLiu/4gJYT8aSKlfglU7p6YD9n1Jz4+49zs1evbWhP1sHeAmMTmLfr9vdCdFrxcFqZPOP0YPqczy0E95dhwV9yBLdwTUrn1/J0DsHpSRjj/dFM9CZ5oHKBqLLaTBKbDfUSamrwX24IMwgUjegG9+wk0VpvJ7o8TJvj8YVTpQ4/byUVHJYEFK2e5bE0xTXVG7fVT6mQLCepMB/ibLmEq3LeA6LLIAdPXvu7q5Cj34eG9azCsjY5do7TCoDmjmR8jdukY2+gKow8a3weBj5WZsNQz/rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UUKhtkWNY10D782RnVAx6N5rSrtJo9q3WxHlAb3Lu0=;
 b=LgvVcn3Z4n1aMfDYHi8Cb67qINza0GSsYovU7/Gc34CR++2Rev++YNTVlyUVKDs+8xCfuwV7L5jPu37OMF/GjK8c6lm3ypmyA/WKFraAoZWMJ5CArG2K6W+mJsOYoUdyVH1ESDQ6oNbMXsN6DBS+PLDbF6co4UdtqJ9+OIj/y1Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1187.namprd12.prod.outlook.com (2603:10b6:404:1b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 19:20:43 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:20:43 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 06/31] EDAC/amd64: Define Data Fabric operations
Date:   Wed, 23 Jun 2021 19:19:37 +0000
Message-Id: <20210623192002.3671647-7-yazen.ghannam@amd.com>
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
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:20:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81812adf-2d7a-4601-03f2-08d9367bfef2
X-MS-TrafficTypeDiagnostic: BN6PR12MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1187D3956F389152851106DFF8089@BN6PR12MB1187.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J47/qwS7Uyue52cOztWl9xkYjpxjitMgyFgg+HF2SC8fyiktEKYbbCa4pPiSrXF8v9clH3vHTx5QTYC9vNcY83TnG2wAihUdjaiOnyg3Dd46PVhWkKbvQa8d68e0uBgdRwi20MurkxARHo3daLVPOVBHDEA1OOJcrIxCdQTYjyf7tt7xgQ/tWdmYhRbF/VUVC5w5j7YhtLoy0yiLbPlBMyNw3RXwtz8EjybkiLKf5S/uWB679Ja5ja+NjeCW2h1bBAuRHx2wND9op1gx2+G0HTcPxPDrgVQl9YL/FDa6wVnatrfkQmgxXSmJUYV67SST3FUmZLtuNaUtpAzPtKYsppj+NFSAal7MocY/xp3YpvqHb/BUP7i9Vfr2uyVBGi9dy/ZvPLzO+0thTN16tlGNkES5t0fNQyTk2fUmQSZmBzGQ0ybsK02ZSnJER400VGNAwr4QJd2bAxFI2RL16+78xZybcSOu7LEu6hfH5gS5kDORQ/I/BDShkvqqnzQ+TnSpeystYxArptZpdAyipobDM0RIX/01anJ5iv7qYEe/fuizqBOV4Q1mKLbtrPHtUBhfnLi1PYe5xFa2OBqHSL1C4UhCdTcuGgTYL6AosvvTfb97rY4eZxujrgylEuYeehR9A0wN9jiU0ZPoM1E5w1q5YhuFHPlJez3nKtwK+JO8Pe13GOVwIrwSd/DJm9KBW5x5pubwOIFilOekLV5eOiJERmVuBodI2shhBu+/jUnzjKgZzQW607ors2HwtaVrEV/OeEB1Cwq7DBGKHDWGfW3IAdL4JCSAHxjRZIxC27ImOlRSFG9rsI6GzcPGhrEVyIscnh75sML+VGt2VU4cqv+mLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(966005)(36756003)(38350700002)(38100700002)(44832011)(83380400001)(6916009)(26005)(7696005)(5660300002)(186003)(16526019)(66946007)(6486002)(4326008)(52116002)(8676002)(478600001)(6666004)(1076003)(2906002)(86362001)(66476007)(2616005)(66556008)(8936002)(316002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YQDzw88TX1RNo+k2E0ijelk29PSGk39cEcM2bPo7GNBUfptHvIOtmn+sAYPa?=
 =?us-ascii?Q?HAGZiW7bTwUKY499pNsF7DCuBpfR3FnSDS/+47QXJoJMsum/ylsWeIKIVQlh?=
 =?us-ascii?Q?2HKYxzuYzqKeDkIdAj9LcGgWtxkqBL2z78W57KZXINv4T8dtHNCrpop1JHWD?=
 =?us-ascii?Q?EEzSkCP6qbnXvdUS1S+aAKIiLu65FXfnvOcpvH6sCNhioMp+bY2EdEfS1wrL?=
 =?us-ascii?Q?gLZknwUc8YZDzpQNwffJNGT45EhYWS+1wUTh/saG+XOZisPB1rOAYpcMeB1k?=
 =?us-ascii?Q?SGoUlJZn5mXrTmHNNjB76HbpPd7P7GkCTfOQSzE9nVyeFfYjErLrJmDsgjsI?=
 =?us-ascii?Q?8VZ58MCW/lSNe7+yY0T2GjuE0cbxhhYvMSi0aMU2+MolOv2+41qwnUQHsdup?=
 =?us-ascii?Q?uXQcaWctBmGLJyTFRMmab+NlVWd6gBAeB9C3B5/0b0ANwb+b05k0H8JLSL92?=
 =?us-ascii?Q?t5P1WKvk7yMj5VxmJjDzkuGQqFeSQjgUF9gk1XPtC9cxQQ3NQI6O9eQbTl7W?=
 =?us-ascii?Q?gV0BwEcO5GJ719qJb+vt0ro56oHO038sh3SiRVohW8PADeEZ3JpOGfG1vgoA?=
 =?us-ascii?Q?f7FLIbAPQirLUtQXX3LymO41DsM8AUQOMd6iz/KnlsRQ9Ph6r9EhOxvqBw7F?=
 =?us-ascii?Q?O3bsws/s96JYo/+EFpGGVNCZyxd9gMxm6Q65hKIMDcbrzVI+mj37WqokatnP?=
 =?us-ascii?Q?ATW+TH10BwjtaB6oGPlta2Ar8xTaqqVvC9MUJbkn6Juc1oy7Pnb+ztNKBBUz?=
 =?us-ascii?Q?x887pZw+Mza+FtxfAoFyJPFghDCJP/AH9tYDKlthjkRRzvOlpgfoJ6FrsYkC?=
 =?us-ascii?Q?N+TFFTLB7OFWfDFqRM29HtUFKr4F6b/c0CD737tAnCL8ko5YLFmzJrm5SuFf?=
 =?us-ascii?Q?OG4m22FpJAEi8d+FuL1DoY0CZsqOmx+GZZDdvsQfnUBcbeE7nEpDxCZvm1zY?=
 =?us-ascii?Q?FS24MvWXLuaaP/HC0a6dY6Ytg9emldDqyHheQIpXTQvYUb/69lPyzG8ExOAt?=
 =?us-ascii?Q?Fmxza++l3QvD7aE5z7DjG8p0ACTe2P9kauYQeHRlhvfgCSjpl2wjYMVS5oUu?=
 =?us-ascii?Q?BR3guBuudM7C9En0oM/h1GtOa36gUwUHVzobROW65ir8LPAM5MvsjKpGj18m?=
 =?us-ascii?Q?/7gjK32ZOFN4Nmsk/07Ndx3WTxX+ZemJIp2G9RiPZ2YoDvpE+XeY/YfOHygs?=
 =?us-ascii?Q?jb4IFYCyVvNpRed41ZWHvy81inIK8l5ltKjUTfm0K3XSbyO3G3Su6s6SAFT4?=
 =?us-ascii?Q?qzjsAhge3GGw6NKHSDrtEmVpuaS7f66ygtleevMHTv2rmcl9tkLFzz3HuAu3?=
 =?us-ascii?Q?3BF6h8fpHgZ1JqbjQHu0Rff7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81812adf-2d7a-4601-03f2-08d9367bfef2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:20:43.7245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aaqRRRfHxAFJIIjVuBSQ6COkyU+qXTKwOBeZ4wWoRjygf7PX/maU68gEcvVvXjFpGakFoCVSDL4lFmAZywtBag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1187
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Define a stub to hold operations for different Data Fabric versions.
This will be filled in following patches.

Define a function to set the appropriate operations. Use a return code
because future updates have checks that may fail.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210507190140.18854-3-Yazen.Ghannam@amd.com

v1->v2:
* New in v2.

 drivers/edac/amd64_edac.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 62eca188458f..f769353ef7e4 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1085,6 +1085,21 @@ struct addr_ctx {
 	u8 inst_id;
 };
 
+struct data_fabric_ops {
+};
+
+struct data_fabric_ops df2_ops = {
+};
+
+struct data_fabric_ops *df_ops;
+
+static int set_df_ops(struct addr_ctx *ctx)
+{
+	df_ops = &df2_ops;
+
+	return 0;
+}
+
 static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
 	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
@@ -1110,6 +1125,9 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	ctx.nid = nid;
 	ctx.inst_id = umc;
 
+	if (set_df_ops(&ctx))
+		return -EINVAL;
+
 	if (amd_df_indirect_read(nid, df_regs[DRAM_OFFSET], umc, &tmp))
 		goto out_err;
 
-- 
2.25.1

