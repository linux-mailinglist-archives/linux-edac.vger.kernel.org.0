Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2293B20E7
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhFWTWs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:22:48 -0400
Received: from mail-dm6nam12on2088.outbound.protection.outlook.com ([40.107.243.88]:16897
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229523AbhFWTWs (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:22:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCHY2QUoNMGKs2rv32oElQb30FvGiQuxUOuJG9tQ/SORsmVA8bNc2k/gL/9JyxPy/nnadMBOjl8tRbxy+7diSfxX3mCtlgNe6l9B8HoQYLG40EnPkdh+d8NkczbWqg6Gx6Rdh7dm+plAgtFVgc+vNh7v1gNSl4U0Tl/OUaFy5RgyEzshTwD6i/DDzq/sYTUOI7Zwe//YipcCR5jjyPTWLzDPsnjv/0N+Pp5zHwglwi2SzpE6aQ8kTQpNTJpuCADA+qEAcOtFuD5w4zLr3LC51Q+LiCYvqCEp4hzPsHaEyjInuEmS3sexdRfLWF7wDBkxs+hoRy8OhzbLw96bMM4d9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRI4lV0d2D4xb8AUrjL7L+oR2ZH/Q5D8vmePZx5LUyQ=;
 b=mRPXEuqdBlxrhMRxLHXbs+hjMWYUOMsqYUrKzk9tnsrMFEI9agCPcQCWia5qSDiMLZWFjZPINMGn7Vy+EghgeBQxx+RsYLTaxxQUYDJXHMNHibYzefQvNmrA4g4HASOq+u3a2hlS7zR8gsGvdQzKxW58zscJQ/lGfP2wDoQeAmBxdkMkvOgrPjEDO/oD2kuFlXCA2B3kVAZEAPE/r4/Hz/eoWTSMc1pNIoNL9i5bIoBHCRlUi/pK7qaapjecDB38oOtfl4UWEl/hjBSDQAxRQPuwndx1/vQ9/d/WlWe+dZ7KmXpaRSp7C73PlzQ81jqedaMOkupMNNneXUSoFqu49w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRI4lV0d2D4xb8AUrjL7L+oR2ZH/Q5D8vmePZx5LUyQ=;
 b=esBFi0EQlgD6kYZ3EPViTjoI2Tl2M5wNC4qzEcazz6TAyzVmeAmoEL7wdFPVo4liidSTPa45k8M12Kr1h0Rn/ypH3Pglk9MvfFTrwTVZmOk783u2xkg4mauLivj0963+U5xKVnaF62yRLwzioMHogvd0mR0K/sVHW7OHxaoWASk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN7PR12MB2740.namprd12.prod.outlook.com (2603:10b6:408:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 19:20:25 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:20:25 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org
Subject: [PATCH v2 00/31] AMD MCA Address Translation Updates
Date:   Wed, 23 Jun 2021 19:19:31 +0000
Message-Id: <20210623192002.3671647-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.184.1]
X-ClientProxiedBy: BLAPR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:208:32a::22) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:20:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 506ded99-7ffd-4683-2e49-08d9367bf41e
X-MS-TrafficTypeDiagnostic: BN7PR12MB2740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB27402B9C71A9DFD0C023043EF8089@BN7PR12MB2740.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hSpfmUP12j4/VflL36pSXCWtrCmAp+1P9MuWI4Mq0F8Yai3Yh2kzbB7rFLQTLoieVHwlgtCI2lrFzPkVeE7IiQa6PaGCJO7iKkRdIEdtAjjSmAMaUKtEfpvx9Zn1mEK7Z1vaaRGy0nwhGePjkDAUdw4fn19Q8o8Y3HDvAdI5nARNSEArQbawYFgBNCFBhalY0Myv9yM4QEMm1T7CK15JvSjrCT7haykguuJtVNmEzz+MI/6LNuRgAz2PJrxh6TmgjQgSyKOCd9xgg2iTUGVSpO8avoCuvSVbKDJuej4tgfevMt8gKE4Ct56TOQt+GXmRQmsVvDssFknFqU8i66NYtVDWmBVUrWcrPtUZQBbQDSTl958BXRMQoNQX104LC5FAbTvP0l+c6GQa+AKKvGbuguftu0rFoC8f4yZ3M3fVdkqoXleE1WD2+LRxRRVB+39MU3OgeK0E8DrTQVskgwud5XEWMT9DPoJJyPHqz+UCrrq6EpB0eaTkHi+7QB5MmS8doUpZfBWvZU4DncKXQVnmNaypH9LTydb7b1sl+q0+bJOKoT1FMYRhWsNxqP1dLBoqGTbpqQvEF6k3JQc+noLizlbBPKINfbE1luHZIjyF16Q85t/JDiAe6suXcZAYRO2BKptFuFr7cHKEI6IaM41sN3mU1GqcdVx93hPx65qLQzIk1DdQ0BAa5u0v15cXuAa98Ks/ciIP2PuVMVROHQ2UlR697bTlIYEok7uEkoMmFNlTp01+dgSn9qrkBN7nL0eno96X1+EHAprkqrLgIlf4FAjeCKcRbFBqEnT9R44JGLEiveQS8bcwbVWC9+8RSShpVIxLkm0p4/jyFmERZngn9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(5660300002)(6666004)(2906002)(83380400001)(966005)(6486002)(66556008)(66476007)(186003)(26005)(16526019)(86362001)(15650500001)(7696005)(478600001)(52116002)(38100700002)(2616005)(956004)(44832011)(316002)(36756003)(6916009)(1076003)(8936002)(8676002)(66946007)(4326008)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eRm2ofXgO9btPXNxAwFcPr98aJXlA7hAowEmrvD4IVjfCAuEXL9MhQfNHiwW?=
 =?us-ascii?Q?vbkDB+ACz7nriyLi1zDPQgR/fC7y1JaeV8uVzftqwTW5yNKBs0yUUZKpMaeD?=
 =?us-ascii?Q?VgfdA+1lWT6jKH+4V36wcxhGSmDiykGC1Qw4n3Ri+yFEvx44DeCjpZXgCkoA?=
 =?us-ascii?Q?Xwv/H8nGLOOguhpVZtxlCv+VFIrfRyGv31BzNDXAD9+gSgEiZKMhEjnuwiSd?=
 =?us-ascii?Q?AgVvfYpo+dNZiMCibbGsQ+dxlbg7wsA/iqkesIH87XqiZHKs1YQ59ZrKj8g7?=
 =?us-ascii?Q?cRK2qcayNcsPjg082xRBWZ8GL2ZrrfNg7j0eemXH2QXyqSXbQZ9u9KxjpDp2?=
 =?us-ascii?Q?KFe4JpvpWNz2Zpo7nVaFYGv+ci6+/dsfma6xEDtMgdLCx7nEZugWYNRfBRBP?=
 =?us-ascii?Q?DtOU4JX++LzgiFbrcsy4MHqpUaIUX61wqf7pNriLQZdbJThESojaolLc0rTv?=
 =?us-ascii?Q?c5otFzdrZr/IOPf3dEuEwyHVsR/mB2r2tVaTBvwjsDUVm9PCv80p35b88p4B?=
 =?us-ascii?Q?4400n13XazoH88w0WnvPH9+LkcXNbpG3t2+m5wuPUTM4vnjMNgEC6/kNuDPi?=
 =?us-ascii?Q?CbZmFVVQLOzMQU9W2PWC7UR/VmS/yc+nVFeoKRrCp1mLa7MNrtWelUl2QiMu?=
 =?us-ascii?Q?MQ8QhVqGIEFVU5XtPM9r7vcf6bvFxjcCC7dmx3NUM8IYXlethMUvto9HTZMz?=
 =?us-ascii?Q?CaEPzxeyltWXRC8/D/AXmUKOVq8amd7Ny0vBAeotPC++ic7iO1NPV67ZixdQ?=
 =?us-ascii?Q?7KgG1FDELKwNuxVMULj1monCZ0VinoppBhTUKVb3RNd2YlTf3ijHJNA/dkkJ?=
 =?us-ascii?Q?zTQ4lZIYTLCfH7fV29y5GttwltCl/TTHls0METqf7+CtV29+ddqiTzp6Vtqq?=
 =?us-ascii?Q?UWCH04HxenAcAXtJ1+3Gr7yW05218X6+MxlvUZ9KIE60Hg3oowr00UdvmIMP?=
 =?us-ascii?Q?PJz30mEKQcHCle+5T5zMV+sdGJevGHoc5VI58fbosri3RSnGxHAZkgrvgi9z?=
 =?us-ascii?Q?RlO9ClInFgzGPphJyZwBQRCOq9LHq4MqVSBIok1RCXAszwXDsWSXHErfsgRK?=
 =?us-ascii?Q?a9N/QQhP4dk74nFkJhDYi8znuA3wwzG/sBeGhoLQ/c04lPKXl+FtZ0YeGjP3?=
 =?us-ascii?Q?9IcX+6fm56SyXQhlOzeBZrRKKS6LMxnyxH8yKAnmMFpp9iYOj8FSjpzcvArm?=
 =?us-ascii?Q?xY2Le+fuU7BQCh3vS2o2hM4vLCOQ7mt4hFuR0pQbr1lWK/aSVV85iANogQcC?=
 =?us-ascii?Q?iufrBl4Yiq+tnHZH6EE0OCHXK96TvruADhJLr9oHt0EYu/sm0SxXSHBwW8MM?=
 =?us-ascii?Q?JheD6X93uEkGMc/H6wlVcXDI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 506ded99-7ffd-4683-2e49-08d9367bf41e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:20:25.6650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSUuy+XCyNRGebb1cs2XnkbRduikt1ZZ1/eX8vntGhBnYLr9WWP3D9MPwligp+fM6Ry6YYjANyqOFm1vVyP5qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2740
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patchset refactors the AMD MCA Address Translation code and adds
support for newer systems.

The reference code was recently refactored in preparation for updates
for future systems. These patches try to follow the reference code as
closely as possible. I also tried to address comments from previous
patchset reviews.

Patch 1 moves the address translation code from arch/x86 to EDAC.

Patch 2 moves the df_indirect_read() function from arch/x86 to EDAC
also, since this is used only by the address translation code.

Patches 3-29 do the refactor without adding new system support. The goal
is to break down the translation algorithm into smaller chunks. Code
that changes between Data Fabric versions or interleaving modes is moved
to a set of function pointers. The intention is that new system support
can be added without any major refactor.

I tried to make a patch for each logical change. The top level function
was split first, then the next level of functions, etc. in a somewhat
breadth-first approach. 

Patch 30 adds support for systems with Data Fabric version 3 (Rome and
later).

Patch 31 adds a short glossary for acronyms used in the translation
code.

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

I've copied x86@kernel.org for the cover letter and first two patches
that touch arch/x86. The EDAC maintainers are copied for the whole set.

Thanks,
Yazen

Cc: <x86@kernel.org>

Link:
https://lkml.kernel.org/r/20210507190140.18854-1-Yazen.Ghannam@amd.com

v1->v2:
* Move address translation code to EDAC.
* Use function pointers to handle code differences between DF versions.
* Add glossary of acronyms.

Yazen Ghannam (31):
  x86/MCE/AMD, EDAC/amd64: Move address translation to AMD64 EDAC
  x86/amd_nb, EDAC/amd64: Move DF Indirect Read to AMD64 EDAC
  EDAC/amd64: Don't use naked values for DF registers
  EDAC/amd64: Allow for DF Indirect Broadcast reads
  EDAC/amd64: Add context struct
  EDAC/amd64: Define Data Fabric operations
  EDAC/amd64: Define functions for DramOffset
  EDAC/amd64: Define function to read DRAM address map registers
  EDAC/amd64: Define function to find interleaving mode
  EDAC/amd64: Define function to denormalize address
  EDAC/amd64: Define function to add DRAM base and hole
  EDAC/amd64: Define function to dehash address
  EDAC/amd64: Define function to check DRAM limit address
  EDAC/amd64: Remove goto statements
  EDAC/amd64: Simplify function parameters
  EDAC/amd64: Define function to get Interleave Address Bit
  EDAC/amd64: Skip denormalization if no interleaving
  EDAC/amd64: Define function to get number of interleaved channels
  EDAC/amd64: Define function to get number of interleaved dies
  EDAC/amd64: Define function to get number of interleaved sockets
  EDAC/amd64: Remove unnecessary assert
  EDAC/amd64: Define function to make space for CS ID
  EDAC/amd64: Define function to calculate CS ID
  EDAC/amd64: Define function to insert CS ID into address
  EDAC/amd64: Define function to get CS Fabric ID
  EDAC/amd64: Define function to find shift and mask values
  EDAC/amd64: Update CS ID calculation to match reference code
  EDAC/amd64: Match hash function to reference code
  EDAC/amd64: Define helper function to get interleave address select
    bit
  EDAC/amd64: Add support for address translation on DF3 systems
  EDAC/amd64: Add glossary of acronyms for address translation

 arch/x86/include/asm/amd_nb.h |   1 -
 arch/x86/include/asm/mce.h    |   3 -
 arch/x86/kernel/amd_nb.c      |  50 +--
 arch/x86/kernel/cpu/mce/amd.c | 200 ----------
 drivers/edac/amd64_edac.c     | 710 +++++++++++++++++++++++++++++++++-
 5 files changed, 709 insertions(+), 255 deletions(-)

-- 
2.25.1

