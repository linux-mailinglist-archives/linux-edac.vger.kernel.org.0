Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED7915A8B6
	for <lists+linux-edac@lfdr.de>; Wed, 12 Feb 2020 13:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgBLMEh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Feb 2020 07:04:37 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:47472 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727535AbgBLMEg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 12 Feb 2020 07:04:36 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CC12WH008257;
        Wed, 12 Feb 2020 04:04:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=pfpt0818; bh=chf+NCUVWrd25pbRKo2/XOgXB9Sp+jXPTTwaqHJqY9Q=;
 b=dosgq/I1OSUWuMBUHGo6lo6Ty+fhjcQgXQQBRsJYR819s1ReeE0GYe8QqWzExnfKW9f+
 yme5vnS8dajaQ/iPH6wIx8xv7V44A836epZiSHQWO/KNoh+jMbH50aK2RanOwRCp8JwQ
 u/XgGzm9lyrix5EcoQEx8d6j0w3rQlvwtWQXxutEWmnyqEv+6K2+Z7ZgE1nLwqETnwNP
 BnYdJtOO3pziZNfCyYyTW7oV+sxZDMzp1AhRdAG3UvuA7iJbT71qDI5kjHdD+dC0i1rD
 L4urwzfrXr/BWGY/eV9y0QHy7MTvGR+dA/B7NXKsyVObEjKC6ps+N/YfVZiKbPPeEmiI 3Q== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2y1wcsqyvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 04:04:19 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 Feb
 2020 04:04:17 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 12 Feb 2020 04:04:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHIOgwf71vO+gLv1qql6r5bnOyWCBV1mvKlu9zN/8wQQ2/U4QD4+XaiR7mZKUUaeKs1Aj6h7iWViqRYE/dUqloCzcoqjIXgoIriIKqEExVny3RENYPRfdXSXbpPQG8ebDso7iARxwXyYPuzxsU7KKNLFoB922N+wxOTjf0lp5RyaqLfjjpN91BNP+2t2zwEWD5rHs3+7f6t0u4rbwElY28iLWSEY5QyOx7ScoND8t5CEKTVGxisdSuHJjF0ZgMw7Punq8/dXREwrAr+OPbMn9RqUzB1qTju3Is4mnRP3WHX2kpbH4QsVqXi5FLtH92jokX3rzIejdluXaXMsegECrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chf+NCUVWrd25pbRKo2/XOgXB9Sp+jXPTTwaqHJqY9Q=;
 b=GHpio1VkNBbnpFldZL0gVUAY8fxVlVPtBlLyl67fFsopoipT/gnc0CDGTpfdYOGW1kS7agX3DzEaSE+b49SHVjsNzKBer5foy8ZhMnzN3XgHky1/wumR9zqSM3WiHOJkDNbNeuxEprklxwkzsAJjbC61g4/Wa1sGU9+r7MTI2YxDYO3i/0Wfq384XTpeF8lWsIP5pUaOHUQ8SdMRDe5pavTwkS5TGHOU+UL3Vlfj2WAujplJVHxS/vltVhRixPSGeutqIbltV1l/LJw+nqwOVTFdwpt8fjW/MpPABriP5fytTX52syb6Hpg1ZIi4+DigYJY0l8bI5sIQ2Zdfi/p5sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chf+NCUVWrd25pbRKo2/XOgXB9Sp+jXPTTwaqHJqY9Q=;
 b=PREede0IszzXklQ5p01RYkErFJsCgDBfbU8dEqEMvu/Ti2SxbMa19Ks+5PGOvUXO/lTJXWZixicN3qY+yOx5IRnp7HjUYlf3i1vjjfd+ywneJs6GxLhiG+jfP9aKSi6nymuE2W+YpKqWeR8+9r4T2n3Zf6g3GcQF+U3UPxzaC6g=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3512.namprd18.prod.outlook.com (20.180.247.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Wed, 12 Feb 2020 12:04:15 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea%7]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 12:04:15 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/4] EDAC/mc: Fixes for mci device removal
