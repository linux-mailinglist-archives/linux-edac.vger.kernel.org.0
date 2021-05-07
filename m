Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18C7376A65
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 21:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhEGTEG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 15:04:06 -0400
Received: from mail-dm6nam12on2089.outbound.protection.outlook.com ([40.107.243.89]:47105
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229662AbhEGTDi (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 May 2021 15:03:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzmE8TdAIqiERliVacfiTZvVjs3ben5N+eGwnUbR+rqEC1H4rGtKWpLEzhDm9sfTNwRvOOsMBV+tQWKumMXt0q46mRw0FY3g1iAd5fJyIf5eJyCwJS6KWbWs4l4gW1NlcR1B04A+/FFjmnTygEqg80U6OXUpFH6ZI8SyR66LGGwA2O1NrSfs012izTZMX7j3+l+okL6Cha9pikODTwa1nX/8LggMIKoZe8vBuusOc5ZR5/jdbTF/UDLaOoHFNIuzaPcspWyJjYdTxIcJn1oVOqF1pkDsmv4qTEhH4nhIi7Rlfh1bpbm+cW+cx4Ke1rxG2DmYihe/eP1q55sy/1XZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Cn9Z3Vyw86bxfRiIQCRTvA+MPQ0NT1D9R2JYglSwL0=;
 b=V7hitFVJr0kExOPfIMU2ulocz4RMGvLKCYROtWgTboWou1fCkU/OsXnjeKMHT48fCxuteDWd8O+TRVpEZ1/w8F/5+3ErXrOp650fCgu1c9DKEN1PVAofFMIxofQHMZsTM1dNfNIN00wthDMwjzFWzQb8UTVow7IeMmzuRk0lDFOW1oXsR2/yUa6qd+0geFhcwyyGIRnVKlLIItY9In9lDLfXcq4Cbv1yxAytjGxCxU/gESo/Uw/napt283RUxACYqcxtS4euVo6Pwf1DsVP4q6h1f8rVTIY5ebjmF7Yz8MgURKKb168KXHS3aXefBsUl/qWt6uFqqFzatQoAs32OcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Cn9Z3Vyw86bxfRiIQCRTvA+MPQ0NT1D9R2JYglSwL0=;
 b=TY1xWofEyaBSSELNjOaGeN/hzL1HAVnAXRbtzIdyOai4Wz9P7poCzLMiQCsK5DHzHVxJ3G/Dy+HAHy9BeSAPQKTXpgkDSPjGcY/IOkRzXgCaJuO1LL6oInvrYKKaOB6HFsybwkalHrtJIG7rRkWaWWB3dHZeJewqIHuus4+UB3c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1620.namprd12.prod.outlook.com (2603:10b6:405:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 7 May
 2021 19:02:11 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:02:11 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 18/25] x86/MCE/AMD: Define function to make space for CS ID
Date:   Fri,  7 May 2021 15:01:33 -0400
Message-Id: <20210507190140.18854-19-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
References: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.25.250]
X-ClientProxiedBy: BN6PR21CA0010.namprd21.prod.outlook.com
 (2603:10b6:404:8e::20) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:404:8e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.3 via Frontend Transport; Fri, 7 May 2021 19:02:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84670962-b579-4e95-692f-08d9118a9e8f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1620EC0A9FA1C89DBA1623B1F8579@BN6PR12MB1620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O489hqD+VmP/xO21weMvRiGYt640Mk6rvTOtBwlOvYSQYjP7aqlMMpmiklTmi56VgHdDaKyZtHXW+aYNjS5/60F21NDQa7QS9fPSQGUsdWSkahVZT7GwC+AVJcJfMgudhLwq2KPruH2mkhZkTDGS2VXfQsQMIfua2j07OR9XJslt4yOzVlFjuygdt8OHp3l032+wqj1BQZjPJzT4yMiflQ6yPfzobVxHPvO4dYEtvh2tH2Y95FgsZzhZchgXq9sSw9Hf63pCrc0uAaBvjfc8yEG+zVAUNYHR9IuG+Hv97SMwiGjCo/G7WT3CMNbBNFNQMXC+LYHbZe+XeEEovLTYop0tSICb4ELyA4P8G8kgTm5y83hObSk/f410mRUJV3eV0oc8VBOIYXHNSQozau9PWgJZw5fcNP3paWgUVLpTHbwruFFNsJfYrbAWS1L+H6kuFu0Kgy08+HACrEgNPk3RQKrhqVpM4Ka7lmpkYuCztx/9B+SxnqOWO/398upJ3g06Skr5uw6sd0VDPa55MBoQLF2udXCurC7upR0bgdR4BOMQk1MLVUXmljq01pX8wFoMhWmDzVi/CavaSjRS+OItwG3H1RcB+TMpLysQuu0dejeQGb96dh0bQcAyMsjVnH0G/aEouCdOh1ME81mbeqyfqRpCLO2SiJlMS4Hm84OL5aU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(4326008)(6666004)(38350700002)(38100700002)(66556008)(2906002)(26005)(6486002)(66476007)(1076003)(16526019)(86362001)(6916009)(66946007)(2616005)(956004)(186003)(5660300002)(36756003)(478600001)(316002)(52116002)(7696005)(8676002)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OjKBuoz6mw9V7xXNbIyAAq6kliP3HklEhLJihtp2XTxCXHBbDepBt1k9HME5?=
 =?us-ascii?Q?1vOcfkwXYeq9upO1SDY9cKdoRjR3VLwl+whPVSS33xVTawCmrKwbo0w0XHbp?=
 =?us-ascii?Q?AgQepM6H9OR98aK7GJh0ajLSmNwcI/Emcb/uCierkgF0HZjrCOE7EAIxUJfj?=
 =?us-ascii?Q?xYgh3j8xB7nerimyqgazHLv5x4wKK9iEsje+s5jvNOmFEdRkg8WP1xQuiBQQ?=
 =?us-ascii?Q?3jWzgoglqwCmmHpkdDnT/guV4Q3ehxWfOHyQLYAZGl/39+RRjsQNtStk5aLo?=
 =?us-ascii?Q?HJ1BUrq6XB1CiZHqyQpnqAGwPWxHAv/vYp3F5RLCZt6BtCTY8cPSbwTI0Crk?=
 =?us-ascii?Q?SO3/3BCdT9ac3B7Qe1ldHuh7WTp9j5woElm1HKJZEryzG9tSMwfdNUgjITFl?=
 =?us-ascii?Q?EaaZM5mMgUWkstEaby0DsnTjZItMqc6tnFpOVAVx4ZJxdUBnBhsvfMKIn2xK?=
 =?us-ascii?Q?ko0TIREnv7ph8gIIedRSnu1xEhbLafB5eLR60HWMdHZZy1b36FiIj2jSA6tJ?=
 =?us-ascii?Q?Y/wRzj/Yb8blUwrBevpLccIojrayjt8C9776GOfUqpFN8vcXAFRNy+7Utycb?=
 =?us-ascii?Q?WkCs32YDTyn1pbE6FvdXwnBVi6ruPLt/KuON3xerrb1MceDOaVej0/MAKeo4?=
 =?us-ascii?Q?dCrLgvN4nZ4se1qeqD/Sng42mKzOF2zbs887AZzJ4OOqS5lBzalE541J3s2V?=
 =?us-ascii?Q?j8XdPrnmaU0+goWMdU5WaLs50P8U36zwiODfb3VSq38p7P9W1W5sI6XfauKI?=
 =?us-ascii?Q?jzaURm1cscUZTjfnEoy64h56g/Uov9PNFKCwfmV8GUmYjgdug5jle+rnbO3M?=
 =?us-ascii?Q?u3AMgTwfzPXIpJhP5TFwRk/bN/GeNA9RaJeX4aEQb4EMDRmXTtEQb3ThWS1w?=
 =?us-ascii?Q?tJzYJ6eVirYnnXkq0UVThiDgxI0yw21r2bBtVYS5IMGmv8NJfpD09A7CnHzb?=
 =?us-ascii?Q?TqJ5xvBTTfvWdVK6hiz+1bLc3gn8sYWTxbUk9kMbBua93+4e2hl9hX3k4HCV?=
 =?us-ascii?Q?k53v/2AZIu5aBByWJEzvhwuEbrYe8AHtGr5th8AaYbpdg8cqA083Rw0ZOUiM?=
 =?us-ascii?Q?r/Pw3nixPtgYW2phNCIOdL5McvYC/UFUnwxp043ZLb3htC2zyhIF4e1Smxqk?=
 =?us-ascii?Q?kML3O4cpQz1AUrtz7kLprJ0n4UJCifgRXIWIcDDNgD16n9tOHfSFbnY8UslK?=
 =?us-ascii?Q?IbdfPY6z/cVhxDxREEaE2Jk1D/Exe5wvYKhTPpOoPPIHqfVRYj4MYDJkY2ip?=
 =?us-ascii?Q?QVeu/oL2eWPMGE0a6iJk6G8tQktyQl3ggDb5e35Y22UYAdHg2CQ9knNclJsz?=
 =?us-ascii?Q?EByg0dkx6lV3K6uIgA24RaMa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84670962-b579-4e95-692f-08d9118a9e8f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:02:11.5072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZQWoUmA9L64rbb5P5wSJKe/z2W2Cf/rzzZC8ydQIJnZjF+83V139gDLYxuwbF8CRfmhMt4r7Iyijw1N1NcK9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1620
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Move code to makes a gap for the CS ID into a separate helper function.
The exact bits to use vary based on interleaving mode. New interleaving
modes in future DF versions will be added as new cases.

Also, introduce a helper function that does the bit manipulation to make
the gap.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 43 ++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 8f4838a3d509..ba365901e39d 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -860,6 +860,38 @@ static void get_intlv_num_sockets(struct addr_ctx *ctx)
 	ctx->intlv_num_sockets = (ctx->reg_limit_addr >> 8) & 0x1;
 }
 
