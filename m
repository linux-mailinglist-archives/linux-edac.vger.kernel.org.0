Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F3525C9D4
	for <lists+linux-edac@lfdr.de>; Thu,  3 Sep 2020 22:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgICUBx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Sep 2020 16:01:53 -0400
Received: from mail-mw2nam10on2074.outbound.protection.outlook.com ([40.107.94.74]:19073
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727065AbgICUBw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 3 Sep 2020 16:01:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jrx1B3jtCW3h8p9tu5YciBnyiAUodmhNdjxEURPYGBzOTxNbVeXFWEeCCGvVzKrxB170jlU0lQC38175gJxRqu9x2SGUPFWlc0D3HKLzZrcJ/ZQZrDxbo0wRsKvFxx9A4uy7BUqKkKQNGboCyAVXw0nEZskkyY7AcnSY6RuWZyjOEOF0ra3i+Ca3p8hgZ5w9E6ERmuzY132kRyN0fN0RPVWruTbZc/qLzO0UT5EgkHc5ZkwxxRF4NOzjgx5FcVGr0N8vIRWcUqOuKJpD3hye0tbhzD//sPib0qR9DSw7KGNoFSA5K9xFemxXyDoBxdIy1qmyP8Zlm5fFCijy9HQ6IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnynRoID/msCdsPMXzTyG2yVR0DacIUAXoBghpM6low=;
 b=WllarV0+lGOA23QA4hc/+N0iUhcvegXALtqRRAGyi/q06s55pVARXeZNhY69JmH9+0+UjsUIzE92sBUdY3btqq+1ahc/e1TxbElFXUPKPtpaHCC3NbpM134FEZI0FtmvLyv2yqd/sgXFZFVneV25yPstXc/5T5hRmWeeREY2wgcxN1u1N1c9m6l7mBGGU5vL8Kr8aYlH/OMr1XyFlWGw87j/+AuiVRONfScfD2+KeHZXRbCq6D6kszvQaOWgNjvt2i/aQB31yLNPkr8/6CsFG7HuErSjTnSWslnTB7qjwMy+KOrMbVsxxkj5BosJX8oKSWBjkZuV7OEL38c0jMdrjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnynRoID/msCdsPMXzTyG2yVR0DacIUAXoBghpM6low=;
 b=Lgb8SnvQgUMWT0n29lwJXKs7rzv5SXbl9EHUgFOfkU3iAB7HHbcCmvLYpx/k0utaiG7/SEU2Tz6qGOGMgivqYoCuGCxkkaryDbnF+nzII+u8qiZ+K1RgI+bJxU/E7g3kXWWDozpWGdYP7nZAoK34Wxc0L2HTyBSrCjBdP3B4g7M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB2980.namprd12.prod.outlook.com (2603:10b6:408:62::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Thu, 3 Sep
 2020 20:01:48 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e%4]) with mapi id 15.20.3348.015; Thu, 3 Sep 2020
 20:01:48 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH v2 0/8] AMD MCA Address Translation Updates
