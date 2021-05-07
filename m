Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D81376A6C
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 21:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhEGTEn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 15:04:43 -0400
Received: from mail-dm6nam12on2089.outbound.protection.outlook.com ([40.107.243.89]:47105
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229849AbhEGTE0 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 May 2021 15:04:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJnpN1FFjSqhU1ngl/4Fp2TYoRhHKsEW11PqyBmDGLfEIK0OHz/mR8vuWry7IzUqV4JUFrNpm7vKrqqPn2BfE6YdsTaBtJ6iLYRZWIsLJhe2So9rgzmqWAHSh8jtq3JM4cnE9lmOIQNu1NBzja+v7kMksGdW+Mw3n31YdMt+dYl2qsbLBP0xutU26kLBENg4vpNiMIl88kk2P88v4Pi70kmur+cZDhx/XZ2C8pxCkdG9+YKdRMv1oCHeJyDjpH9I60x/YJVonHxhSR0k9Z/Arr+sBMjdBBtW58JI70YdMGoR0BRIKssOLvKph2R5js9ARiX1OI5alhdpj7Bf4aJcsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SUbsP7o2wseT1VUxSla838EqAdslD/W+UlDB1HZ3tw=;
 b=YH6AMGOTvp4Kc6riXnKUEU8K6IYlLOyftBotEeGL50tcx79W/ab/9/yA8HEcXGImuNuwaPN0E0X3mnHU4GXXOgT2gb/suPr8qq1TNs0WmEj4HglKBHCI6Yci2yIxCwV9iuXq1Jrst6vn4P9TiYJTEmaTW7Ae1fdomh2D7mHSi87e5tpSyaRv7lg5iXyEnhreKFJ6gIv8tQglU2rrFMZlHXcOMdScUjnSdK8A0Z3G7+IMZ/bz1HZCslG7tLbPMvYMtrzL6V//g+VT6b6tjnAxX1hC3X1vMMiEJOQpJJIM356wa9JuJJVI//MAlZ7zwXeur871fuMl8nj+zay7QknpBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SUbsP7o2wseT1VUxSla838EqAdslD/W+UlDB1HZ3tw=;
 b=OmQDEtxzh8BZlnJAJ57TeaVGaxxqwVJ0D0sY0Rtg49NRfYMwfoJ0G8/i1dq/s4StMQfDfrCcHC7bJV796UfA3aWS/GSNuUCUI0qtuitvR9tG+IHdjU60BX/7lrilgdFkd/SAATTTF8Mmb45zvVC5MWlDxGNbdMfOVP4lbfofRnM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1620.namprd12.prod.outlook.com (2603:10b6:405:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 7 May
 2021 19:02:17 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:02:17 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 23/25] x86/MCE/AMD: Update CS ID calculation to match reference code
Date:   Fri,  7 May 2021 15:01:38 -0400
Message-Id: <20210507190140.18854-24-Yazen.Ghannam@amd.com>
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
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:404:8e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.3 via Frontend Transport; Fri, 7 May 2021 19:02:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50b3d0f7-1bab-4d51-73e0-08d9118aa203
X-MS-TrafficTypeDiagnostic: BN6PR12MB1620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB16202FCB84DC56B7137BAF46F8579@BN6PR12MB1620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6qorhvsTH+buX0JLuFI9AzWGiOrrPh1yeXPuCObST9jEO1KQPShHleH+nF6MstnqwFiWIl6p93kMr2qb4OAIMFDlo40n1r6Sd5ycsNPWKmYFnT2mL11a4YpcGUzeSqHvVFfs1odHar7ngXeGZp1WLbU6zbJBv17XmsUYpkgNJx/wiWGb+aPu5u6e6VjpBrm1kUaoCStMe5JrlyG89XeU62xdOLyUDxn99W3Da6Jswkf0B8p1LU9i/C1x3R1sMxSXj7irkdJnV5nWL2s1VJ1Eu9TAwncMX003iELXFIBzTmSVUnGlzCe+xnwp1ZgH0mTVKHEWMQoI6tcNiOTW2d7eSKvNg9bhV0eni9WZPb7vSMuDaVJhyrAo3bRBbEclo6JqXe0tNA2K23lbxvrQPG36VHiY3vZVemQWnObpqr3tU20e/EnG4lzNtt/A8d1eTEIyY5kmlvR4naA8XoAxE6r+FAWqMocBgBwq16K1GrovPl/iQf8YTFJufBIjL9EqC+Ke/5AliY2334IbOKYd5EiUPEdVq6cE9WF56xEMnQqod+d+VWmgXUZ7UTHxYoJwp2fuIMv4q8SGwhsjJMsMIDqt8vXQCw6nCZ+Rdqgpap2FIr47f4eWCwCQ68f6aBPHTZO4nENjabo+BvFKDwi0BcDjINTqK71e/2NGBxhonPUkXJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(4326008)(6666004)(38350700002)(38100700002)(66556008)(2906002)(26005)(6486002)(66476007)(1076003)(16526019)(86362001)(6916009)(66946007)(2616005)(956004)(186003)(5660300002)(36756003)(478600001)(316002)(52116002)(7696005)(8676002)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VhMojpdyTxIP8hJ1gX8l0wnfy0rtHDs/KhFkOjNBYcrhMpDVpSJplXiwImW1?=
 =?us-ascii?Q?7TfGNuhQjSpq3oEIXkl0WlzcTkqOMDzMpadXoPlpgjeoscoFy/s22wf311xe?=
 =?us-ascii?Q?DfsBiZYRUFsQMNGeL3XV47VdPKssIAjQfGTR74yAB87ES97HurWXPoc6cgyu?=
 =?us-ascii?Q?AG/9y7yeFJUn8pyweb3EcJyl8i2O5LItr+VIMBzCHdtHOpMv7U4ShgWnm/mK?=
 =?us-ascii?Q?0OmV7K5D6qeV7NkuaMRkIpKJ98tgwXQC5RPhzPe6fGsC4zZdkqtBAEcP5v32?=
 =?us-ascii?Q?5Hv4d5ked8Z1MPzvO4Sj47c0ZYwsTdHOlH4QtFreHi22p9qaIPpDdoUKWyjB?=
 =?us-ascii?Q?nXgO+sgxXILG1RajcEj4em5nqDVIvHlQQiJdsTcDJCGObOgtUCVq8v93l8zn?=
 =?us-ascii?Q?P+35q+fi3n1Cj7sQ/e6pawpLrOnt8CAP927Xd4Z1JqzXtfgscr92HcgDiA5z?=
 =?us-ascii?Q?r78GKMAJh39mfdt2HXWNCNkLdXD4Aeh6wzcGhoqAU21nVlvbDOQVkj7PbPxT?=
 =?us-ascii?Q?8y4IlpOLu/mHnUV66oMAdiE56rQG1N7406clqU0sMr3tlq1e6n38i9x8/0ph?=
 =?us-ascii?Q?VBOrOeWo5LnScsF3FYuEjesnaqdb6uVAppSyZBWCyQ0nUZD9+PdjAYRO1u8S?=
 =?us-ascii?Q?nTfXhjA9mThoXjr8wM6gHW3rpfV6cb+PsEQDi2FrjC1TA/mUEtBfSV9j3z9D?=
 =?us-ascii?Q?6baz32PrM7hSy22pgXylSXkMw7DbyRLixK9MmUFcd85L0/w5IrWbLwiMvcls?=
 =?us-ascii?Q?15hWLp641DdyaVkEe2kTlqJy/jd6nKn5VxI8cjPKBhbv63hMWibvz+PGz/rY?=
 =?us-ascii?Q?WGL0hn4g3zs/fyJhQ0ZvK7+boGFYO0l5tCaGujAA1qTKHlJHVH+qrH9guA5H?=
 =?us-ascii?Q?5xRAYXCh8PDV93GyqycS07hTkSA0Q+Y112pEt6E/sYE5ynWFjstqzSIIiwCh?=
 =?us-ascii?Q?/DjEnwFOvHfPJhAQYwXbw/+2khsr1DYtXCqMUaHfzshgEqg4f3zdVU0rVH5n?=
 =?us-ascii?Q?1OcE6dJsCiQxOr0Pzt9TT8ydtIowfUC8ghuWxi/TyTyoVnNBCkp6HO8DRaWn?=
 =?us-ascii?Q?pFZkb3nZnFEfzksr7zEQidgUtx6NbustYy83c8CCCt83lk/HTYzUcICxmHra?=
 =?us-ascii?Q?INGY1lInwlLTP7TMYZgoZV1CRC2XhOBpwgmpoD0JLNZLwzr0KIQVCUIB456v?=
 =?us-ascii?Q?ww41p7GuD7/VIaXA40nkqdtuU7O2Y0Rhj2gY3EuacwG+epToMGsRPJKtiS+u?=
 =?us-ascii?Q?A1TNCq29veKk3pZEJMOWQgtxo5cVEKB72he08Z+mujI/Fql+SUiBMBqkiC/6?=
 =?us-ascii?Q?u4ePrL0FRKfpnAdvvsGN1ahU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b3d0f7-1bab-4d51-73e0-08d9118aa203
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:02:17.2869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhEV5wLKLOaqxyLc5Ove0GWiNo3M/cpQOC8f9K4E6c++Zi7pQyX57xY0X/vkC9xYsAJsNN6g6kNAnlE2eK4UdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1620
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Redo the current CS ID calculations to match the reference code. Helper
functions are introduced that will be expanded for future DF versions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 50 ++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 01931f98c6d9..3340f8326681 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -924,45 +924,57 @@ static u8 get_socket_id_shift(struct addr_ctx *ctx)
 	return (ctx->reg_fab_id_mask0 >> 28) & 0xF;
 }
 
