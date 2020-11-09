Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7762AC691
	for <lists+linux-edac@lfdr.de>; Mon,  9 Nov 2020 22:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgKIVG3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 Nov 2020 16:06:29 -0500
Received: from mail-bn7nam10on2047.outbound.protection.outlook.com ([40.107.92.47]:56737
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729247AbgKIVG3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 9 Nov 2020 16:06:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eG0zOiwj966qcYkD6du1nJIEmS2omRqR+aI7LwOXrrjlcwwKt+vZWn61hBuI6h2rg+rjRIxwRa8drBGOkOOPb5gkep9t6wB6Ve7d7EJ/viFu40yr9EKcHHz2N7uWwzl32777nSAMbLWBBjxn+DzHqY14C09jWuwva6e3GetjFRbkI0lS9YaMWNpwKh5KDo9I00YscoyfAMqS6fGcNrZuW4eFVVZxF8lyHrOYg39OW+5Ez+lu0uEPN/HYnnwVBdaUHUQysV9Ly0PV24iI2LZ/HxGqlWsKUhN1sqa6rf0H81nBdqUyHLROJJqCQbmvvzjET+10YvY3A5l3dIku3ohYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHecoD+HrKFRqmvQxRAES9h+ySFjBEM8FrOrDgcUXY8=;
 b=YJx/VcGrnax4OJMXSZ2fz3qBde1IgJEMkm6tyLMjHJTs628sw9gqvViFSTV4VfbRWBqP+B5Li6HV+WNLAcAhv+337IEsF+7h4bLvbN/FMpl//OP41fE0fnLBDo2WebLiMmfEIYGMP4MDSezk3GKywvIS7PW85tLXvYEr1Gu5fIfvXpLZ3OnvrEwb+B/4yIcASoyjZxF1sTiA0Y71fV5+3XP+VCsxQ1fQaRVGqwMKOi2I27iX6qVlStx2uyir+yq056/4x7mOPLd1wH7Rd9ktLGbOJa4HPsB95Bm2DqbXVtZR36ABo2dHFJ4w73eSCIlleR0Zh4XxbCHfxODSumSdYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHecoD+HrKFRqmvQxRAES9h+ySFjBEM8FrOrDgcUXY8=;
 b=VbJDpZRdWtcnHQF9pJqDxW9lJ56sK+vOKTjMAZReJO9oF2FWFWh30XvXG7wnIN6a4FON1oJBS65Gnkofujo4uuBBHCs5OngTufkovU75f2G/nhduAPHTl2T197rwj/ogw45v3BtJWtDZ0gsHW0QKJa/DG5mg++4xBKEsnWMQBYs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB2979.namprd12.prod.outlook.com (2603:10b6:408:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 21:06:24 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9df4:880c:f3f2:679d]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9df4:880c:f3f2:679d%5]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 21:06:24 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     x86@kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, linux-edac@vger.kernel.org,
        puwen@hygon.cn, kim.phillips@amd.com, thomas.lendacky@amd.com,
        wei.huang2@amd.com
