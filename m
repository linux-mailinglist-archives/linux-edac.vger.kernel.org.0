Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324A73B856D
	for <lists+linux-edac@lfdr.de>; Wed, 30 Jun 2021 16:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbhF3Oxa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 30 Jun 2021 10:53:30 -0400
Received: from mail-bn8nam11on2049.outbound.protection.outlook.com ([40.107.236.49]:55904
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235787AbhF3Ox0 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 30 Jun 2021 10:53:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2vGCJxSe8LrEAbdkAgx9qNQ4Py5OXK+5GKuXg5YrKwmtm9aChWgo9NUb6xK/+2MdpfRKlInF8m/vluXUJFPPF3ie0Nmh2+g9p4vB22BpkccFC/BKMpQU7gWZxayK+MjKYvqTwzbR9OFn/kUN0XnZoBfePg85RcF08re7XPXP0DBdZjqps/UvAFvAYdc7iSxp4B/atb3EmELLwJQlMQYrRxAmgw2zI7cHYELpDvcmhoLh89JvWDsyPvk4iIDfMf0mUV0qT4pxOq4QWsTtU7URONpAPRu4r8FZoPSoP+94eDipB0bk2DzdwlUTtMtCFQ10WVLVSHIZsaMGANi0IpSTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XJBwi61Tsu9H9dR6XnVBeS0VoQULR5+yM5G1IjALpc=;
 b=TJgjrbiJk3gsHAs8vILYBEYDIQBAEXmnWTjozkcfOcji9seaVeG99hDljRcrkAW5M3es1qB4X0QF5ul6O4IBcDovmdhSBJyTJDxLmUHtb+9OGmt/dQc2T+jz2rI+HzSwUyvQfA7F20joscjrsu4wT0CsweKgVsW46MlZLU9JFftdA4v58lh7AOX4cjCOn1kPs45QHPhDQYfKeyAoFltZsbbel4FJMRjnYBkaSo9kOu3e+vEjHVsG4EZOvkw1J7+R9KpaZn9cCt3DvunKCD6qBmlIon1LG8gBfmk6oKGEFA3IvbNnrqIwiw0pV+IZRtGc3Ra/rN7y5yR8ve5k/i53jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XJBwi61Tsu9H9dR6XnVBeS0VoQULR5+yM5G1IjALpc=;
 b=LhoSYZyulk5Mkowgcy4iEJY25/LEUSZB1hfRERqwPpG2sNvWSlhLpb0Fs6rIQ0mx7ei8lsulI0nX1AwFYZX7SrB9DJH5gDoLpUcQS64JilSOJbJO7jwMxSTC+cAhWldhoL+nHdYHtuCpuK9AzDjP6UkL55Q85Hxyb3of32CB7f8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Wed, 30 Jun
 2021 14:50:55 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::8ce:4339:7e20:7022]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::8ce:4339:7e20:7022%5]) with mapi id 15.20.4287.023; Wed, 30 Jun 2021
 14:50:55 +0000
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     linux-edac@vger.kernel.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org
Subject: [PATCH 4/7] EDAC/mce_amd: extract node id from InstanceHi in IPID
Date:   Wed, 30 Jun 2021 20:58:25 +0530
Message-Id: <20210630152828.162659-5-nchatrad@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210630152828.162659-1-nchatrad@amd.com>
References: <20210630152828.162659-1-nchatrad@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To BL1PR12MB5286.namprd12.prod.outlook.com
 (2603:10b6:208:31d::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SLES15.amd.com (165.204.156.251) by MAXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 14:50:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b63b2d3-9e16-4b62-8ad7-08d93bd676cf
X-MS-TrafficTypeDiagnostic: BL1PR12MB5125:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB51253654D017ACEDA91892F1E8019@BL1PR12MB5125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gLxQvFAiAnCxfvcQ47vjsAIZn4a1abYIBEyQ5PccJYSN7ROP6TySkKi/4EvbWNolL2X8+IvwZ2wlrpx4EfBTggnlA6cJp30DVo9bSbDGPboUjVkiCNRa/gMFAQpo1atplXNCU8k1jsj8GphsynTAt7e7rq+DCp+0cXUo7aKF6xTJCamkV0lkElflKyi9ZGp+lMmM1ouTJTdNN5SnAc1dpqFIZ65F7jxoHJUAUG7lg040bwdKwAYqUOqUskVkVcZ3t56ZTzcuuFzn9svpGDMXwj9FVgnqcokRE1EDAuz1mgFXw2pkuy31UvWrJUlfwQKFFFiQuAZ0/m/F3oP0eAnknFWETtbifF0NMiKNI5AN0jTFsqdFjDMK4+56wtRnT7TxaKzJyhtYcx7ePgSJTXXrvRFcw8Iy2HecNAbEc9T//orrG06oPVi2xssLY183fQgyIrgeXVlxH7bwqDZbqApSvspTTiX7WlTjt7dAuJT2ulQLA/Gmq+V4t1oR3qcS4toGBH7ttI0fIU54ECzeJfXCBDf/plTqUNLzmA6lbxQBnTc9gXsE6r4M83tV14IHIDN29mV+d3SQqFj1tqxDF6mmZjtq0+BwoNz7TuYFST7bscl/LzBg2zwCoFZwKEOOTxA/q2qYhZHXWugzfsj2GOsxyppqICjmUzDkcggfA7adghCtzMA1yapSlvVPKrNfqqYPCDat4RTVNkJtxzr/l+l1VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(66556008)(52116002)(7696005)(6486002)(478600001)(316002)(6666004)(83380400001)(2906002)(38100700002)(2616005)(956004)(66476007)(38350700002)(4326008)(36756003)(8936002)(5660300002)(16526019)(1076003)(8676002)(66946007)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PN519FuKPJ68K7I0EoXVRqRXOfkGJJVetUI8ydSaE8BISyFjbYO98OCWXI1R?=
 =?us-ascii?Q?NrjvbuAclGHCkJD1xWzXcwAN7NALV+SLgUdR0Um+GCKszEj3WtwaUcs375ZB?=
 =?us-ascii?Q?8YMRTfVKXzOdlzLSAIK0rmQ+jkVyMCVjPyQR2cW69BnV+y0gAYWIL4JC6nI6?=
 =?us-ascii?Q?9wocw9/DY9TFI7XjyJbkGKL1IOx3QdaWlbaJIEAonpb/CeEl23Sz8TK9morz?=
 =?us-ascii?Q?3tgFouWF04c9L2OAYFWiLBLYQMEiM20ey9lUP/lTXvv/T/a0oaCB7tMpbb4C?=
 =?us-ascii?Q?D8HNHx+JGC6ZzoOjenCd2vu2gcBvX7NOrqNJ3u52zFt5yKg+6+/6q0t+s/Nu?=
 =?us-ascii?Q?xS3HP4UFXDYfjQKat8l6IEr8wp3xUk24YiKqmdHAvjOKE0hcMORPgVVbtJxV?=
 =?us-ascii?Q?DaAv9AsXYpG4ODo0Aj8840Rm6c60R37DRRd4pSxe8VrrxA7t6pwOk7NhN0j3?=
 =?us-ascii?Q?zBuJokTFmOAvmJWjG0/htVy9594y++j6iihNLhSkeewvzf6vl354Y3fNfrGD?=
 =?us-ascii?Q?baNhzdngdCWzhMj7Kv62iB9vMbg8UTF7KLdsU57JlVSQaib8Who/CtmRgmtN?=
 =?us-ascii?Q?NST2SfIUxk0s3x0/FdlEhVSP20qpfjPi3vezS8UW7RQhZeaBhyolm1iSScx+?=
 =?us-ascii?Q?HFBITGAx8ZfqOL3UG6a82p2oyvQ7iCA7i+rW3Z9XPV71LBk07XUTMPW1QyjH?=
 =?us-ascii?Q?1FlkLZajmJDzJ9SFzNctZ09codyCl7AaNhewMDHonaITcsPsUntCCCU7DtCo?=
 =?us-ascii?Q?YS3uXG1mciYP/nYleMWXatvTOee6ajecse69qXuxEfW+bEyzrkE5Il/HZMsp?=
 =?us-ascii?Q?MDp6SNUk/SUT/eoJ739wYP6g14xhqzbGMu37NeYj7vmyT5o10CNOD/DKVMpY?=
 =?us-ascii?Q?PJrxtHNaL0UZDwfNettbGU368oVmLd9gFNpzlG+pSSzWS3G2lshhO6NCDuMF?=
 =?us-ascii?Q?RotlCJT2IYEzp2GIUozvHrs/XPyJQGzuI+TeU9xb1UK+wCZV9O0O+Yo+mUJ/?=
 =?us-ascii?Q?zcr88msNhxwO5DgcAuU5AR6eroz7SDbexE8C1tf+RqMBphcyrITAX034yVJK?=
 =?us-ascii?Q?W7PN0iKLc3Q28P8qYuLqU9iVww5QUy3xurb5FwOAW+MfGpQLpzwwQeHKd5vk?=
 =?us-ascii?Q?fkCZ5xPdAuiOYH0b/cijF2+72aFOfQhyrRqWvjP0kXMeGBu2PJBbmqqdpvRN?=
 =?us-ascii?Q?nf8j8ug9t2A/81Iiz8Kd3rkU/PiI/9AjViMy2NNZun4rtOt4zfNSN9DeWNPi?=
 =?us-ascii?Q?/lP+0A2kRHY4IrWvZn5FTWh0LpKWNjyZfanYWKN+0VVchL6MhRV5NS3BRYJV?=
 =?us-ascii?Q?p9q9jCmAZrnIo3rJgTJZagge?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b63b2d3-9e16-4b62-8ad7-08d93bd676cf
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 14:50:55.4249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8iR7BODL8z484ThX47bXWp6GIzJSEUU7YRwvoYvT6S0D6c5U9eNuBW6RAryCF+j0GGQUQ0U+OCQL1Ss3o/8cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On AMD systems with SMCA banks on NONCPU nodes, the node id information
is available in the InstanceHI[47:44] of the IPID register.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
 drivers/edac/mce_amd.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 27d56920b469..364dfb6e359d 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1049,6 +1049,7 @@ static void decode_smca_error(struct mce *m)
 	enum smca_bank_types bank_type;
 	const char *ip_name;
 	u8 xec = XEC(m->status, xec_mask);
+	u32 node_id = 0;
 
 	if (m->bank >= ARRAY_SIZE(smca_banks))
 		return;
@@ -1072,8 +1073,18 @@ static void decode_smca_error(struct mce *m)
 	if (xec < smca_mce_descs[bank_type].num_descs)
 		pr_cont(", %s.\n", smca_mce_descs[bank_type].descs[xec]);
 
-	if (bank_type == SMCA_UMC && xec == 0 && decode_dram_ecc)
-		decode_dram_ecc(topology_die_id(m->extcpu), m);
+	/*
+	 * SMCA_UMC_V2 is used on the noncpu nodes, extract the node id
+	 * from the InstanceHI[47:44] of the IPID register.
+	 */
+	if (bank_type == SMCA_UMC_V2 && xec == 0)
+		node_id = ((m->ipid >> 44) & 0xF);
+
+	if (bank_type == SMCA_UMC && xec == 0)
+		node_id = topology_die_id(m->extcpu);
+
+	if (decode_dram_ecc)
+		decode_dram_ecc(node_id, m);
 }
 
 static inline void amd_decode_err_code(u16 ec)
-- 
2.25.1

