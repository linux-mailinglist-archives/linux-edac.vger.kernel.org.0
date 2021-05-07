Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405BA376A51
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 21:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhEGTDN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 15:03:13 -0400
Received: from mail-dm6nam12on2089.outbound.protection.outlook.com ([40.107.243.89]:47105
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229818AbhEGTDH (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 May 2021 15:03:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9Sbf6jAaiUiOE82a/82d91s3XIWfNp5q1ge7Kro7D0k5YTan4rEvqFi+roQNhF4ABCqw4YWB3AzuPNJuzDGvpf87B8zIK+/gpP2pcZ6cNQfSkIJOZ/EZ+NM+S1SUw785S38OgwIDis89KFC6en2l92yC/c/Ho9WfOedOq8SET09PKJYGRZW+UFOk6TBOTTJhJrI9IXI3jrOA9Vg6uV1iFofKuZuXjFukedFqRrR3mfa4WXhGmoUtLbaUuQiJi2q9GsfkdwFs1Kj7s0M2TMpPMZ/XXvILx/eTVKnhKAmsTTowyzlXs8kyArGmErcFvXRYHi0EKslm6BSf1QVGWmWGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZB2s80KBFN02J8BCyRiDOh/O0Q/NCu1dcUe8gre+ztQ=;
 b=em0L6yq9TbHiB0oVVu3Tg142we9stiWDnFXExs4LgsC5voJwK57+o7ml0wDpO925I+Y9JEuvSnJVYEDN1dKXXxnIw1NeKSUw23DeOh+pcSL9Qfe9J9gUu6RisZd5HrcR7oQL2EIhhwKwNwt92AlXEy+hOq4q1qIUDTGSNuT+nZFg1o+QMIb84igsTttsffpHo8P7jfmke+yebNsWuhv97BDRFuTO3CAd8vPE7dfB8oZeW48ksJJ+YWePep2C7Zg7122Xrr237WC0OjzkWlm6jC32vA4vZuBJir+S8AeQgpliXa6VnY4UbBapQ3015x39ESbM1hADguW+zmQJV8DhfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZB2s80KBFN02J8BCyRiDOh/O0Q/NCu1dcUe8gre+ztQ=;
 b=cWIVjoUgC1ihaM+SyAEVceyPeGThXrne8Eg6AHFlVkd1DRDXBVsD+zFB/+Ey1K7t2ax1ClwTWbQpDJqvsLGiItWYynIoHfMqc3up9Ch89KTtjiIZmWma9Ec3WMtdbfr07fgmgv+PxBy0bGdBajhV4BObDo7/2LtXD5IdIiyugiA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1620.namprd12.prod.outlook.com (2603:10b6:405:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 7 May
 2021 19:02:05 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:02:05 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 12/25] x86/MCE/AMD: Define function to get Interleave Address Bit
Date:   Fri,  7 May 2021 15:01:27 -0400
Message-Id: <20210507190140.18854-13-Yazen.Ghannam@amd.com>
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
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:404:8e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.3 via Frontend Transport; Fri, 7 May 2021 19:02:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad108510-b783-48a5-b636-08d9118a9ad1
X-MS-TrafficTypeDiagnostic: BN6PR12MB1620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB162006FAF18E6CF8C21F935CF8579@BN6PR12MB1620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i2i1BZ7qgJIwMwVE93x+MOhdhwIom1S3MEjW6NbmvxVPFmZLS5ypOYs/5iom1Mlf2IkwwauXnJChjJCyFZ8TXlFrWyLxQwgMZc82zuHM+g9T/o7Z09CwAwOEWJ6FWFq1zxN5vxRYMgxBNEgyEEYwLjL23+t+ah5C/c+KE2zwowtnySjOuLjfNTiOQHRSQb5uphaM0jvzcdnRGCSO+ovuM8AA748RIdfPZhhwdMxt5/t7L5Kr68xLSG1A8DIQ8IsUmsXqJEdgXdlYG8RBPuWGDCOUsRnzv/mIaIfht8GhUCgGDRgmiYD7aCOPfMoOaQeyVUxvu2/kGAqWoWzInAi10QbfvMhAN+ftyrNNmQsefRVo4MyeGqkqeVwAEOzDFnxs8Bfh7RYEZflqIpuJFzoxkC5Kwn3gW62KtQECiNebFRmInr/3tpjy5wuuoGHOEQYeGUn4RBFTzR8Qel7qLY34PeLbs9WjAXY8B+oZyLXnsqWnfpedwR+NXyAXhs5++8rkWVkYuwJ71abnkNhoMTfqkz3vJ2LmPWT+FbqkAyw8cEZTaq6bZj3RLEPQgFKo00czZbsWdg0KMkvth1s0Au7nsscR7k2ba4ktOsLCcfWq3SKW81v+L9E+xfLiAvmKsmWrePfvGt0yQDr+le4MqAh82g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(4326008)(6666004)(38350700002)(38100700002)(66556008)(2906002)(26005)(6486002)(66476007)(1076003)(16526019)(86362001)(6916009)(66946007)(2616005)(956004)(186003)(5660300002)(36756003)(478600001)(316002)(52116002)(7696005)(8676002)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?a+9RGA2vWF6T0WPnn05p6xxS6MRQa7ch1wjN6o0v1Cllyhk/X/fIRw7FgG4k?=
 =?us-ascii?Q?HiYqqfdwuNfQlmH6k3Wyf4/XkwS5YSfbk38+ae6EMXMGyQI1/RVfsgsYLROn?=
 =?us-ascii?Q?hCOw1f8rZLdXnFoDcer4HnlxuFh4bkouM1F6Beh2U1wULjkA2vTKgiTzEKzv?=
 =?us-ascii?Q?SN999qg/f9ohbJfziSOKVB2Wo3pJ+snZ3Hax8YJ1Vuez+gylQ4DlQK83CqnC?=
 =?us-ascii?Q?cJTOZtrg90AGR6pufuMZ8zrquTTkQwMP+xssQgKT7yZrro9tGAJjbR5YwwGl?=
 =?us-ascii?Q?RC23vDDCakBJnLIyJf5KPMBB9fKcfz2o5b7Hu/VnkNP5D8fQ38Z8HLVJmcij?=
 =?us-ascii?Q?2jVQ1LLxsP4M977RpqQM6RBUP+O4iiQemI8mfvMUpdLZirRJGE0yGnvBhg3f?=
 =?us-ascii?Q?VHtGFUapuGY1na0KZABeKLbmSyKztuQOeGAU750kv9zi4oia2cCTChv5zvsK?=
 =?us-ascii?Q?3GacMUyxpkR6VifP7i3gpXBp51LqL/IxO0o0nq4lWa58UCVfeFwBi38Kl67o?=
 =?us-ascii?Q?6R8HeO3hjuF5RJYpThfU2T1K0Bgv/maVzXXbZYIMYNeWHJB/S1ie/sxsOKAi?=
 =?us-ascii?Q?zYm7zbymFBahpBIGLZttZG0St+di9MKYoukeysKRd7kUhvAAKp2/AJn45qw+?=
 =?us-ascii?Q?XgPX/QbVKQkJ7e6EYTVGHCgPY1F2A8F8q6ac0x3tV03hGGKMesE7VQFjEPCK?=
 =?us-ascii?Q?bYaBjUq6q8UbN+OUE0EJZdnw2wYOVnkuME9VRP1etydJV1SWyD/688ezSSkJ?=
 =?us-ascii?Q?fW/aX8VrWmEd1TgdpD8emmrEcNeYmJ/pdfY0kFKbUpq0h/fTDimzBHmTrxQ7?=
 =?us-ascii?Q?0b54D37HmfjYJT/NEOQ4GjxR6Z5x4yGbErCug9I6XtJzKwBcxMs1YVNPuG5s?=
 =?us-ascii?Q?3TBdNN6Pw+vh6GzbmEZ7zIu0I7KZ6OiYQBC0xKg4t2OReiw4D9S5LaHDnhKs?=
 =?us-ascii?Q?y81yb73LHAEgoilyRT9/IDx1Keyo4CaAd1LS+LSQN4PbJeKp1LmJ1koTF9GU?=
 =?us-ascii?Q?eWaLpOm9e4Rjpp5RkEaFivHiXTrFaUhUs5kZMsEC4G3YDPcJnq9iOpJRZ/dw?=
 =?us-ascii?Q?7H/htLwscY2HOJNfcaGBUX6pxhFOs+gB/VYyZGvcHmyd9WPKZNCW+USFdDyS?=
 =?us-ascii?Q?6B2GWR8T9z4hn3cnRIdUCRT+OwB3tveTXC1oAyS+6pLRRsgcJfb/O+wCpfq4?=
 =?us-ascii?Q?g3Esr8OTSDs3Pk/hpGN/q8AMksjxC2SaW+RZHly09yPG++Vu5eWJNGkLps0t?=
 =?us-ascii?Q?yz/sSHCJwo8sYItOiOcnGsBr83QtrgshUA0DyICKglBwQLMAaa4zbNFS5ZRR?=
 =?us-ascii?Q?pQSAOFb/Zh8Zt+v88hApTw+H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad108510-b783-48a5-b636-08d9118a9ad1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:02:05.2558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tA5xJZApiM/Usd0S5deofKbvDO7YrIxT6pPtk0DksYgv0ZL20nyx5vRul5N7GdhpvyeUjlxBuGACJ/J24vsvJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1620
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Move code to find the interleave address bit into a separate helper
function.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 58899c57eb76..a60d9d275d14 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -814,14 +814,9 @@ static int get_dram_addr_map(struct addr_ctx *ctx)
 	return 0;
 }
 
-static int denormalize_addr(struct addr_ctx *ctx)
+static int get_intlv_addr_bit(struct addr_ctx *ctx)
 {
-	u32 tmp;
-
-	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
-	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
 	u8 intlv_addr_sel = (ctx->reg_base_addr >> 8) & 0x7;
-	u8 num_intlv_bits, cs_mask = 0;
 
 	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
 	if (intlv_addr_sel > 3) {
@@ -830,11 +825,25 @@ static int denormalize_addr(struct addr_ctx *ctx)
 		return -EINVAL;
 	}
 
+	ctx->intlv_addr_bit = intlv_addr_sel + 8;
+
+	return 0;
+}
+
+static int denormalize_addr(struct addr_ctx *ctx)
+{
+	u32 tmp;
+
+	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
+	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
+	u8 num_intlv_bits, cs_mask = 0;
+
+	if (get_intlv_addr_bit(ctx))
+		return -EINVAL;
+
 	intlv_num_sockets = (ctx->reg_limit_addr >> 8) & 0x1;
 	intlv_num_dies	  = (ctx->reg_limit_addr >> 10) & 0x3;
 
-	ctx->intlv_addr_bit = intlv_addr_sel + 8;
-
 	/* Re-use intlv_num_chan by setting it equal to log2(#channels) */
 	switch (intlv_num_chan) {
 	case 0:	intlv_num_chan = 0; break;
-- 
2.25.1

