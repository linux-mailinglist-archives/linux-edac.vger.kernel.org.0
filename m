Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477E91B43A0
	for <lists+linux-edac@lfdr.de>; Wed, 22 Apr 2020 13:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgDVL7C (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Apr 2020 07:59:02 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:41498 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726835AbgDVL7C (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 22 Apr 2020 07:59:02 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MBpgLS002215;
        Wed, 22 Apr 2020 04:58:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=pfpt0818; bh=0fIwbZOgIOoHPtD3itd55wQWgJZbx5CSUjZsZ96zCQ0=;
 b=hXIWV5hjrKyjYFMVBy4XqN9tEbcypEzGsiJS0AX2B9Vd4EBjexOUtfNDmZm37/z7PntU
 b2xOkkW6zzRK7MG9JndpSFEsUBL9jbKAcyEyb6AmxFIq9pOQSDQVVWg5ECePZoGJ+4vA
 gdqT/Gvah7D2pshbQ3r+S1i3p9iTmDAQvGaUytfJ5gkrqs3OdaG+3lU0u2oT6rejkaIp
 xQgMxH04M3ogQolAShbhqBnv1zy7iT1wWyYd2YxQM8rNvibotUT/fBliA4VILoo+LTg5
 kS7JQKAgGrP8ziTTRTGqN8nXGdEwPcYwLgZYOUaSwXfHjL5ruK+4bwf37r2ryjN/t8gs NA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 30fxwph9cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 22 Apr 2020 04:58:46 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Apr
 2020 04:58:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 22 Apr 2020 04:58:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxdXaqtUOPV3b8Z2qlpcfxLXXZbbQkz3tbvZ4VcRtfBdSkEN0LX0YZe9cTgXzBHOVfc+ArqOOzwoGws568Y/C1eDonguDA3I9poE+pdaE59y0ML4T/ESF0QM2L+9DShaKQ40cjCrGkfoHSg7U3Xt3qMw+ShfcjobX7hyfFTBG00+FV38qDknsmv4YVEIwDrUzaK2k47iWsNxdOp/XPHaXwQlBLxw3lc/Z5jpA0Exs+qbk7sYsqYkWuNM70xZF+rWcyt7UXbb6KddwwEiFcBlb3NShjmkhfr4q7c1jRgPLh9jq9lpgw2+8WCMpb1/GayzrEW6siCHRvisZl0EuagA7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fIwbZOgIOoHPtD3itd55wQWgJZbx5CSUjZsZ96zCQ0=;
 b=ZFUb6dOFWbLT3l3VcRZvKcUg9dRv8cXl9aOT0rSQZLPNvalXg38styCr6Hl7LQOG6Dir8S7ac3Gut6pCF/wgpkAMUISAwevxp7nlcj5opvKZKu4EZNiN9BKd1NRMgQu2eqdD9BEv6ExDyt6X7mH8rAzGhFIBGtBmrOePqg+9Dn21IDyrHoUDRB4JwWZkD3cdD31d7Uv/HdxaVE80imfLs4ngYPCdcS+t5XIoweAGcCwGoB3FZ17Tm7f/yZ+PiqKWHTpDou7B4HZFLPQFp76pW4P6Q4Dh92KHPElwJqCd15BlrsJnqw1Vy67SPdW4mve4PmJtviEXiNs7oVMwecT/7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fIwbZOgIOoHPtD3itd55wQWgJZbx5CSUjZsZ96zCQ0=;
 b=TTm61kejGnJJGTj9pHbs+kA3M41LNUvsiK/5a5g5MiKaKADQ5GNp+Y72VcahIBdSC5xz5TYtpGY/WtqRpIp0WlNotW1LiaVRNYOM8R8eyKD0taqZK/4zNcTKuMqCPNB3FlZR3aNJ/qjh3qXbvByamMovT8ykDtlBlM/AULTA9D4=
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2566.namprd18.prod.outlook.com (2603:10b6:a03:12f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Wed, 22 Apr
 2020 11:58:44 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 11:58:44 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 00/10] EDAC/mc/ghes: Fixes, cleanup and reworks
Date:   Wed, 22 Apr 2020 13:58:04 +0200
Message-ID: <20200422115814.22205-1-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0701CA0076.eurprd07.prod.outlook.com
 (2603:10a6:3:64::20) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0701CA0076.eurprd07.prod.outlook.com (2603:10a6:3:64::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6 via Frontend Transport; Wed, 22 Apr 2020 11:58:41 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e53f3ecd-6369-4736-6474-08d7e6b4815f
X-MS-TrafficTypeDiagnostic: BYAPR18MB2566:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR18MB2566628B40F6FD04780921DCD9D20@BYAPR18MB2566.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(136003)(376002)(39850400004)(396003)(366004)(6506007)(66556008)(478600001)(2616005)(5660300002)(2906002)(8936002)(6512007)(6666004)(36756003)(16526019)(66476007)(186003)(66946007)(316002)(1076003)(6486002)(4326008)(52116002)(26005)(956004)(110136005)(8676002)(86362001)(81156014)(966005)(54906003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o1RmKZKXC8tpAX1a/vQJNigMWQ5vs04VVYYQr5+jWYrMNl4IMlPb7CJY8UcvFGUgLlt1n55xmNp4o9c+YvVMg+RthHCEdUkLW2VRAR3XHD/bIV3WZ23ynwD+7VQN7Eyu1XH3n6YeAiheZ4XrsrohLdx98LcfZDWkwlTT+Fj2jE8gyq7ZxiX1JvY9mrvdVqzZMhcxrYVuYwWDa/wScc8871dvPvhUILhWHOFDrD+HWxpEOnJCTWGlvUpYqirrD5j2KvVzftMmnFhQ44X7duXLa6yWoizjKiZmM5gdyqon0qKTStv3dbEnJDrHBG/j+OhbH+oTB+lX29q+mtHQbzQtG04YMN0lb7LmNvED36Mjwyfs2JagZZf3J0yFoOnSt86oFTnXRnrepQiApafx+1yQTd0eGSbIie6pNPNymwcq/mfqrYsdifnkAOgdV+wjjfB4S+iQSPi7KO9rjG45m1R873/ukeokWdwuV3rRMPBc2GduzyZl4CLHzQLA74nbq2zuCE6my4K5TqorDgaJYfnkEA==
X-MS-Exchange-AntiSpam-MessageData: 3/jdDAzNSwvgR5lp+F7U155L7CMkFOZjAnMDvsM6MO80weyutMLAMYfRDll2aGYR/ANnVKrbQ6Nz4nMTE0N3zFBHEh+cuw06MzO+RjMTAwlGQ2frgRqcxuz7HXIhehHVEs1XPyjQeTeVgBjGenNfPg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e53f3ecd-6369-4736-6474-08d7e6b4815f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 11:58:43.9646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4i+IS3wxYOqZml/kGC7nqtVKpwhfZW5PFD4366sYukfNTzRxjVxn55xPbB82w1ClnYbqT0B3cT4Qr136//em/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2566
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_03:2020-04-22,2020-04-22 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This series contains edac fixes and a significant cleanup and rework
of the ghes driver:

 * fixes and updates for edac_mc (patches #1, #2),

 * removed smbios_handle from struct dimm_info (patch #4),

 * fix of DIMM label in error reports (patch #5),

 * general ghes_edac cleanup and rework (patches #3, #6-#10).

First 2 patches for edac_mc are individual patches, the remaining
patches do not depend on them.

Tested on a Marvell/Cavium ThunderX2 Sabre (dual socket) system.

v1:
 * https://lore.kernel.org/patchwork/cover/1205901/

v2:
 * reordered patches to have fixes and struct changes first, code
   refactoring patches last,
 * dropped v1 patches #9 to #11 (multiple conrollers) to handle them
   in a separate series,
 * rewrote patch to remove smbios_handle (based on v1 #9): EDAC/ghes:
   Move smbios_handle from struct dimm_info to ghes private data,
 * added lockdep_assert_held() checkers,
 * renamed struct ghes_dimm_fill to struct dimm_fill,
 * renamed local variable dimms to dimm_list to avoid conflict with
   the global variable,
 * removed dimm list for "fake" controller,
 * fixed return code check to use (rc < 0),
 * added: EDAC/mc: Fix usage of snprintf() and dimm location setup


Robert Richter (10):
  EDAC/mc: Fix usage of snprintf() and dimm location setup
  EDAC/mc: Use int type for parameters of edac_mc_alloc()
  EDAC/ghes: Remove unused members of struct ghes_edac_pvt, rename it to
    ghes_mci
  EDAC/ghes: Make SMBIOS handle private data to ghes
  EDAC/ghes: Setup DIMM label from DMI and use it in error reports
  EDAC/ghes: Remove local variable rdr_mask in ghes_edac_dmidecode()
  EDAC/ghes: Cleanup struct ghes_edac_dimm_fill, rename it to
    ghes_dimm_fill
  EDAC/ghes: Carve out MC device handling into separate functions
  EDAC/ghes: Have a separate code path for creating the fake MC
  EDAC/ghes: Carve out code into ghes_edac_register_{one,fake}()

 drivers/edac/edac_mc.c   |  27 ++-
 drivers/edac/edac_mc.h   |   6 +-
 drivers/edac/ghes_edac.c | 380 +++++++++++++++++++++++++++------------
 include/linux/edac.h     |   2 -
 4 files changed, 280 insertions(+), 135 deletions(-)

-- 
2.20.1