Date:   Wed, 12 Feb 2020 13:03:36 +0100
Message-ID: <20200212120340.4764-1-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0226.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::26) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
MIME-Version: 1.0
Received: from rric.localdomain (31.208.96.227) by HE1PR05CA0226.eurprd05.prod.outlook.com (2603:10a6:3:fa::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend Transport; Wed, 12 Feb 2020 12:04:13 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59a55056-e7dd-4890-917b-08d7afb3ae03
X-MS-TrafficTypeDiagnostic: MN2PR18MB3512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR18MB3512519310F0BED54D61BD24D91B0@MN2PR18MB3512.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(189003)(199004)(8676002)(66476007)(66556008)(36756003)(66946007)(1076003)(966005)(6506007)(81156014)(81166006)(6666004)(186003)(2906002)(478600001)(52116002)(8936002)(16526019)(5660300002)(26005)(6512007)(4326008)(6486002)(110136005)(54906003)(86362001)(316002)(2616005)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3512;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ww8Z/uFhuSwE39Jlxk2K/cHrN8+SjmvP0otYTlTlxO3xzWB3Hy1XSbwQx5bHEUmmyUhsbafFf4ecX3suryrmxVyO/ygZehgajurSmlF/p+SaAQqmcPTWsRacjsQYciGDkxgt4KkIyBRKMh1gLe9rBZwKwiDxKHipDFNGPpr8AjWk/6lsMCPY/z/IquHDOG1CIPcpSgIoewQjOnj17IVXzreEM3I+cns1SMwxMUti/Uray1tFVoSSwPD4/7kAncFVyebZrg6xsu/mo02kZUeaJ2v2awaVBHoZ0tUiDnDyIpLzXA1mlMg2rzemz5UuHuOvcv9N13Sj6aemHEip3DYHbV0GXjiGggN2P/6wqnQaLrtHCslpHi1KOgf5LK4ju1DVl2YNSNs9v+sKvtpXP+1JzcK4bJmZ2hmRLZxAqyGyPnYIK0lXJqOrJbrfKqggdSTJODwqbwZTTl3yJA7KRM63pCDToUnuhpFcApO1faLV3uZuPtLMnQl6x0eyYAi4jmLA7DlW5aXXM9rNCXNxI979+w==
X-MS-Exchange-AntiSpam-MessageData: 33E6377j5x4490BYwNYkZnRMo38JisB3MercoOUbWGhipi+c47p7vdGWRWIGjyyUmNpVnyc7LhnjbrjMcWYa89/GPs4C8QSjFVwa7jPHMEcj4yu/q5LtMVyygMA9BUDmUL5+S4BggpLXQig8EZakMQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a55056-e7dd-4890-917b-08d7afb3ae03
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 12:04:15.2739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUgdW5HD4Pe4e8zVFh60lw3qtx+5qGyTKyFZ6r3ah0+z1XMV2shuX1gK3jPi+UjkG+8SCQBcmN2+N0qBQe/rcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3512
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_06:2020-02-11,2020-02-12 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This series is a split of

 [v2] EDAC/mc: Fix use-after-free and memleaks during device removal
 https://lore.kernel.org/patchwork/patch/1190002/

in smaller patches to better handle stable backports.

Patch #1 helps to ease backports of patch #2 to 5.3 and earlier
kernels, see patch descriptions of both for details.

Patch #2 is the smallest possible fix to address use-after-free and
memleak issues aimed for backports.

Patch #3 is another small patch that is split off for stable. This
fixes code already commited to stable trees.

Patch #4 is the all remaining code containing the rework of the mci
device removal. Resulting code is the same as in v2 except for the
changes outlined for v3:

v3:
 * split patch into smaller pieces to ease backports,
 * removed edac_remove_sysfs_mci_device() in edac_mc_free(), at this
   point the mci device is always unregistered

Robert Richter (4):
  Revert parts of "EDAC/mc_sysfs: Make debug messages consistent"
  EDAC/mc: Fix use-after-free and memleaks during device removal
  EDAC/sysfs: Remove csrow objects on errors
  EDAC/mc: Change mci device removal to use put_device()

 drivers/edac/edac_mc.c       |  20 +++----
 drivers/edac/edac_mc_sysfs.c | 100 +++++++++++++----------------------
 drivers/edac/edac_module.h   |   1 -
 3 files changed, 48 insertions(+), 73 deletions(-)

-- 
2.20.1

