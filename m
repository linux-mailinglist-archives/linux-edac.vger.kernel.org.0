Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4F13B2108
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhFWTXi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:23:38 -0400
Received: from mail-dm6nam12on2061.outbound.protection.outlook.com ([40.107.243.61]:4705
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230092AbhFWTXW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:23:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWu1LxmqCwXPrbzKhchCDZdOa1aCs1QTYnSY90cOXHdruluXrc0m1my3SYd8wcg8+ickJUllPjkE7pjGANZDlE8+u1UM6z0zR8cyD9O06D3tY/gMKj/80K9G0gJR1fvflLvtwdt5IoAjcfNaAk89Z2GlrL25wK5YyHtJ2VH7lmBvjU7l4sFsMzFd2VwJ8hir0tdjq0GDUGplXgGwGVlz+QDWT0euOPn8YsZSQq6l5B/IScH6GruwOLa7qJXwK6Wv4ZgSl9tnAJi94mzAy27+r+nceITksxPTPREePp7yjJ8qayIBX/XALatyMvgiK4pZbsc73SczTQwZHuqZUVcx9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpS5Opxm/sE2nDC/VU61+rCW0h3NbvnowC7IyOiTTpo=;
 b=AMGAkRcc60E+GgTaiOs29yKhy014MNHk5g07TlbZ4kt+x1ypWr1TqO0VF44GGdO/LsFVn6bpdhBoN/8lrIuopKl/e5tu3JH6uTptil6LPcAHVeG5fQsJhR5IfoB9RBPPP1rwvMJ09mqX/O/Fg/0Hue8etGobAQdP1aFYJLpl4oNxyFtbZj+SI00seUInDrdlRxL7jxRJV3D8HO5BnIlXShG5VNl2dMBJ3mdmGtNHiwajYX+JOx+LVQNG4IRkcTgE6M0Ydd8o1Lx69jx9jzvubsSJsYqexG6G3TMhNeRNJJP26owP0b7LtaAdmR+0sVw8yK4R8kP5JT1TPuFxEWhg2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpS5Opxm/sE2nDC/VU61+rCW0h3NbvnowC7IyOiTTpo=;
 b=oY3SAXaeZURMrPNASCcjFtEX+FOn277uC9dXR2UJqvaSwuuUKSR9LvzUZ6jHVytOIr43XOsSs6AryxQh85ZN5pm2iyw1EnQQBTj+zxVdt2zdZM7dyzDZj/I45loeusXxaDduumD0wbXpyizmk0yNhKVaaRGmFkaQ7eB5+eqK/7I=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN7PR12MB2740.namprd12.prod.outlook.com (2603:10b6:408:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 19:20:53 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:20:53 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 17/31] EDAC/amd64: Skip denormalization if no interleaving
Date:   Wed, 23 Jun 2021 19:19:48 +0000
Message-Id: <20210623192002.3671647-18-yazen.ghannam@amd.com>
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
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:20:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da94eb55-2fd0-4313-6c26-08d9367c049e
X-MS-TrafficTypeDiagnostic: BN7PR12MB2740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2740F91DF563E5CD7468EE95F8089@BN7PR12MB2740.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TW2ieZELpaymjyd1A19fo+37x4bYhm1qzNO3tuqcMxiJAkxlN3iAswnpwTr7UCMoSEsMm7A3S4Bzs/y0sCQxKDg+qzqKQWmXW9air8ONyFHg8LW5bSKLr2nYxED8snVYg7wn8B9voCFlg6s68WAvpDgsaQesDMljWvDMXa6DVRtBCIIXy4pEmqJ3gZxvtrvcGI+sfwQRi+Px8MSqJbMUh6VvXToMtCtFKuv3GUJkgM7EWpWUebShY7zjr7CVAfLp9SnfXHf7KJL0L05bT4IJaNHCuR70hIsXqf4bmNxzNmaop/c+CCLHqUBuPBLkSatIhrQJmdBEbMnZwim0YTRoTiEoEKXZ2ESifLxqWYJj9TLZKbSMDZi9sAMKUid/YFjvi3alZW7hKP9ZburoPtRSR/C0rXU4qxhzOblLuLjeWlCJGzYqkFWn/jhu00UoNl8sTTSQAg1Wy4VXTgXlpjNhizmYO4A2jyIxV97oKY5dsiKNTxkRotUWgjSo7gLxOT28mdZyzJYo/jJHkRTLiHwfSsaeWYgdr7rZyGfJ51zqJIK5RYcgGHXh79XkEsef2Ko10oRif88lgfa7zC8kqpVxNlhxMdhtYXiEkOK0uQhUHA+tauK9QOw73NOdBv6/gXDnQsMWcMvJOOaqRa57YqJYm5LU4FOD7gWozVDzVQHN63fu8BTVxq3TyPA3TEI2HkXhSVbeKnzXDUH2BnaC+9o7cy8NhcsTUjBwERnImKI8rzlz24OyJld+ppJQDxikn5zAIsO11monPeArJ0zNHIZHTHsPW0fAj8KBaRkQ74ijYIfACxjxbyeq4mkIc4NI0p+xQg2e9hVWC/+UZM9/sMPqgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(5660300002)(6666004)(2906002)(966005)(6486002)(66556008)(66476007)(186003)(26005)(16526019)(86362001)(7696005)(478600001)(52116002)(38100700002)(2616005)(956004)(4744005)(44832011)(316002)(36756003)(6916009)(1076003)(8936002)(8676002)(66946007)(4326008)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RWYqIBmnNd+YgMRxycVJ7gvUheR08rq/bxcF3c+LJmuKtewxia04Q+zPrYCF?=
 =?us-ascii?Q?5UxVcG5vUR9n3+GsgDqwUaba3Kxl+geWgSnsj27gKyX+Jzd1RRLjuLVvDxNc?=
 =?us-ascii?Q?QUnSCl8ntEAx0YfxDgpNRD/xo/DolEY8rJdv4dHE0gDDELkQxnRhso7Ram5X?=
 =?us-ascii?Q?fnkoKmBn9hWpDNK+QYWOZoEv6s1LZvn66419JmHUqE2SK0KO10c/ckrDQciB?=
 =?us-ascii?Q?0oZsT1AHXrFKQ1UfE9J3CkEhOuc6nIRt5tAfkEx2XtO4OrZAWi1OzW1ptqTR?=
 =?us-ascii?Q?3GRuNO46nZnq51ZYk9RSlgHY25CbxNkrc441arjAo7XRJTobNmCfy3PihxbT?=
 =?us-ascii?Q?MG5KQiBwz4mMa85NRALaP3Slxs5lLArU6QLWREiv2pWv2ZgXmOAsc+MB1Edx?=
 =?us-ascii?Q?9acQ0++3WKulCwkmrHlBCFvQDZMsVP37XcSfkupGdfecW4ik/CSGwlB6Qqj6?=
 =?us-ascii?Q?E0RJUz2O4pk0u6i3r2EXA2ILWQi/cB7L1lxKGhVLWKEe/XtFTgzzLdAeqw6C?=
 =?us-ascii?Q?GYWKInGGWKC3oUE/OAq69SOU5TLhZG+kKkCxUr8n6+xfL7CEftZDPGrmEG+K?=
 =?us-ascii?Q?HYJ6TWVn2Z8Y9saRAD+taOYxQZ772kyqNu+ZD2S5Uj53tSFL75XpYcQnJAoE?=
 =?us-ascii?Q?ExsmrcoQ7xWTcDJ4FIUY/vAqAzMUBCLLjvWGJzzKnLTJAmIK15EFsfm8FSEX?=
 =?us-ascii?Q?xm88cjPFsgBjn5n7ky7nmF1GI7gaBAsdPPIUYB5JS1XwuxIMlVeptYK3qJBi?=
 =?us-ascii?Q?OLQmTFw+YI8wJqzA0Ty1B/DeorefPWbOKmSdB5uKUDNBoDoHiZpzwokRdB8r?=
 =?us-ascii?Q?UQYbZxSsYSlilx2831l1A61kUXXI6iJ/rzPxvcjCTpLp4MXG1FCSnGsqc+Io?=
 =?us-ascii?Q?DWNh59e+RAOVKEONU91RTQNCsr8wnb64DYs9LJJ/REMjAqtjgqM2Hp09OHNz?=
 =?us-ascii?Q?JCOyffh04PxFZeP+8c9JteOA79LphVgyaRqWR+CK9RARJTXkaYeCyG9+iMtL?=
 =?us-ascii?Q?x6xjn/AB+GS24JyW4wvHqYEx0J74L91VKWFF4YbtjW+qyUomCD6G9zcs5oP2?=
 =?us-ascii?Q?KJtJkr7VYEdGVASKBfET0lHPKly6oQaAoBSIDUPUuSvHk+IwnymtUYUS4YvD?=
 =?us-ascii?Q?8CJx8+EF+Y9aI3Eqiz0TeMmLYciU5NORTrCWz7FzQqKbeGCYACbuy/QZc/dM?=
 =?us-ascii?Q?JtOGzAOyyx21CuPwC1vKniraaNIZhAHrpIL0EL32BQkzlUYRjqX+4m6xBv7V?=
 =?us-ascii?Q?ODfm/AFI4qlUaPt515o/drEeAUbmJgr9J7Mm+0nJv97Ez62nBpLGxzX1rnCj?=
 =?us-ascii?Q?SUfotmpjjV84fiblzyfl4VR4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da94eb55-2fd0-4313-6c26-08d9367c049e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:20:53.2430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRT/lMEgtgligu4kGNBYa4ftQqD0iHFcImMLYb2OxJ7EjR8Zh7wkvc93dB9rf++CFZW7vUpyBwE58zM0lx/GRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2740
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Denormalization doesn't apply to the "no interleaving" mode, so return
early without error in this case.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210507190140.18854-14-Yazen.Ghannam@amd.com

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 233f8cec4fe8..02dc34c13d65 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1234,6 +1234,10 @@ static int denormalize_addr(struct addr_ctx *ctx)
 	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
 	u8 num_intlv_bits, cs_mask = 0;
 
+	/* Return early if no interleaving. */
+	if (ctx->intlv_mode == NONE)
+		return 0;
+
 	if (get_intlv_addr_bit(ctx))
 		return -EINVAL;
 
-- 
2.25.1