Subject: [PATCH 0/4] Set and use cpu_die_id on AMD-based systems
Date:   Mon,  9 Nov 2020 21:06:55 +0000
Message-Id: <20201109210659.754018-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: DM5PR12CA0064.namprd12.prod.outlook.com
 (2603:10b6:3:103::26) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ethanolx.amd.com (165.204.78.2) by DM5PR12CA0064.namprd12.prod.outlook.com (2603:10b6:3:103::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 21:06:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0247dfa3-aaca-4b82-c1b6-08d884f3507a
X-MS-TrafficTypeDiagnostic: BN8PR12MB2979:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB29798AA016A43E51C942CAEFF8EA0@BN8PR12MB2979.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LvDL/wi3chpNNR7gasTKthi9r7w/1yOo277xs4PmeTe5o200wjm+Jt7brrXPfzolySWfMho6be5EwImqf3WOG+M1PdwMRgIPmv0L0TrGEiKnFMRA1QWyudu9jONMyBmZ/PV8FJWtxjfrHaqw0GG2+aQgtdhfhYRwAbr3fd1vkmjMrD2+Rlau7y/C+m0YRzFY1AtPfg8LCIhN1jLQvwtnL+Fwn4AHK3jgIT+QaEJmd6HR6qYv56CcfXb7GCvR/Rw/NUDVBRKO+ohAMI9m40rGio9iGRFl+X5GtNqgEuYqdXei9j6V/6NfGm9FZ4qa+/vti/y5RF78ZxqucfTF6PgOL5B1d1AOPPJQukACHqIFMqi5qMDWaM9DYub7kMAisyff6n2CWnxziXbr7hi4zUr3Tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(6486002)(26005)(66946007)(5660300002)(186003)(16526019)(4326008)(1076003)(8936002)(2906002)(83380400001)(66556008)(66476007)(6666004)(36756003)(478600001)(86362001)(316002)(6916009)(2616005)(966005)(8676002)(956004)(52116002)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Pov2fDXzlfyFPHYDjaX4KvHu8m/3VGXX07cmP5b1ayFhKPUTAzG05Xc3FHmPQd3XMLCcggJzZWnVLtr/B/D92Pdz7p6rjUJP7HJSrT7Q/caQzOpNmCg0Z87X3fwdCw5DyTR05pNCZiud+pMEfnLmkhZWTBw+/BSduKF8vsi57/41olWhOVj8P4BaNxn98deMPtHTev/kl60R8MdcaLMK1xVEgHtpV7LOcuBuy9t1+cOi6tr5HzakMksq37G1KbM+qL/EOehqctzRk1bXaWzuk0t42TsxMPTfFfRhofbB3YWW1xr83N2/dmyyVM/H5F+FdhIlhZbiDiVU83MUhqVYhzRKnfh6r5g39RynEGeS5oZ7Sg2Ov9cpsFbNacXJ7i2C7MVl+vfRTTbZ7qiS9NT1ypE40sxcpLcz+1hMIN9T5DfA+NvsFnz0GOTq6kCb8ERU/0WJdIq3AzBSrAN+R1wxJSsJ5qTWyCsZa4pM0IdMURwx12Kb2Wom2IeI9eacK1RrxCL6pTkfLAUF6CbWqF0pjs5nYG7/wMFM8VQIR4KMwlXEGUBrSwrUCZY/5fy0/ylUQj7U65egA/DYgiOvW/URDKpUEo9u9TpzcvNmpEClmaDV4jo61RlVPRzb8oRDQ0ORcHKL34niuXkXJHqFuvCfkQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0247dfa3-aaca-4b82-c1b6-08d884f3507a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 21:06:23.8514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fa/XDrilaDojiP2aCi1YoWEEhSicgJJBnZ2vWvDPfKmL/kYbpG+3ILx2aVDInvwXfzIPt12+YMRaiGg2JZgcaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2979
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

AMD-based systems currently use a "NodeId" when referencing a
software-visible hardware structure. This may be referred to as a "Die"
in x86 documentation, "Node" in some AMD documentation, and "Package" in
Linux documentation.

Recently a cpu_die_id value was added to struct cpuinfo_x86. This value
can be used on AMD-based systems rather than using an AMD-specific value
throughout the kernel.

This set is based on patches 1-3 from the following set.
https://lkml.kernel.org/r/20200903200144.310991-1-Yazen.Ghannam@amd.com

Thanks,
Yazen

Yazen Ghannam (4):
  x86/CPU/AMD: Save AMD NodeId as cpu_die_id
  x86/CPU/AMD: Remove amd_get_nb_id()
  EDAC/mce_amd: Use struct cpuinfo_x86.cpu_die_id for AMD NodeId
  x86/topology: Set cpu_die_id only if DIE_TYPE found

 Documentation/x86/topology.rst   |  9 +++++++++
 arch/x86/events/amd/core.c       |  2 +-
 arch/x86/include/asm/cacheinfo.h |  4 ++--
 arch/x86/include/asm/processor.h |  2 --
 arch/x86/kernel/amd_nb.c         |  4 ++--
 arch/x86/kernel/cpu/amd.c        | 17 +++++------------
 arch/x86/kernel/cpu/cacheinfo.c  |  8 ++++----
 arch/x86/kernel/cpu/hygon.c      | 11 +++++------
 arch/x86/kernel/cpu/mce/amd.c    |  4 ++--
 arch/x86/kernel/cpu/mce/inject.c |  4 ++--
 arch/x86/kernel/cpu/topology.c   | 10 ++++++++--
 drivers/edac/amd64_edac.c        |  4 ++--
 drivers/edac/mce_amd.c           |  4 ++--
 13 files changed, 44 insertions(+), 39 deletions(-)

-- 
2.25.1

