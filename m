Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31B7E17C168
	for <lists+linux-edac@lfdr.de>; Fri,  6 Mar 2020 16:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgCFPN4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Mar 2020 10:13:56 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:35258 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726811AbgCFPN4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 6 Mar 2020 10:13:56 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026F6JCP006235;
        Fri, 6 Mar 2020 07:13:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=pfpt0818; bh=BZKu3akUNDzUDyWQL1R2rh4QMDJVlDNBAoWfm6D5b7E=;
 b=nfP+RdAKerIkV22uFo7H73GRInprIKlDfiwcVdd1Lnju77DIJh/dHL2UfLyph2xLHt77
 VLc/3VE/uuE17W+Yqf89/+nuxRVx9NgQ2FhVjjsNOBjOGKreExTwy/lX++kNN1DisYyr
 cwOWgIVlSGtHmupj8iNuvq6/G9NPKonFzgBbooLUeVw+ncZDDjYbfTKCaWzDocxEMFni
 eVEVBSWInOG2P5ypyqFVkyqUw/lrcJUzyHg4SPl4s5PIzKGlBN+skawdPgKn/fyY4nf6
 rhWduQdgPafKgbjVRSpSJk1PWhVio9uboutgafpGI0m+QIXN0uxuz6lNCcxoE+xJl7fL zA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2yhn0ydfv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 07:13:41 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 6 Mar
 2020 07:13:39 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 6 Mar 2020 07:13:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VL3jtry1jM0sQ67rc0f7HdBqJpRp4AMR+WMteTCf1jZS4RW1KF+HQTHKx/3fnh92cz8ftlrww+oFcDyNVk0mE0ahiVK3+n0pxtzqH7jMEcjwpNI1dOKNP9loVMmSaO91SVyaqfZujN5MaM4J5fZyyvwPuAsHsSP5x+qPjoSNnq6PzpMNagSXpuFCEtS/68Ug2EFGjw0AkUOzzILq1r04L66ijzlWZT7XRvPVJ2CyWaCrLzpzUwFOfV1RoVZI6+nbQgzradtSZAQW5B5mkWrc0loWU6fjKVoE66wGo4y3VPeY+GAYJN+MZmaXyYKLeLzSUOC16ctMG35NCPWq9DTU8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZKu3akUNDzUDyWQL1R2rh4QMDJVlDNBAoWfm6D5b7E=;
 b=WqBvoWYauue79qSt25CEvOvnlbjSggm29yzTiiaCQSSpEtTEeNtkX20gNqPlrC1WEnMvzCcfyH30EU3yOrQqZ64VVCcpdB8f4StstI3W7Xaljw6cQzVpageoWuxqvfBnZnx7ajkAusPZ9BiuhU98G4PXsYh2DU+zCTsFijSRL5a35n4HWFTQdhtJjCkqcmZZeJUaZHCW0RX7SlPLhHYFBpiWDMIJSNxlX6jR8fd9FgkrGcoYL48GyHOE80CmU53OdQ97Ru3LyNgx+DImCYkg4iq7BxZOucgAbF3KQDXwPu2/RVYMLT4pNa7oyKWT/EjV6FvTS3Fav9jo8T2b8vO2rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZKu3akUNDzUDyWQL1R2rh4QMDJVlDNBAoWfm6D5b7E=;
 b=bml9E8TNGYvJRBypsHfI+DYx2SAjlQZUFWZISDBYPrFwm0nS3+SqSRQT0rExlWQmlcCgkdMjZhUWJIFURoDC5haL72NkhiXInE72KUkV/zryQyYS/16bu1yMQMnCi9h97B6PKf85JoavHdXmuKSP+HZOZR+UgdTa6GSep95FoaQ=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:165::10)
 by MN2PR18MB2400.namprd18.prod.outlook.com (2603:10b6:208:ab::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Fri, 6 Mar
 2020 15:13:37 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff%7]) with mapi id 15.20.2793.013; Fri, 6 Mar 2020
 15:13:37 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/11] EDAC/ghes: Cleanup, rework and improvement of memory reporting
