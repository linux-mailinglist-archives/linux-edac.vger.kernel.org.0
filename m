Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D891D949B
	for <lists+linux-edac@lfdr.de>; Tue, 19 May 2020 12:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgESKps (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 May 2020 06:45:48 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:51698 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728730AbgESKpp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 19 May 2020 06:45:45 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04JAemou030443;
        Tue, 19 May 2020 03:45:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=pfpt0818; bh=PuBCEOaZYEbehnPX7Dr8/5qAJ86eq3A3lHMwS8a8LF8=;
 b=fqzmIQjlipkDwUVLI/vn17hwZOzbKVMtTFWksTkNtBHhSM5jTnbNJU/8BSqD0l4c9hY8
 Got2627MVNHB3bfX2wUYWvLsMelccs5cMkMdFuKHcNh3l8TlbqLXwd01vnJDpKSXbwX5
 YvaBNRauf1xxuqN/Y65EGnDTfBuCBzBBqxyyLhcv2mqX+xWCsMCnK77BO6b9XHsVbI3T
 jcWJA4NXnldSFr9rS84w1NIAwL3vWeTyKPckSK00nK/6As7NLLtVJmfLIjBk/ZcxNgCV
 DLR/97XMHmdgN9MQBOVurMi5tR2+YhVb36LNlDoX2uWHRlkOlmtzDLUKmOlR/Fe26h0N jA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 312fpp2yba-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 May 2020 03:45:22 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 May
 2020 03:45:19 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 May
 2020 03:45:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 19 May 2020 03:45:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJnFaH+uT1Y90dDTYegCNh3cjrcufcn7dCeCNrbR9BSgGZ3P4W5ja5QvQ3UJIEkYo8k/h2MywQXKMds7Bl6028FrBDoW5J6qCvPlyFYSMhSUV8Q7Gpz/aG/IZHe9FWnRpMwHoEdO8V2qMCM471hoiLdS9NjpTHKy6fqkonG2STw9ZkMwC78fujNSo3ytKH7RMYLPfu9gfERWhb+GwJQC1s5WFOjmujkE6ey4unlHuVifvpQBKaDC6Iczs+tdCZleXTC9gQ6JV3F8BmNA/WydgSCJgNAGuBJa78XsTYJX4TJ84TGtpuuX8J06pH/xL6FMmszzUit64Jd9CXzlzBuyXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuBCEOaZYEbehnPX7Dr8/5qAJ86eq3A3lHMwS8a8LF8=;
 b=WgI+rnPBB0Id5hu+suvPnKlwHLYVXhZSGc1p7TP46A/UJt4c5vEhRjl7NhZpgCKzyDGySmcQ9esZZn6RkAIRLqCkDpIR2LKZvShDh0+TiwJhxFPDn1AXy28/Mcs0ohEBS0EVZny1olPYEupmgCj6z8Zxdzcly4HlaAsSk61ngBBye/5wtud6O2iXX++0UmGNfqiTeM7t7bM2AbZaeSuGWfZHzO1uBMglMROlQ1V54qMDryhrmMsFYSQVJ/UFuh5XVVqL0VWnVXbhI9nPeIG0jtRHYV6aoI0hydHfCiuZVKmDZQuDCnwD0T0aKMDH2+1pUD9aM5SMoapNVEMFb4t56Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuBCEOaZYEbehnPX7Dr8/5qAJ86eq3A3lHMwS8a8LF8=;
 b=rlJxEj3XS7LDCSIYD+LJecxNgEwD/q8p9tlv2ZfjfLSGgph54QGK1ktW+3zkUR3eYaSfxu/3Rn48CtqDAq/w3xwuikr8b0ATLKmaIgBTdTliYcH86R1wexpYcPLgawK7pNuHvDwGAfS0Xqsp6h6zAsCflMXnTJDtysMAP2jkDe0=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=marvell.com;
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2455.namprd18.prod.outlook.com (2603:10b6:a03:132::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Tue, 19 May
 2020 10:45:16 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.3021.020; Tue, 19 May 2020
 10:45:16 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/5] EDAC/ghes: Cleanup and reworks
Date:   Tue, 19 May 2020 12:44:38 +0200
Message-ID: <20200519104443.15673-1-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1P189CA0023.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::36)
 To BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1P189CA0023.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend Transport; Tue, 19 May 2020 10:45:14 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34156149-1d0f-4b81-ee22-08d7fbe1b785
