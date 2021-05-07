Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCB2376A3F
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 21:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhEGTCz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 15:02:55 -0400
Received: from mail-co1nam11on2079.outbound.protection.outlook.com ([40.107.220.79]:14593
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229470AbhEGTCy (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 May 2021 15:02:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDpj/Qik0tCZymkE8uuT0rcIOm5R1krGpQFbgEJXkT/2XfZe6/sYXRqsO2fcSppf5hfF7QgX3jQ6SXFyjxjJHaI7KglFg8wLC4JNovWEZVD8uzIeHEd5XyejB5atdlNe4JE4FS9Q8GO5xZ+TLG63rc3hSiNEryTdPl6Tte12QXnJSZcwcaDu3c48k23sCISM48kEunXxxmvz+2QzAFMNzd+XzLQCJKvsQbx6HSQzC/YoP27stFY0Cjwkdwg9TucyOiRDCefM9JOTED9lOt3YGu+aecmdxVqmsb3f3rWypUvY+14bs5eTCKjwRt/+8xXoWI/OW7I12zCV39xD3ifwHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6VlQ6DtvJnsX+TB3iwxWt3WvQmjidGgoi66jNu1ZMI=;
 b=Qcw7wv4Jxd+QtwfRUglYeTIKwMKMkQrC/WwLndwvVr90PlL5D4N76lpCI88ojcPsLb9E2pHzrIynX6B8RVA99nwYUE7YEMaNQtM0xULsm9cXETjU2Cxjyeq33qx3bR8xvxQjIHxbPTmz6pAuN+E9ZLGgjuYLu4Ac877VgXaFtMNvalfm/xgl/IbVqRe4xOVdzelTeKRUxl+r7sprtKFZ/qJfBnkX9l0yv+f1wrBOS47ci5IA2ASXlyG1TmFKtshUIqwaoOC2oNSb4ehgX0LNZCy940flV7r4ueWkm0S64t+2U+wPVt87T/Qu0NL6vuupYW9REPRKmzsQ6reMIF4x4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6VlQ6DtvJnsX+TB3iwxWt3WvQmjidGgoi66jNu1ZMI=;
 b=kouxw+qadTCRSJG7i9EV8PG6AYSbn2Lq3EWD9txWs3r55XjjlsWpPooUd/YRsM+2wpW6tyqHDrjzGZU/D26x5bd3AwS8DsV4K6GyG3DLH40S+OAYnA3sTI0X13CQalh/J4ypWIpgFU7w6BWmlpfO17GmaX0W671aF+Tb6XJdIGE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3073.namprd12.prod.outlook.com (2603:10b6:408:66::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 19:01:52 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:01:52 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 00/25] AMD MCA Address Translation Updates
Date:   Fri,  7 May 2021 15:01:15 -0400
Message-Id: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.25.250]
X-ClientProxiedBy: BN6PR21CA0010.namprd21.prod.outlook.com
 (2603:10b6:404:8e::20) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:404:8e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.3 via Frontend Transport; Fri, 7 May 2021 19:01:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c932c688-bbda-48ca-a4c4-08d9118a9339
X-MS-TrafficTypeDiagnostic: BN8PR12MB3073:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB307374535229E1B8E9F92E23F8579@BN8PR12MB3073.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WWS5+VvJ45l75cWi+5iUuX6JB12ZSN+cpSzy/mJEcDZG+/OXeESdOS4nrtqk2Hl6hQOwvgUURrxSGm19B8ljuho1XvbS8P1yVxxRteiKoZEQ4NYw7zKI/LEDRbEye9rpTYGKeuyASJWNPcnzEynMJf3+VXY2URhRzR3kR7khcNSjkwwIe3pYoRnKh4raN5qWUb5i4p7rtiDndk73mHYOTqU3KsZC1eORXiPZMWYuJZhjvvQdGAjcT/I38DgW3l028ziEmlIbSMANjVMzWi6A2wOdPQkjrGhBC2AjNdXHqD5y65ZtbW+MU6OhAYkDZUexElbSMAjvtI2zgsjgR7bs6r3oHH30die4YEJAIzwS94Jg42hZTU6lFd47DLtbLU+Rqa0/SsMu+HVJNZlda0Ayn6Ng5WjZqahq+LaCx/4ZcAVylr5iFXJ50KzClPgejJj52zAXRnQ9dGdbiEGQT14uw9LOuVzNM4t2km5SS/gJE+Ab7yPxiRnV1t3nnudT0hA6n6oE8hO1/RYjx0n2gtMKhSrTtJOZXc+70nhGlJaoa6lTukBUye5wk7qjXGQdJYc8pKe0DeRyBcgxDnVGof/p32eU+Kw1RBS8kcJpEjxUEEG8N91oeA9B0ErcfWB05tiRYz4Y17kcHQ2PFcbVFmNs25R1a/wyS3OeqggZ0qlgES0OWZsdMpEgm2JNl4j6Q/mOU1D1Q1gKPRJmRMpspS6iJmAqcIp+oun1yZ7b2slVpds=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(316002)(6486002)(8936002)(8676002)(16526019)(2906002)(6666004)(186003)(83380400001)(26005)(6916009)(36756003)(15650500001)(52116002)(86362001)(66556008)(38100700002)(38350700002)(66476007)(66946007)(4326008)(5660300002)(1076003)(7696005)(2616005)(956004)(966005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?N9GL09fP/QPLu4JAuDmztgf3tkDWVnV0bfLWgzTPU6YPYNNHKnwQNFOnu5hC?=
 =?us-ascii?Q?appz/ONRcjNQsBfv/T1vWIrithEoiszbTDd9XSnRVIoDZO8FOlGtxQb9InV8?=
 =?us-ascii?Q?sysTLaD1sr4bN3nuJFFDi7K+DELJC/wBb8gRkl++yj+CgnfrPhsRW8uG3e3n?=
 =?us-ascii?Q?1BRyu7Hi3Mb07xcQXPZnzkdc5FqQ4eDEkF1qfywBT+66LKQiJsCdW5WA/uJg?=
 =?us-ascii?Q?kXATUHojoStGyeCqLChpIIeTZaV86YoOUvvKVB2KdhgAZTAOv+xOX4vbseOy?=
 =?us-ascii?Q?aUUaZQ86UYJCVza7Bp+LkCTYdauIvVXYzcUhGt06f1bXzTD1v/co66AoUMjI?=
 =?us-ascii?Q?nn6AwgAQW7/LGjjZVejKnv94C4TtNLH8+KIp9dOIZdDNponpxDYFXdEP0Ryd?=
 =?us-ascii?Q?2JZFmawk9VTpsh1sZWra/D/6o+oKbLs4hgbC95gARJZGL6dR2HsUucCoaoE/?=
 =?us-ascii?Q?9L6jm/pIWyz2BIoc4SqVOcWHbUkkbFb+POjhXsmV2+nNlb67HUMGfBkWDCLe?=
 =?us-ascii?Q?409LMjd7n1wwkmPkIocFgmX/uwTDfeR/ZVroSs6MAXG1kXS7ROHdzPc91tkT?=
 =?us-ascii?Q?9Iql9YG/ckM1xS7Pqk2GkQpv6Qbzw2g/R1mG+OMV4hwUHkXDLjtHsKRqaxLz?=
 =?us-ascii?Q?90niX3TmaABdadHSIAW2xcdalJXn69BS/r38ASZ7CGTLDRUxYjmyzFi/HzTZ?=
 =?us-ascii?Q?n5Jh4dBzFUMoHafvmfB4JfBq2g8jOWTYvprAkAKPsZo9kadO2bzlL2KOtoDm?=
 =?us-ascii?Q?jPkxrF25d/mJJdnKLof+EulaZOZrpFvM0h0CRclaNH9D1bsPciOM0IozAAUK?=
 =?us-ascii?Q?lJBaccrEbif9kq+b49RqBMbt8MdHi2Y5H7RvHkZCk4eWJqj/DBI9CyaiJeG2?=
 =?us-ascii?Q?L6ml0z7nFX10IUdh1yx33BzFgzYpGI6xwfqaALEmcpzrGoiQQJQdxE61Pa1S?=
 =?us-ascii?Q?tVGKbOoaVbtuw6T0+dqHKpDX3CERrDWX4+Dof5GmOEqYa3ZSyNbPaatTGjT7?=
 =?us-ascii?Q?d2W4S0uCasVh0U3LtPwsroFb67vm85mpPmBTOWu/2Mvrd8ThL+g6n/yoSr4L?=
 =?us-ascii?Q?oFa7NVjXXLttSwPAK+jaRSyoeCOIRtJyUwuBzRqlNh8qxe21S4mgW9i2v3xw?=
 =?us-ascii?Q?Chv2PlQevsxRRaSFGmOMtnwZkHitwmMG7HdpZxCZv8RCLN+vb6geheFSq+wh?=
 =?us-ascii?Q?gFuxt4G1V7UeTfM3tJfeq4KLQpCx4p7JEFKZ5kMaqDVj33mGudDs174G5vf9?=
 =?us-ascii?Q?fYk4Jw9tlItejn5ANin+yXJ6BgyHAiJl9JI2miOWvOiblTDzFlwHLEMHDLXA?=
 =?us-ascii?Q?5p++zHi4d4/2QCvfYYSruSby?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c932c688-bbda-48ca-a4c4-08d9118a9339
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:01:52.5621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+I6+mdWzho9B4/jYw+4Qoyz1L9EhnkjgfndqLuBxVIpNu08VQnNl37vK5zAhoqU6OfM8vUPreDf3QY9B0i+8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3073
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

This patchset refactors the AMD MCA Address Translation code and adds
support for newer systems. This patchset was written from scratch
compared to previous patchsets.

The reference code was recently refactored in preparation for updates
for future systems. These patches try to follow the reference code as
closely as possible. I also tried to address comments from previous
patchset reviews.

Patches 1-24 do the refactor without adding new system support. The goal
is to break down the translation algorithm into smaller chunks. There
are some simple wrapper functions defined. These will be filled in when
supporting newer systems. The intention is that new system support can
be added without any major refactor. I tried to make a patch for each
logical change. There's a bit of churn so as to not break the build with
each change. I think many of these patches can be squashed together, if
desired. The top level function was split first, then the next level of
functions, etc. in a somewhat breadth-first approach. 

Patch 25 adds support for systems with Data Fabric version 3 (Rome and
later).

Each patch was build tested individually. The entire set was
functionally tested with the following modes.

Naples:
  No interleaving
  Channel interleaving
  Die interleaving
  Socket interleaving

Rome:
  No interleaving
  Nodes-per-Socket 0 (NPS0)
  Nodes-per-Socket 1 (NPS1)
  Nodes-per-Socket 2 (NPS2)
  Nodes-per-Socket 4 (NPS4)
  NPS2 w/o hashing
  NPS4 w/o hashing

Thanks,
Yazen

Link:
https://lkml.kernel.org/r/20200903200144.310991-1-Yazen.Ghannam@amd.com

Yazen Ghannam (25):
  x86/MCE/AMD: Don't use naked values for DF registers
  x86/MCE/AMD: Add context struct
  x86/MCE/AMD: Define functions for DramOffset
  x86/MCE/AMD: Define function to read DRAM address map registers
  x86/MCE/AMD: Define function to find interleaving mode
  x86/MCE/AMD: Define function to denormalize address
  x86/MCE/AMD: Define function to add DRAM base and hole
  x86/MCE/AMD: Define function to dehash address
  x86/MCE/AMD: Define function to check DRAM limit address
  x86/MCE/AMD: Remove goto statements
  x86/MCE/AMD: Simplify function parameters
  x86/MCE/AMD: Define function to get Interleave Address Bit
  x86/MCE/AMD: Skip denormalization if no interleaving
  x86/MCE/AMD: Define function to get number of interleaved channels
  x86/MCE/AMD: Define function to get number of interleaved dies
  x86/MCE/AMD: Define function to get number of interleaved sockets
  x86/MCE/AMD: Remove unnecessary assert
  x86/MCE/AMD: Define function to make space for CS ID
  x86/MCE/AMD: Define function to calculate CS ID
  x86/MCE/AMD: Define function to insert CS ID into address
  x86/MCE/AMD: Define function to get CS Fabric ID
  x86/MCE/AMD: Define function to find shift and mask values
  x86/MCE/AMD: Update CS ID calculation to match reference code
  x86/MCE/AMD: Match hash function to reference code
  x86/MCE/AMD: Add support for address translation on DF3 systems

 arch/x86/include/asm/amd_nb.h |   7 +-
 arch/x86/include/asm/mce.h    |   5 +-
 arch/x86/kernel/amd_nb.c      |   6 +-
 arch/x86/kernel/cpu/mce/amd.c | 681 +++++++++++++++++++++++++++-------
 drivers/edac/amd64_edac.c     |   4 +-
 5 files changed, 555 insertions(+), 148 deletions(-)

-- 
2.25.1