Date:   Thu,  3 Sep 2020 20:01:36 +0000
Message-Id: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0075.namprd05.prod.outlook.com
 (2603:10b6:803:22::13) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SN4PR0501CA0075.namprd05.prod.outlook.com (2603:10b6:803:22::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.7 via Frontend Transport; Thu, 3 Sep 2020 20:01:47 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 53489b0c-6d45-4364-caab-08d8504430f4
X-MS-TrafficTypeDiagnostic: BN8PR12MB2980:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB29806066E880BA652B757D6FF82C0@BN8PR12MB2980.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WYNHw8kHySQWo+4lOa3orDJ91OkDjcN/PFGMOwzXvoGML8wkx7d1YB7qhaxy9wvF+ZuueRgozoD+VtyvNAS1WLULrN714fjLPK31zHPHC+mn4gA9silMF3t9pP0S8jiQPsxl9zb313KXM7speryHkvEZAn8qc0tfcSN4shzNyKXid2JghD7J3z30Xr3NbkJcyr5RsDEp5SM85HDBwH2Ftvh186mSIBWZ5Dl2NQvfqrojpje90Zgh0fP1k9J1y+IvXpf8Kym0+Ta7dWOAi8aSm3xo24LSGKqJ6G9kjHL0hygFkdD+iJfcWCXD3VFmQNMcc26mzVZtiK3uUVQ+QaEhVHoQTi8paGe3qF95OB5suQyPvvo6XNuxWW4mV2JyvBEkByVEG/N2U8Tvn0y3WVo5hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(966005)(83380400001)(8936002)(316002)(1076003)(186003)(16576012)(52116002)(5660300002)(15650500001)(6666004)(66946007)(8676002)(6916009)(86362001)(6486002)(2906002)(2616005)(36756003)(66556008)(66476007)(4326008)(478600001)(26005)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: KrL3TtUyvgM62p0l3tiD7VPySIqZPis0F2SDQ0u3nUxUOBeREAJy+FRPGnfuistj1u04K8mPHm+GxO9pzSsy9J3FNiBZQG/dRE09iDtZvvfHTqKkdrcVESu9d9Hf/xTHZMyIPbUU9beYwOHphqG0mCXUQpj/OPvvWovj4Mw0ApJhkFb1Vy3rLtQeoC3XyoU+M24PEzNnIGP9zUJH3k5WGk070r3KTg+dCJCQSCOtjUtH9Yqq8q2LJ9/V+qpZ3GVCv8XIgxdFYobtGV85YT0qBlLBCj+oZ6fUeb6/z7BQ1x9dg5OQwA/XbW/TywiJjT9eLk9EqtFfUs39WOgzrJv9X4W8KQAP/pTNWhNzoWGQkoBoyS8k31g2PsZTTpifnTrZuUurxHRmHwq9cuLwJe2N3qkFYQalnMS2L8OMichYC2B3dU+D3JJ/a8a3l2rIA9PYxivkkf4gkg5Cf8EgvpTGbf1Tkn9rOP4E12ORtAcWYcUZrsQQpgc/PErEGEY4NL1NUkXGi+AsNYSV7K3f3M81gJRdO3AMlBQMnBhWmU5izA8sZ07W/uoQGdM7fkoQ5dMz4xUsfe+ucNPPOVc2furKMprJgCj2EOuMd0Wa6VMu0QL5yTTn7VZGy4I9COzplxK1We3uHzvSgLlHE6OYdtKIgg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53489b0c-6d45-4364-caab-08d8504430f4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 20:01:48.3521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DyIA2w7czyWqIhcHY6STVnDYgmOcB+DLBP2NYJED3HKgZw9ukQwbyzKlmdItHuh/zQQ4xtwHoxIAEDi6qD6xNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2980
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

This patchset includes updates for the MCA Address Translation process
on recent AMD systems.

Patches 1 & 3:
Fixes an input to the address translation function. The translation
requires a physical Die ID (NodeId in AMD documentation) rather than a
logicial NUMA node ID. This is because the physical and logical nodes
may not always match.

Patch 2:
Removes a function that is no longer needed with Patch 1.

Patches 4-7:
Code cleanup in preparation for Patch 8.

Patch 8:
Add translation support for new memory interleaving options available in
Rome systems. The patch is based on the latest AMD reference code for
the address translation.

Patches 6-8 have checkpatch warnings about long lines, but I kept the
long lines for readability.

Thanks,
Yazen

Link:
https://lkml.kernel.org/r/20200814191449.183998-1-Yazen.Ghannam@amd.com

v1 -> v2:
* Save the AMD NodeId value in struct cpuinfo_x86 rather than use a
  local value in MCA code.
* Include code cleanup for AMD MCA Address Translation function before
  adding new functionality.

Muralidhara M K (1):
  x86/MCE/AMD Support new memory interleaving modes during address
    translation

Yazen Ghannam (7):
  x86/CPU/AMD: Save NodeId on AMD-based systems
  x86/CPU/AMD: Remove amd_get_nb_id()
  EDAC/mce_amd: Use struct cpuinfo_x86.node_id for NodeId
  x86/MCE/AMD: Use defines for register addresses in translation code
  x86/MCE/AMD: Use macros to get bitfields in translation code
  x86/MCE/AMD: Drop tmp variable in translation code
  x86/MCE/AMD: Group register reads in translation code

 arch/x86/events/amd/core.c       |   2 +-
 arch/x86/include/asm/cacheinfo.h |   4 +-
 arch/x86/include/asm/processor.h |   3 +-
 arch/x86/kernel/amd_nb.c         |   4 +-
 arch/x86/kernel/cpu/amd.c        |  17 +-
 arch/x86/kernel/cpu/cacheinfo.c  |   8 +-
 arch/x86/kernel/cpu/hygon.c      |  11 +-
 arch/x86/kernel/cpu/mce/amd.c    | 284 ++++++++++++++++++++++---------
 arch/x86/kernel/cpu/mce/inject.c |   4 +-
 drivers/edac/amd64_edac.c        |   4 +-
 drivers/edac/mce_amd.c           |   4 +-
 11 files changed, 233 insertions(+), 112 deletions(-)

-- 
2.25.1

