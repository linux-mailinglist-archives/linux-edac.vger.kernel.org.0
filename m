Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030EB3B20FE
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhFWTXW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:23:22 -0400
Received: from mail-dm6nam12on2061.outbound.protection.outlook.com ([40.107.243.61]:4705
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230152AbhFWTXP (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:23:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTldEZEUvmxQB5EHISb6ztuuYWlI0QYWKhA2xIYPH8fhCIPpwEMSe0ZJ1Eb58twy0cY2/A9Erqt7z61TXNG7hG+YkFPsDcyb3DMtWr0zfUkjIYGo3MdzwYGuRPbGUhpmchU0cj3LtWeniJsELOKnqPsPzeOG6hdPTyL2Wg3Ng8IJRs0FpGY/QEChwJ9XE/9DczHOIoxgM+g953AfdaqRCbjlZUCcP1G1VGojQp6hxx8wmmO18K/VQwzwSC/jZ70FSjxABmugeT5cXhLFJzWp/Js+Udn1IByxGlw6stXPPvwy4J77r+6lU7qyFhbL4A/7HWThaRHevegbGheeW6obiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7eOIqzHl6PQtUMhdwM8k4lv8KQxs4TVWDw9LDcpok4=;
 b=LlmffyzZ4WIY1UnEQdfiL0/VbobxJ4uiR65VDTIIA8SGHP1EGnQYSYSZaTBKfjBF8h6VkLvO3mdUfRQftGgUKPnxlnjVVZ31AIwx5FX98y8GDBlpjkP23CMa+9GmvbRK/1wKbKmSYwRCmj6xcbfQnX4zATYGpY/2IE/7nUIZbtFZIicC0XhUsY8VGnuSIJI57MyZUsDQrVlPT8ML52iO3tnQJUc+KrFWflOxECv9G2VUllcdVU1+lhjF/aM1+Y31Osq9eNxFikOPsAY0VBybIRxVQMBUhDIBAh6efbTF06tldxsUKO+z9eVl3yy3J6j1QQ5lK/TNhjGERp31/alNXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7eOIqzHl6PQtUMhdwM8k4lv8KQxs4TVWDw9LDcpok4=;
 b=Jwp1LWnk89+rUCGCTgNC7Hgu8Ei1JOhWXyYYezs2SriE5lnBJiqvwnau3O+QFoyl7pIl6nWPELw7du9SUFuSgacDnGplaZ5aDigg6SzyebGv+yxbjgtSMyA084hSAulIVImFXe4Ocajohx2v7xqlibRaLc3i8+8mRQjCGvykecM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN7PR12MB2740.namprd12.prod.outlook.com (2603:10b6:408:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 19:20:52 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:20:52 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 16/31] EDAC/amd64: Define function to get Interleave Address Bit
Date:   Wed, 23 Jun 2021 19:19:47 +0000
Message-Id: <20210623192002.3671647-17-yazen.ghannam@amd.com>
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
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:20:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cb15235-e514-4b42-1a4f-08d9367c041d
X-MS-TrafficTypeDiagnostic: BN7PR12MB2740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB27405AA446D87E06C44E451BF8089@BN7PR12MB2740.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJrctNimGG3Y6uCB6f+UghLGO5qpwF9YncBQvCkEsNIz+FFMpIIOEeD+62o92hYMc+Zq9fXyYQqVv5zN7SOYP9GSNyv9UmeCtE/gSQSjg84i/PkB7yoUPSQamQSOU+Anz2sHx+GtcjquBYGH0IMmZY8ua+lK3C54AjoTawrdRAQzunemzsQrvpsLWmDAK3tto5GLtfyGn6+Xl9V7YVKaWvf/kMi4PrZ4G3wukNkdaeYsuPzH8AfvjOJwjgtimZOKnUUVKjNExqFoSYfm9IZeCzzk6wwFYEqqyrQkof04DvZk1I65RYlrjp17u4sHCXjHNt7C0G/3ve0qBNWDKJnTbJGIZclVS6xU0F3afxBpPEPV7uSf+u/3NJBntTZhT7DBKlNStZ31v1WHW7fQE3nWpVzZ76E/xTcSrnIAK5zMKL0odMz8Cfk3cSnilLlBUZGaDvm6gKT4ldfI1QqqMJGwuDmxxsmJDAo4634uUkSe+uogMXiLbQTyxz9GKu1i6exE+vW7QSpIdko3Zw3A11LjrT9UmairZUe0tlVjJqnSXoDLz8f9pN7DBvYK0g40zNWHbaB23FBXj9F1nC1JNvbHQbgmE+WrRXDFFKok48AHrfN0toEF5rt+rbVcwLZzYZfQx1+w9Kj9dzC5z5f0kpecGrBS88v3XSLqmD20rKZKtEVewuo2FrG/oIRoshq7R8aQSLMHjv03LCaNdw5BScY68xetA2Hi592pPGm+LjnFgMKEtzJzZIdt+F1RS05rhx04r4fCMkU/XQEgyNyvJFQ9N8ZGjxdIPcEU6IqNajWn7mvOD3i4cvyHfJ54LJWbA0rk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(5660300002)(6666004)(2906002)(83380400001)(966005)(6486002)(66556008)(66476007)(186003)(26005)(16526019)(86362001)(7696005)(478600001)(52116002)(38100700002)(2616005)(956004)(44832011)(316002)(36756003)(6916009)(1076003)(8936002)(8676002)(66946007)(4326008)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RwdI4q87dBd10VzyeLlYQc7cglUImDpiD9wxefP6WMKkTiSAQ1TPoKOzjyq5?=
 =?us-ascii?Q?aGW64XFqFxe1DEXoex7rkAkqwxzhNy/RpXaq7kwScP1U1sP9ztIZTAfycc4t?=
 =?us-ascii?Q?BdQY3VwNjQFy5osHFdLb1hpZ5BxV6uxEeL718XtnHWaekPeRACp84g5j3bKj?=
 =?us-ascii?Q?6iiRiZRjLw9Q8oiko5PZ89tscmGyPIEAy/v0aMQdVdJC5JG6FzpVkThIrD9M?=
 =?us-ascii?Q?MudRnveLV5Yn9QeY03vJBu48FfQ/5qqAvqG6JYE9dbbiTAFFoYt7/azGj+sL?=
 =?us-ascii?Q?7PBBg2c7/c60X1eIq7WhVIooqdYAMsbhXSDH9pPlsN3tPCITMhn/1Of78x3n?=
 =?us-ascii?Q?5vZIxYTAAPV5Hru+Uw5uc18mLYWdDeEFHRAwi7j+jTirSN4hfnVG8ElxFhC7?=
 =?us-ascii?Q?MRuMrGm3YxHDCfTLO9LvdLysJo9U5Gny+2V5xq6KOrkXHD68zsSxCTHAI2ev?=
 =?us-ascii?Q?eWie6WYGwJVGA15obiU9bhgi9cPDIni7IbghuKf6Zew+v/FDnCA6F6S8aYzf?=
 =?us-ascii?Q?lYUV44ibKzNsjRwlWP/vWnCgN5PoXueNlL7yLpZTke+7Fx+KbK8DOfd7DwiF?=
 =?us-ascii?Q?XUJ5HR9lQA9gHqwwnbCkX1SMycDX0RNJ5kC0fIEClJV6Fun+Vr4xy584GHEZ?=
 =?us-ascii?Q?1giTUdDBFwi9Vb+0YLfl3XfkPBD01b3EfmnxVVme2/pRW3jC15An5WUobaTh?=
 =?us-ascii?Q?Vd9H2P0+xAHZg2UwW9lh7u2MncFoS9g7Em5DV6dk1iup6pIqFoiGtL7FuUfr?=
 =?us-ascii?Q?dDhXl6VGIXSAmK/bsJnS/PmwFfS9UbCIvlLY+2wyzyRwmcMIYo2ylDWC/AN5?=
 =?us-ascii?Q?vYuFnVD/F53w70ZVUCf7mCud8mVTZQZL8UkozUiXEKSx0xQawCUDGwlAH5yF?=
 =?us-ascii?Q?dVjw3TgmOn+oxj/LbyqmNslqAI+nz9d6Moa79Ka+PfjlMdFpBi7shQdSUXFz?=
 =?us-ascii?Q?mLzoGD1K9lGBh7rm0rXDNKEMoPaPp0bQ3vO29VbBnX5g+KK93Nl5p4pqIO7+?=
 =?us-ascii?Q?47I7kXhgEmaIWjXR17rX3qXwJ9kQN12KEyuimyhLq6yjMDczv6Hgl0zUNGvQ?=
 =?us-ascii?Q?PBIk6DB4GiQYRaxlkMbnC2fgrHJEm84OMZSu7kizyRgwxEu+ZtwxyIOxCtpf?=
 =?us-ascii?Q?bZjjxxzAnYfz/dihpXC1UmKFhvC+TBA0SaBTiSGZe0dXy9+huWmv3CmfWBaA?=
 =?us-ascii?Q?45hySgZdvfDiyjl0gw75/xIC+14sdXVEi+/fMwZ/iaSNMy3Ci+5TIYMQYdUH?=
 =?us-ascii?Q?Cc+YtMXySrf0+NR73ISkbkuIZXldCtLpvfnhOiRwsfzM8eyqab0r+tJZT3EK?=
 =?us-ascii?Q?6vh45KNygQ06RwuzWsA/ZPap?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb15235-e514-4b42-1a4f-08d9367c041d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:20:52.4195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/TNiBk1t4cgswIDyVoHEhtZSYFdxbnmJOCi3wKxfR3yF93irSj7b4fbE9pJwkiidd5Lu/3kPAECzmkdzLQWKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2740
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move code to find the interleave address bit into a separate helper
function.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210507190140.18854-13-Yazen.Ghannam@amd.com

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 496ca863f45a..233f8cec4fe8 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1211,27 +1211,35 @@ static int get_dram_addr_map(struct addr_ctx *ctx)
 	return 0;
 }
 
+static int get_intlv_addr_bit(struct addr_ctx *ctx)
+{
+	u8 intlv_addr_sel = (ctx->reg_base_addr >> 8) & 0x7;
+
+	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
+	if (intlv_addr_sel > 3) {
+		pr_debug("Invalid interleave address select %d.\n", intlv_addr_sel);
+		return -EINVAL;
+	}
+
+	ctx->intlv_addr_bit = intlv_addr_sel + 8;
+
+	return 0;
+}
+
 static int denormalize_addr(struct addr_ctx *ctx)
 {
 	u32 tmp;
 
 	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
 	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
-	u8 intlv_addr_sel = (ctx->reg_base_addr >> 8) & 0x7;
 	u8 num_intlv_bits, cs_mask = 0;
 
-	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
-	if (intlv_addr_sel > 3) {
-		pr_err("%s: Invalid interleave address select %d.\n",
-			__func__, intlv_addr_sel);
+	if (get_intlv_addr_bit(ctx))
 		return -EINVAL;
-	}
 
 	intlv_num_sockets = (ctx->reg_limit_addr >> 8) & 0x1;
 	intlv_num_dies	  = (ctx->reg_limit_addr >> 10) & 0x3;
 
-	ctx->intlv_addr_bit = intlv_addr_sel + 8;
-
 	/* Re-use intlv_num_chan by setting it equal to log2(#channels) */
 	switch (intlv_num_chan) {
 	case 0:	intlv_num_chan = 0; break;
-- 
2.25.1