Date:   Fri,  6 Mar 2020 16:13:07 +0100
Message-ID: <20200306151318.17422-1-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0059.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::36) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0102CA0059.eurprd01.prod.exchangelabs.com (2603:10a6:7:7d::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Fri, 6 Mar 2020 15:13:35 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9695bb69-4050-432b-0e45-08d7c1e0f1c8
X-MS-TrafficTypeDiagnostic: MN2PR18MB2400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR18MB2400412D6FBA7181FB59E363D9E30@MN2PR18MB2400.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0334223192
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(199004)(189003)(81156014)(81166006)(5660300002)(8676002)(6666004)(54906003)(26005)(956004)(2616005)(4326008)(16526019)(316002)(110136005)(186003)(2906002)(8936002)(966005)(86362001)(6512007)(36756003)(478600001)(6486002)(1076003)(66556008)(52116002)(66946007)(66476007)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2400;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J3H97loLELudjl80CP9aUek5scDG+abDZWquRPmAA219H13w+dbRl1A8VIfL+rtjMRWyXyrA7apfRBs6oLOll2xGc553pCcAWbrjnHPY5i+X3BXjSiNbEiNWEDHE8HfFeiNgx2CEeEzuiaToXggRNuZMO0BxasHKaOTflM/p5CssfWgPHkXOKrY5OUFeMQ55kiFMGoibXw/5sF66XmsEX53evGSjkR9OTdSG78jKoyiVNplZhy01D8rCaLI0kUpBbfGhjcMZW+lQWSwgVZwZSA3ZJ/hYk5vIz0AfOHGGEgv+++2TJ0Z0hk2ULWGKENNQx8wc8hoLjOkSZMdd+V/ZQPp8/aOQlzgdEeyGHmSICqHg1WhtwskZnMhAOIg1dYbh2VnF3stQJh8LUOjvYCOz0wl6msMWM0Q+12QrCZxdi0YBFukA8woI/G0+FxfqPsNMEtXT/6H5/Su17x6WjmyaZ1XQMyofG2krIsmjzi3lEgmgPnXBs2L0UzCf1l9K3cQbB6vrFX2sIMuUqwDhgQ7tqQ==
X-MS-Exchange-AntiSpam-MessageData: JPNLdwpHosuuyT9keuVtci7e2AOTgJ5BhEc5AN5q+kwCUg7+BEe+Ne025rEDJkCA8lylT/lTRJJuHSGp1DGy1gHK+Hp/Mv+hTIgddNX3EpIqE1KPjNEvDF5Vcc5i8+fG8JftFHhtjIRQdGGrv72xPw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9695bb69-4050-432b-0e45-08d7c1e0f1c8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 15:13:37.3807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFKLIUsI382SJ5CzsZGOce1LylXzlWH1svR6StE36dKVPLx32RKkjoEagizMMoUkv/iHTsB1tniclOQd8QDMtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2400
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_04:2020-03-06,2020-03-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This series contains a significant cleanup and rework of the ghes
driver and improves the memory reporting as follows:

 * fix of DIMM label in error reports (patch #2),

 * creation of multiple memory controllers to group DIMMs depending on
   the physical memory array (patches #9-#11). This should reflect the
   memory topology of a system in sysfs. Esp. multi-node systems show
   up with one memory controller per node now.

The changes base on the remaining patches that are a general cleanup
and rework:

 * small change to edac_mc, not really dependent on the rest of the
   series (patch #1),

 * general cleanup and rework of the ghes driver (patches #3-#8).

The implementation of multiple memory controllers bases on the
suggestion from James (see patch #11), thank you James for your
valuable input here. The patches are created newly from scratch and
obsolete the GHES part of my previous postings a while ago that have
not been accepted upstream:

 https://lore.kernel.org/patchwork/cover/1093488/

Tested on a Marvell/Cavium ThunderX2 Sabre (dual socket) system.


Robert Richter (11):
  EDAC/mc: Use int type for parameters of edac_mc_alloc()
  EDAC/ghes: Setup DIMM label from DMI and use it in error reports
  EDAC/ghes: Remove local variable rdr_mask in ghes_edac_dmidecode()
  EDAC/ghes: Remove unused members of struct ghes_edac_pvt, rename it to
    ghes_mci
  EDAC/ghes: Cleanup struct ghes_edac_dimm_fill, rename it to
    ghes_dimm_fill
  EDAC/ghes: Carve out MC device handling into separate functions
  EDAC/ghes: Have a separate code path for creating the fake MC
  EDAC/ghes: Carve out code into ghes_edac_register_{one,fake}()
  EDAC/ghes: Implement DIMM mapping table for SMBIOS handles
  EDAC/ghes: Create an own device for each mci
  EDAC/ghes: Create one memory controller per physical memory array

 drivers/edac/edac_mc.c   |   7 +-
 drivers/edac/edac_mc.h   |   6 +-
 drivers/edac/ghes_edac.c | 514 +++++++++++++++++++++++++++++----------
 include/linux/edac.h     |   2 -
 4 files changed, 390 insertions(+), 139 deletions(-)

-- 
2.20.1

