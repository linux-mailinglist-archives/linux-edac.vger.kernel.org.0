Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9464A3B2120
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhFWTYh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:24:37 -0400
Received: from mail-co1nam11on2042.outbound.protection.outlook.com ([40.107.220.42]:24416
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231264AbhFWTYM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:24:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUl5pxUOzuUhkNoYeraTPO7YvmNb/czTRm2UTwR1czjVLZaSdj9HXH/3JDYR/Pnn6JYGvDWZRFS38fM07YtwsSftUHz22IuE68LCYs9TlDHvS86q/8F8Pw6GD89bdX0pdt9KfsNuugYog3GQ3xbV+sE45k520dduQOXlh6Qkyv9qmbo8IgJLgZsyLptCeUV/lVQKN/WSXw2EinWEz8KcLPmjka5U6Fb5khNXuQok/jAyPtJIlKH1F/YFO298eXT1OhTAtxJoq/8whQnbSgR1bB0Sog3MUXkVjRsofhHnJ0vHb93PaoYWtREWGEo9xpIMvoMYkbwxN+dUDFFAvcemzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZG6S5AsYsoba+BGpDgHOkKaosOuXceYK/FBigAVj1Y=;
 b=BUzteuz6qyZMerJ62XOdyhsJVRN3B98zsarbn8PZovdeFJlfAnbyasPQttPv9YqmnFhK0LllYHmoRajO41easdA9PsensF7rp3eMY9gDF6wVQ6xaWFAbWOU5UBj1IgcPBrE1jaiey4LhpWjo7V1m5KmbeWASFigIYcmKDxX9YiZ/iYqMsz65RUSlsVSflmLkz+WwzvIpQQic+rZyXguKTq1fK9LLatsjMnevZ7JgrI1HQCfWkAgIamn1r+L0p5+NE71CBUOKpmzUZ7q+kRPdy/cGxCpHCPOtdZXXyMVQKmvWluEOBKlxSSltUkgfQmQa09mP3veq0fYWM9ujuQHNFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZG6S5AsYsoba+BGpDgHOkKaosOuXceYK/FBigAVj1Y=;
 b=lNjAU4Aeyo4keDTTi+007ydG5kc6jv+7uPENu41K1T79Ie0Lyyav077HtmeXoF6Bl0G+uBCYLv7wFRAO3SrrBrnj+CJLynQ/5tujQ6Llso0ykWx/n9+uJzDu7XgriHCHdBv4L6N12pOtQ9EtR36faWbG0B/ZYsERNeyZri5LYCA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3218.namprd12.prod.outlook.com (2603:10b6:408:6b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 19:21:03 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:21:03 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 28/31] EDAC/amd64: Match hash function to reference code
Date:   Wed, 23 Jun 2021 19:19:59 +0000
Message-Id: <20210623192002.3671647-29-yazen.ghannam@amd.com>
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
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:21:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc944a60-af92-48e9-7fd7-08d9367c0aa4
X-MS-TrafficTypeDiagnostic: BN8PR12MB3218:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3218D8F8ED6FDFEB60B031CAF8089@BN8PR12MB3218.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KnzdaDkxzO5+lL8SVqFSwxdaQsqeVWygnL9v9ozMd1/4Ot2KzCPsM2mhs1RRZSmDwUmjd+yl2jjTmSCxCziGeRUxF/XZ27CqBg5yIwrtgNnr6kCty3HA1phagzhA/nBq5mOCbtIxiXoM8behUy4jZZlDDSOWuOJyGExhEEuUe8BdV42xr0VaR3uWn6PDMa0i1EYI3vZ5OXjeyvBRvwhXEm0ZPGfhNzsHIA+qwmDDwTVURDyA9hZ3Sojpb8PCs9er8SgY5lfXquzxRM4l7CpvYxYle7gv1iYVB1OedLaR6WFffp8dsrcor95CSDom8C/ytoDvsDA+JbiKFTjwRBZzdw0EPv/MSIwuwPCAiPUgjC1m/ejYEid1EAvwvBjcNiVngOSOisvmSWCQykfHnVISo8Q3kXl3vL/YQqAHaD9JSnJSJmkXh9iigXuE6Uishf6ayk28VmfHZo+/qT1xowgv7+SSUXlhuTsxddiMk4GpFtHQU+GIw7GTQ/BerfLEt/1nZjaTFNEecAwjuVB66o4VgImKigDrPr29Awc50y/8geskfySitN3VNFNASYse/KTeTbV8zRxUl3vTUCqJqsHPAxQHG1SO09e7T3QX2weM6Qo53+GOus/wzf40a3ctPOoII2VKFfm1FvIz0o6XWRHHZH3vNy3AoDyOCMgDDMoLnXdAyML2zOq3PFJoky5vlCPYkVrgceARxjtXID7Tgf8q7Gi0S065xVD/aWjD9tNmBDK+V3YPOKujNXwyDRV9zDZcthSoymHj7kmvuZMwbplU2kyFhqWMPnTBifuTtCSz7L4TjEgkNt6tkyjJQ3NqvGfgQdRIYnbKeD3ILSxbsq+K4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(316002)(6486002)(6666004)(26005)(16526019)(38100700002)(38350700002)(956004)(44832011)(2616005)(4744005)(86362001)(2906002)(186003)(1076003)(6916009)(966005)(83380400001)(478600001)(66946007)(5660300002)(7696005)(8676002)(8936002)(36756003)(52116002)(4326008)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LhK6gzqoSxRjJuRt7d6JJ1qQlkPmTEeFFfi5WndDE6nFN8Z2lJFk9C7Wvhth?=
 =?us-ascii?Q?StFyAEKBz+RBMLq1Nj5yltGFJQS6r1pdCgrD1tuj28SiZj00IDUX26gKQsMc?=
 =?us-ascii?Q?OPRRFYWu9g125bzMaLEQMFZ89+Jnziw/63SZkDWDcpCBsffPWwlHRub0MO7E?=
 =?us-ascii?Q?grlc8bN8Cx9AG68pIt9msqcrmHE1WCL3ZzkGAtnDX+fSgHbDlQgLufGIxmrI?=
 =?us-ascii?Q?ghd7EzpCP7BCBMmPH0JiYRorHL6jrkmy9fYUA1j+taa7T+r3VgbHj87KdkS6?=
 =?us-ascii?Q?1L4kgo/zoXX0mqf5ZHLb/sOCGFLJA5PJrLW6QqJynzKs5CabZihhbxk344eJ?=
 =?us-ascii?Q?7rpyHF6Nh23XqGzub0OVp3hjh4T6FWxUhvnKe5pVyWvmP5AbmEQkX+rb9kxY?=
 =?us-ascii?Q?7np6nTHxLjz2jitoEgVhRtHZHXD3RehFVTpSa1mFbyv/JY3l/9IhFCC7yv9J?=
 =?us-ascii?Q?QwkCOz3G5lp3XGNi2RXwtzDkt1dQaJs5OePnUH97F2TthFBRW4Y2SOulFe3C?=
 =?us-ascii?Q?AA4kRyjBPnu/PV4qe5UAs/4ToZdZtnnIfXe0V+GMmi8Si1UW14078Y7cd7Zi?=
 =?us-ascii?Q?w/vinhX6sypomHZXc7DlzHpCzRg2w11Ys8oqPsS8HrGi5WkiksCVsQa+eIUL?=
 =?us-ascii?Q?coOCAyKAQq/IW2aLXPy/4EOuNbWTqybiQl+f5A5Pqgmba3021mz1a53t6Kz+?=
 =?us-ascii?Q?gLrbkXEw3IyKldCfTvVBB1vQBDcRY+yftQw83G49vNd7djpUkXIwBM9NLCGr?=
 =?us-ascii?Q?a09DKEosnZdZ8lj7ut8mfatN6DC/tHe+d4dv/pDErYF07nDHtqaZrSAHQ3fa?=
 =?us-ascii?Q?2MNE1/0Vp4Ync0y6sSNC/Sc9bPmonO62FIHnKZhWJSepb5ql+tYRWwvWsS8n?=
 =?us-ascii?Q?V24CR+ko+nv+ODLUtnLDC+9LvJdMpaq9UFLIHbGTpMCPhJDgmi5nqY0oM5/P?=
 =?us-ascii?Q?EtQ34+M481NTCXx8WfZyXok4oGeY7mJFfTxyRNUU+YslXjxqwjpA/oyPbG/o?=
 =?us-ascii?Q?Bu6RWWHRwqqtIsbQro3CFmJ3dpXcfj91MI7BHGj0VYoZWEZISlfMolH2alxz?=
 =?us-ascii?Q?nDZpuvdiYjsX+ZrDPfxit/arrIsZhyWM/4mO1zEz1AORmMX6B07e8UFQPPev?=
 =?us-ascii?Q?BmNzn2ZIYxTMRJqm/xMJ95aEtizJvr4IxshLyAONOn062pYIBegzZeS4Hq3G?=
 =?us-ascii?Q?qOf0KzASODOpGaMsH6F7wGp88Sx8BuAU0QFyvutIlH7jalHrYWJLaSy3zdPg?=
 =?us-ascii?Q?4GWxKWdLuSoK59HpUfQzz4RNfbsqXq/y45n6GANIbrIHo59iDzRBVd1AiSfR?=
 =?us-ascii?Q?pzhYaQCTs099QYfGW4THl5jj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc944a60-af92-48e9-7fd7-08d9367c0aa4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:21:03.4541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbPJIcgx+xNM5jV0lu6Redz9C8ukPJxSlfA14BZpHmRHYd8+y3xgjyQuqCGvl340MM1LHoChBzRxvVKzbecGjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3218
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The reference code for DF2 hashing was changed to XOR the interleave
address bit rather than the CS ID. Match that here.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210507190140.18854-25-Yazen.Ghannam@amd.com

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index fc2cd288df0f..7ba6aa97e80d 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1162,7 +1162,7 @@ static int dehash_addr_df2(struct addr_ctx *ctx)
 			(ctx->ret_addr >> 18) ^
 			(ctx->ret_addr >> 21) ^
 			(ctx->ret_addr >> 30) ^
-			ctx->cs_id;
+			(ctx->ret_addr >> ctx->intlv_addr_bit);
 
 	hashed_bit &= BIT(0);
 
-- 
2.25.1