X-MS-TrafficTypeDiagnostic: BYAPR18MB2455:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR18MB24553779182150C036230D0DD9B90@BYAPR18MB2455.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gxcV2LMw/2XAUQetIbQhcyg5PPTeI9wNKM/ECwqN5pK1GozwLEC8BNEtWt3fTSdfkDmg6BDBzAE9is72BPONQq1KUxXM43CZXxNyK9kHPEhjk/yomqmW1sd9MRd0G9yU2LqwxXSqid2IEEZzr6ievbC8PH9XOY92Ie0W/2uNW/vhBvt2LKJJKgx+QcLa42lAVQOVZglZ/C/LqhFosEf5OvG0y6TexP8rWIeQGIdT7XaCLfdSlZSK38gj4bDWRrNEYFaeOsF+Hcaz7GIQOmsCJhyzNxDFl5a/lENGA6rK5UtQKzWAkQIBpHPs19NvY79rTqq/q70bjqRSrfsRmFUGLjumLYi1hQX4+fBIfVWtk6rvFRHpDtOGnyCjpsbx/chrBZ2UxLWUxoHp29GGhQfJRTNYjwLLLOvpchFhzBBRtSpAzviAyZBVcMMiyzSBegaFAJl+AMwbFC+t6ubJirK7Vj0cKrBpA+0syDDSk5+bxuRTU5u5PBzovkvZ69UghF44jI4GoMiZm91ylF17ac4zwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(186003)(316002)(16526019)(6666004)(956004)(2616005)(36756003)(8936002)(110136005)(86362001)(66946007)(966005)(6486002)(54906003)(26005)(5660300002)(6506007)(66556008)(6512007)(66476007)(52116002)(478600001)(8676002)(1076003)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Ivw0Je2KhV3Cq4wGV+JKCSAUmsU0uibJ+gI930pHTb00prz7z3p6HSmDhqP19Z5CmFAjW7TgZ+6YlH1Slzy7Uhct9JZlhAwjH6RpF9ph3x6dkmQW/hhvDtGO4meHNyoUpaJICwUjL0VcdTYyWDUuD6vV08WF1kv77qtlvej5rALH4Gvg8AH98EkcA1k+2S+ttv8I9D/JxutXSVlNiBvlhQ2hgwYq8B/KaQBePDZ4HL/Z8Khgm7OmD3tDrJLFdg4L9JlGm7cSoMOv51f8PY0O2hF42pI4vn4ICgWfeHlzsx1kHCtBENWZac4y48xLGSx2eka/1dzoHkFMljQPZfN9z2zHYifHOI42/b0E4tyQA2hjgxWFmalDnN3pwFImNmAijTebW42BKIxBgNa1Fd3zKAL6fcnF8pvRAkwMzyXdDIAXpwhfmnAvUD7rdkyowlxRBoGopcKKhGcxq/PLj4h5XXUdOx+uujWIV9fKraz48pw=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34156149-1d0f-4b81-ee22-08d7fbe1b785
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 10:45:16.4673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNDEm1cywk9lyOjWbwtSiH9YGm/sylbX1Nh78ctRsPgcuxMJr1Xhg/twX3Po9Xgqa5G16Gff3e3+OzATDlnDHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2455
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-19_03:2020-05-19,2020-05-19 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This series contains a general cleanup and rework of the edac ghes
driver:

 * Some small code improvements (patches #1, #2).

 * Code in functions ghes_edac_{register,unregister}() is move to new
   functions ghes_mc_{create,destroy}() and ghes_mc_{add,del}() (patch
   #3).

 * Separated 'fake' controller code path (patches #4, #5).

Tested on a Marvell/Cavium ThunderX2 Sabre (dual socket) system.

v3:
 * Rebased onto dc63e28efa19 ("Merge branch 'edac-i10nm' into
   edac-for-next") plus patch "EDAC/ghes: Setup DIMM label from DMI
   and use it in error reports" applied from
   https://lore.kernel.org/patchwork/patch/1243203/
 * Removed v2 patches 01/10 and 02/10 for edac_mc driver from this
   series, both are unrelated.
 * Dropped v2 patch 04/10 "EDAC/ghes: Make SMBIOS handle private data
   to ghes", there is no consent with the maintainer to the code
   introduced to get a private ghes_dimm data structure, nor there was
   any feasible alternative suggested.
 * Taken v2 patch 05/10 "EDAC/ghes: Setup DIMM label from DMI and use
   it in error reports" out of this series and submitted separately
   (see above patchwork link).
 * Dropped v2 patch 06/10, keep rdr_mask variable.
 * Fixed subject of v2 patch 07/10 to 'EDAC/ghes: Cleanup struct
   dimm_fill'.
 * Reworked function interface, there is now
   ghes_mc_{create,destroy}() and ghes_mc_{add,del}().
 * Aligned arguments on the opening brace (ghes_mc_*()).
 * Remove ghes_ prefix from ghes_dimm_* definitions.
 * Use sizeof(struct ghes_pvt) in edac_mc_alloc().
 * Rename struct ghes_mci to struct ghes_pvt.

v2:
 * https://lore.kernel.org/patchwork/cover/1229380/
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

v1:
 * https://lore.kernel.org/patchwork/cover/1205901/


Robert Richter (5):
  EDAC/ghes: Remove unused members of struct ghes_edac_pvt, rename it to
    ghes_pvt
  EDAC/ghes: Cleanup struct dimm_fill
  EDAC/ghes: Carve out MC device handling into separate functions
  EDAC/ghes: Have a separate code path for creating the fake MC
  EDAC/ghes: Carve out code into ghes_edac_register_{one,fake}()

 drivers/edac/ghes_edac.c | 254 ++++++++++++++++++++++++---------------
 1 file changed, 159 insertions(+), 95 deletions(-)

-- 
2.20.1