+static void expand_bits(u8 start_bit, u8 num_bits, u64 *value)
+{
+	u64 temp1, temp2;
+
+	if (start_bit == 0) {
+		*value <<= num_bits;
+		return;
+	}
+
+	temp1 = *value & GENMASK_ULL(start_bit - 1, 0);
+	temp2 = (*value & GENMASK_ULL(63, start_bit)) << num_bits;
+	*value = temp1 | temp2;
+}
+
+static void make_space_for_cs_id(struct addr_ctx *ctx)
+{
+	u8 num_intlv_bits;
+
+	switch (ctx->intlv_mode) {
+	case NOHASH_2CH:
+	case DF2_HASH_2CH:
+		num_intlv_bits = ctx->intlv_num_chan;
+		num_intlv_bits += ctx->intlv_num_dies;
+		num_intlv_bits += ctx->intlv_num_sockets;
+		expand_bits(ctx->intlv_addr_bit, num_intlv_bits, &ctx->ret_addr);
+		break;
+	default:
+		/* Valid interleaving modes where checked earlier. */
+		break;
+	}
+}
+
 static int denormalize_addr(struct addr_ctx *ctx)
 {
 	u32 tmp;
@@ -878,13 +910,11 @@ static int denormalize_addr(struct addr_ctx *ctx)
 	get_intlv_num_dies(ctx);
 	get_intlv_num_sockets(ctx);
 
-	num_intlv_bits = ctx->intlv_num_chan;
-	num_intlv_bits += ctx->intlv_num_dies;
-	num_intlv_bits += ctx->intlv_num_sockets;
+	make_space_for_cs_id(ctx);
 
 	if (num_intlv_bits > 0) {
-		u64 temp_addr_x, temp_addr_i, temp_addr_y;
 		u8 die_id_bit, sock_id_bit, cs_fabric_id;
+		u64 temp_addr_i;
 
 		/*
 		 * Read FabricBlockInstanceInformation3_CS[BlockFabricID].
@@ -939,11 +969,8 @@ static int denormalize_addr(struct addr_ctx *ctx)
 		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
 		 * there are (where "I" starts).
 		 */
-		temp_addr_y = ctx->ret_addr & GENMASK_ULL(ctx->intlv_addr_bit - 1, 0);
 		temp_addr_i = (ctx->cs_id << ctx->intlv_addr_bit);
-		temp_addr_x = (ctx->ret_addr & GENMASK_ULL(63, ctx->intlv_addr_bit))
-			       << num_intlv_bits;
-		ctx->ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
+		ctx->ret_addr |= temp_addr_i;
 	}
 
 	return 0;
-- 
2.25.1

