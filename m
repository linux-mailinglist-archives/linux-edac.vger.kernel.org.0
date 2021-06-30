Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B8D3B8560
	for <lists+linux-edac@lfdr.de>; Wed, 30 Jun 2021 16:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbhF3OxP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 30 Jun 2021 10:53:15 -0400
Received: from mail-bn8nam12on2049.outbound.protection.outlook.com ([40.107.237.49]:33889
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235177AbhF3OxP (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 30 Jun 2021 10:53:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2yYKFoJGMryVIYWcKgGCx35XZ9+ftsTWw9mpwlRVupyT2juMTrW1MrhZ287uS7YGJsO7HkQAj8hHVYzhnR31fc0f84OEeS7fH4l0kYVsnZgnAUT3B0VHFFdq8j1xzjGylwaGkWwUeP+htX9406nK45f86dj5DfBMy6TVmJYPuOyXiJCelagDOV9jtsXrMa3aOn9XPS9YuPiVUgR+Tt1C4aLK/aO7Y1KnM5PEpnwZTpR2mRiGCRUor/RRK7VDwG4TlTyJTurQoGko9TdVwXMLSF8SJJmapfCPsoeKopjCD7yR0L4+oeYV9CDx3CLUdmujX3GpJRRGep85/YmZvZY7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LIepVVDhVuRIQww3tYslFPYjrCKgc3LCSJyOCRHmWg=;
 b=d/0zU3sQFfpqTWTN6jSe1EAnvOzcKcgbKvE7DXzkmova5Su5B/HG9JT9S0yjG15KlKFBQm567k06Tq65Rd1siYu5MfxwMWZGcuVOrHR8m9Az1fUHsnWCtJVZbs9trqnfkei8YGaqSVSbvXXj8NVA3ZrHTn5nYYG9uMsO3uysSNWI09z6Q+MsvNlY5tAc+lQokZKKxUK8ahXiwm76ZyAC8w1+Vim8flcPcAek3kRVihNuHmh0ztvs/hP1i1/BVJ+g9h6+7KQgsnoG5DG3kKo7feRZhL7tW50XMN4cNdybT+/hTxuLoWEhI7HdCXfMmmBiccUVdnvSYo5Cquc5HCsVYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LIepVVDhVuRIQww3tYslFPYjrCKgc3LCSJyOCRHmWg=;
 b=NpjJmncua0/F5YgP4QD8+cHJF5asJzK+5wG3LRNScQIzNro7X+JuHe7b7/abZJuf6u5W+5eKSwkBSV3W+Nav2NWysGcY/jFBknFYcBqJwJBJFWctQoNj+yQGA1ymhqqdpGRyKRUb7QQ7Pz7oX2eoDXw3mebw4OnfP40Fb0Vpp8A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BL1PR12MB5206.namprd12.prod.outlook.com (2603:10b6:208:31c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 30 Jun
 2021 14:50:43 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::8ce:4339:7e20:7022]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::8ce:4339:7e20:7022%5]) with mapi id 15.20.4287.023; Wed, 30 Jun 2021
 14:50:43 +0000
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     linux-edac@vger.kernel.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org
Subject: [PATCH 0/7] x86/edac/amd64: Add support for noncpu nodes
Date:   Wed, 30 Jun 2021 20:58:21 +0530
Message-Id: <20210630152828.162659-1-nchatrad@amd.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To BL1PR12MB5286.namprd12.prod.outlook.com
 (2603:10b6:208:31d::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SLES15.amd.com (165.204.156.251) by MAXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 14:50:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8db15ba9-d53a-41a6-596d-08d93bd66f85
X-MS-TrafficTypeDiagnostic: BL1PR12MB5206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5206D3F52784C1D65C54DD22E8019@BL1PR12MB5206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aIm80wVfB0yQLrmftr1OrhdUmXN5ETdI/jAGaFIYwflgpSgO1OjV/mvniF9TRdyMFOYQHx4quh9epe2PKs1FkDl8DrrO4Zfbw84MG4fLx4DjE3q3ty+Hxx64KaHuUHs3LEa/f2xsazj6o8jktTiSXofIgScOjmOOqu808PDWhiXhtWjyp13/zU1nZktoY8WtFXGrY/7K7i00uP8tRYz37GvyUtdlRLbPATjguQUVpc6DNaC9bbfsaayy0akAouuLeT/5+FuNnhvc+ygtROD90xe+UBvaNJ1WzjGLbejvUtp+LinC4jT6d+BI6Kn6NZgV4b7x6ktN3dn8eDEmavGe4EV04H+keI2ESG0Dchayr2l395Q16csLxeb8dCvQYzWtzNaRXHHCqNF6rpG17v4hdOu1TaF+ikHbpDrcuKTgB9vFLTlrqbWRlAKQE1SuAKImOmNXycOeMIvIFC7ZOKkQUh5OpRnyVLiSt2M4dzbFAu8IMnrokFwqLL/3YxeVrWm8WxlNFCDTzlLE8U1kfzbct8duMk6WxSzY/suAlj0hTPE15uV1QLBxuRqg7le00/tW2MWcvVgQxyEXEGyAnQ+tkcC1FRSj6rVrdIdX8RIqZmqix571Iy6yZN8aABbJKcP7YQiV1g0EleiSEyqfH6e+rzf4Q8u5kbV0xq21v8PyAmeWufBsTGo35mOLJ+nRimBwx09HhgtFcWwpWvdNu+TsukSgZ9DduefXRlSePUHdsHEw/UM8E/A82FT1rzBVrGNWVWDk++AoLe/axV67ME7UOAl5pzEU4C6FgPfd2ufkBGAajnlZQiTAYmY5V4PLa75M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(4326008)(16526019)(66476007)(66946007)(2906002)(36756003)(8936002)(1076003)(26005)(7696005)(66556008)(52116002)(186003)(38100700002)(6666004)(38350700002)(8676002)(2616005)(6486002)(5660300002)(83380400001)(478600001)(316002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?72Fc8dVbHB5G8VfMBKzjnuLuRI9MJ0SsUKqAEN7NMM5VTcp9w/oXkh4aRCS+?=
 =?us-ascii?Q?rT8YRkJXg14OZMfVTF9LziL7avT+LZ4jOwdC6PHRunFsEGhqE5dswJIGVECd?=
 =?us-ascii?Q?EOr9BMYfnKb2ujNUzb+VgYOFZs7UA5IX52JtVPwTnqcZKhiDNgtTY+UTPxc4?=
 =?us-ascii?Q?uGRbqyPuSGQLkr00yax93vAVYtTRQLTKFRJCvV7bOPbUE00Ia8B/Jx3CAAzo?=
 =?us-ascii?Q?0Lndn5GlVKskGitWHn7wL6q5chvm89E/zKCnyytchuH+7Zbi1o3ZilP/z6Xz?=
 =?us-ascii?Q?2SOdGXk9oE1SEZwRzZW878Og4hlbtb9+jUGa3Bhwo5aZ6cI/CytaN1/NZKyl?=
 =?us-ascii?Q?GT1yEIosXHyepfAMvYgnCf3TgxgkmihngJBsIokWTt6hH4rHRsHd9zkh/g0P?=
 =?us-ascii?Q?h9Rwhi6MNIBYMq1VDRzbA+kPe2HkC3Tquk7NZBWnnQyEdNQN0qwB5ZuawNJn?=
 =?us-ascii?Q?Pm6H/Qc48vBde+iqTO5PBbP3xFR18nIElCKO8wDzMdCNfPZOrekXm2C5YAXl?=
 =?us-ascii?Q?Htdc+Wfcj6zj0TWTdHnkgQb9sEgYCSe+9YrXhaiJFQpdyZNdyU+KygoVpWpp?=
 =?us-ascii?Q?ikxTIpa2HZxqKhzWRWvNs2JjE198LpdRoLN3vhpmD1ScNP/nyvrNUnZc+8d8?=
 =?us-ascii?Q?v9XJR+RGhk0nVANO3iHzhV5Oj6Cz7XMpkVfTxje8fBy+eiZKqEyNDWRV+2rI?=
 =?us-ascii?Q?V0ILSCsJfm5prFE4/ziNttUD42X1s9GbFy8NPEnB5NnjHptFxs0rQWvH2F7w?=
 =?us-ascii?Q?iqqXEXhDmg0CNQpSoIuAb5fX30Nxgb6jFxBDZtKytMKFsaQvIXSzS2uD34qV?=
 =?us-ascii?Q?7isdbOeYNdqI8Ks1jb5TZMZgPVTcRBheKYCgd+P55EAj8x4RgO0HTIIMWLq2?=
 =?us-ascii?Q?ETFk1z2g50jUpWlAOw9yJF+KTaK8AiVqQyj/C2q9g+p6RTSxyr83GKFX06pY?=
 =?us-ascii?Q?oWMC8P048TsMsOsweFtW5+th1bslArEwdxpm9dtyQXcoCxokbtfiOy36o5jq?=
 =?us-ascii?Q?hDSeTfjRa1vHGAVOgH2VVTOD4ZO/WFL1uSIClF/9j22KMmULgUMIMpA3a6Kj?=
 =?us-ascii?Q?unfgyvw7C0TDuniGegWQ6nT5lNMFU0Ux3Npwcl3hojdUCk997QnEL/i0DeBH?=
 =?us-ascii?Q?NOjkMzfG+c6lUiSn7Q4IGpOkbaaz18S8B9ZPwI71Ib7HPK7Qq5Z5Q6kXegUu?=
 =?us-ascii?Q?SkbwKD44s30Kt/pFUJTDWt4g75L5LL66uPkPUKwuutwZxWZnED3Fu3a1tCTH?=
 =?us-ascii?Q?pQpS5FQAHko5PX/gn5c3E9GrBhYkYVwBVDKhwNHBzR/RUK4PxQvAPm/9NnVx?=
 =?us-ascii?Q?lmkaC11RIU49d4NVBRqU4vm8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db15ba9-d53a-41a6-596d-08d93bd66f85
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 14:50:43.1707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jjy3RaetSSwF20cRbLifVo2OlOEs4YL/60AGGQ4IFcINiJ4oLwEkyEy8grHSRnKEkQngaQ/LIWw2yiT4Yqa+qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5206
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On newer heterogeneous systems from AMD with GPU nodes connected via
xGMI links to the CPUs, the GPU dies are interfaced with HBM2 memory.

This patchset applies on top of the following series by Yazen Ghannam
AMD MCA Address Translation Updates
[https://patchwork.kernel.org/project/linux-edac/list/?series=505989]

This patchset does the following
1. Add support for northbridges on Aldebaran
	* x86/amd_nb: Add Aldebaran device to PCI IDs
	* x86/amd_nb: Add support for northbridges on Aldebaran
2. Add HBM memory type in EDAC
	* EDAC/mc: Add new HBM2 memory type
3. Modifies the amd64_edac module to
   a. Handle the UMCs on the noncpu nodes,
	* EDAC/mce_amd: extract node id from InstanceHi in IPID
   b. Enumerate HBM memory and add address translation
	* EDAC/amd64: Enumerate memory on noncpu nodes
   c. Address translation on Data Fabric version 3.5.
	* EDAC/amd64: Add address translation support for DF3.5
	* EDAC/amd64: Add fixed UMC to CS mapping


Aldebaran has 2 Dies (enumerated as a MCx, x= 8 ~ 15) 
  Each Die has 4 UMCs (enumerated as csrowx, x=0~3)
  Each die has 2 root ports, with 4 misc port for each root.
  Each UMC manages 8 UMC channels each connected to 2GB of HBM memory.

Muralidhara M K (3):
  x86/amd_nb: Add Aldebaran device to PCI IDs
  x86/amd_nb: Add support for northbridges on Aldebaran
  EDAC/amd64: Add address translation support for DF3.5

Naveen Krishna Chatradhi (3):
  EDAC/mc: Add new HBM2 memory type
  EDAC/mce_amd: extract node id from InstanceHi in IPID
  EDAC/amd64: Enumerate memory on noncpu nodes

Yazen Ghannam (1):
  EDAC/amd64: Add fixed UMC to CS mapping

 arch/x86/include/asm/amd_nb.h |   6 +
 arch/x86/kernel/amd_nb.c      |  62 +++-
 drivers/edac/amd64_edac.c     | 546 +++++++++++++++++++++++++++++-----
 drivers/edac/amd64_edac.h     |  27 ++
 drivers/edac/edac_mc.c        |   1 +
 drivers/edac/mce_amd.c        |  15 +-
 include/linux/edac.h          |   3 +
 include/linux/pci_ids.h       |   1 +
 8 files changed, 582 insertions(+), 79 deletions(-)

-- 
2.25.1