+static u8 get_dst_fabric_id(struct addr_ctx *ctx)
+{
+	return ctx->reg_limit_addr & 0xFF;
+}
+
+static u8 get_component_id_mask(struct addr_ctx *ctx)
+{
+	return (~(ctx->socket_id_mask | ctx->die_id_mask)) & 0xFF;
+}
+
+static u8 calc_level_bits(u8 id, u8 level_mask, u8 shift, u8 mask, u8 num_bits)
+{
+	return (((id & level_mask) >> shift) & mask) << num_bits;
+}
+
 static int calculate_cs_id(struct addr_ctx *ctx)
 {
-	u8 die_id_bit, sock_id_bit, cs_mask = 0;
+	u8 mask, num_intlv_bits = ctx->intlv_num_chan;
+	u8 dst_fabric_id = get_dst_fabric_id(ctx);
 
 	if (get_cs_fabric_id(ctx))
 		return -EINVAL;
 
 	get_masks(ctx);
 
-	die_id_bit   = 0;
+	mask = get_component_id_mask(ctx);
+	ctx->cs_id = (ctx->cs_fabric_id & mask) - (dst_fabric_id & mask);
 
-	/* If interleaved over more than 1 channel: */
-	if (ctx->intlv_num_chan) {
-		die_id_bit = ctx->intlv_num_chan;
-		cs_mask	   = (1 << die_id_bit) - 1;
-		ctx->cs_id = ctx->cs_fabric_id & cs_mask;
-	}
-
-	/* Return early if no die interleaving and no socket interleaving. */
-	if (!(ctx->intlv_num_dies || ctx->intlv_num_sockets))
-		return 0;
-
-	sock_id_bit = die_id_bit;
+	mask = (1 << num_intlv_bits) - 1;
+	ctx->cs_id &= mask;
 
 	/* If interleaved over more than 1 die: */
 	if (ctx->intlv_num_dies) {
 		u8 die_id_shift = get_die_id_shift(ctx);
 
-		sock_id_bit  = die_id_bit + ctx->intlv_num_dies;
-		ctx->cs_id |= ((ctx->cs_fabric_id & ctx->die_id_mask)
-				>> die_id_shift) << die_id_bit;
+		mask = (1 << ctx->intlv_num_dies) - 1;
+
+		ctx->cs_id |= calc_level_bits(ctx->cs_fabric_id, ctx->die_id_mask,
+					      die_id_shift, mask, num_intlv_bits);
+
+		num_intlv_bits += ctx->intlv_num_dies;
 	}
 
 	/* If interleaved over more than 1 socket: */
 	if (ctx->intlv_num_sockets) {
 		u8 socket_id_shift = get_socket_id_shift(ctx);
 
-		ctx->cs_id |= ((ctx->cs_fabric_id & ctx->socket_id_mask)
-				>> socket_id_shift) << sock_id_bit;
+		mask = (1 << ctx->intlv_num_sockets) - 1;
+
+		ctx->cs_id |= calc_level_bits(ctx->cs_fabric_id, ctx->socket_id_mask,
+					      socket_id_shift, mask, num_intlv_bits);
 	}
 
 	return 0;
-- 
2.25.1

