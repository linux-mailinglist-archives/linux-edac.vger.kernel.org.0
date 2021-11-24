Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CC445CA9D
	for <lists+linux-edac@lfdr.de>; Wed, 24 Nov 2021 18:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243166AbhKXRKv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 24 Nov 2021 12:10:51 -0500
Received: from mail-bn8nam11on2138.outbound.protection.outlook.com ([40.107.236.138]:19424
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243001AbhKXRKv (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 24 Nov 2021 12:10:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsaIWMDecQgEDbu9gVaf35MzkXJZeu0DtZJ3bqCj5+bmu48d1oL6e4PKICMS34Wh6OobCypyKWVxI6RKdnFJ9GIfLpQj/dWb+Qkg8PZqB1vt+BU1RhG4gUjS82iRHUPlRIKpq9Hwr7xN7tOXvol1h0Az0xEiXeIq7vCEhLwkNXKfDFGwXqaQbIUD9Nn1dqSq3EUwy5a7X4yvZt+7HM3psPEURPt4UnAm/PmP/XedXnprPaeK0VqgLNYZKGOmFUmq8flBvMU94x4fBPN1unwKBGF7TTKRfVFim6JGoA783uH3jZ3ow059GQfq59xgeIbhK+ErGqT44GhK35LgkQgotQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eN3DiGe/OqHzaeafYbHBKY90pounLG7evoBvx1bsayY=;
 b=cTOjiQOdWRupMlATysuChGT6j2CpzX4Pf+w9fvY4QP0VT5u6mmOtZoreT1SkuxQxY9El9fwkngZzco28qp/hEalp3yLLSHnpKus+08f6SK/XgrroGjC2huLMioQyj1fBuuH5FXHX10NCvjJPRitpHFSnGu9Eaf6aBH+5X+yKWd9PKm42JaN0KugZxArm8REOjoThPBFj6y8YU0HFeqIq3rVz9uodv1UXhK2rwaUALpipo05y8vpfCGK8Dsbt1h/7GneeYkYHLMmC9EHzJpSWlSAojcUj5v1vrxEs7nushDPQCrnnM/sVGyUu2MsvgylLXzhWzBWCpgk9bGn1EMO+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eN3DiGe/OqHzaeafYbHBKY90pounLG7evoBvx1bsayY=;
 b=Mnwp0Gic4dKkecGhYxUjLnaPvFsHoDC+Uo6bhMKx9zSH7g/wFgVyEownGf2deEBxeBMXikwABmImjzxR7LDYCnawX21yD7jpD4WKwezS+/gT8w1KO0f6f48Wl4aFIeSsQ4F+kxwjFzkWwKmPL8+Yvifw2ndsRGtbTFYgiAoXBi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB7033.prod.exchangelabs.com (2603:10b6:610:107::16) by
 CH2PR01MB5654.prod.exchangelabs.com (2603:10b6:610:2f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.22; Wed, 24 Nov 2021 17:07:36 +0000
Received: from CH0PR01MB7033.prod.exchangelabs.com
 ([fe80::1dc1:27e5:9fb6:f13d]) by CH0PR01MB7033.prod.exchangelabs.com
 ([fe80::1dc1:27e5:9fb6:f13d%9]) with mapi id 15.20.4734.022; Wed, 24 Nov 2021
 17:07:36 +0000
From:   Tyler Baicar <baicar@os.amperecomputing.com>
To:     patches@amperecomputing.com, abdulhamid@os.amperecomputing.com,
        darren@os.amperecomputing.com, catalin.marinas@arm.com,
        will@kernel.org, maz@kernel.org, james.morse@arm.com,
        alexandru.elisei@arm.com, suzuki.poulose@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
        tony.luck@intel.com, bp@alien8.de, mark.rutland@arm.com,
        anshuman.khandual@arm.com, vincenzo.frascino@arm.com,
        tabba@google.com, marcan@marcan.st, keescook@chromium.org,
        jthierry@redhat.com, masahiroy@kernel.org, samitolvanen@google.com,
        john.garry@huawei.com, daniel.lezcano@linaro.org,
        gor@linux.ibm.com, zhangshaokun@hisilicon.com,
        tmricht@linux.ibm.com, dchinner@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, ishii.shuuichir@fujitsu.com,
        Vineeth.Pillai@microsoft.com
Cc:     Tyler Baicar <baicar@os.amperecomputing.com>
Subject: [PATCH 0/2] ARM Error Source Table Support
Date:   Wed, 24 Nov 2021 12:07:06 -0500
Message-Id: <20211124170708.3874-1-baicar@os.amperecomputing.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:610:38::36) To CH0PR01MB7033.prod.exchangelabs.com
 (2603:10b6:610:107::16)
MIME-Version: 1.0
Received: from sut04sys-r242-0330002bj0sa.scc-lab.amperecomputing.com (4.28.12.214) by CH2PR05CA0059.namprd05.prod.outlook.com (2603:10b6:610:38::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.6 via Frontend Transport; Wed, 24 Nov 2021 17:07:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ec46937-4874-4489-db75-08d9af6ce948
X-MS-TrafficTypeDiagnostic: CH2PR01MB5654:
X-Microsoft-Antispam-PRVS: <CH2PR01MB5654EDB83CF22829CF5D8C92E3619@CH2PR01MB5654.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: guQoQczoengmbyQlqOtYK2CjpZ7RcytG5QdjbKOQwsdHIIUlf2GxeAa4fA/HvQ42/irZ4kz0NK+fsYKVbfymPYzk+F5/Aiv5k2HFbSin1w5U4AvN4GXbmVY0JLr3EDyYdFkgFHyYzz5wVNDIgrRzs2ychuDL7JZL9oltpI/IUX5+DuNR6iedj5+HY2GbidcsRM9Octl4vIodz1GBgPgZcYfqAW/rrmHhylfqmAgWiDh5lzgUsAlpziXjziY6XMKq3mVDicpmz3kAsqbDwJlLIkw0J5aBCkLwJcDc8nBRbvU/cJrlfJG1thB8uo0ki9kbp/BOHYQVoCa45U0W3ryLCjdUER3Zy4/IR6BLCWYvH3dI8lpwYblJu1i6xLNVNqmB/FO7wqiPUkDSQH7dWPUctX3ssI6OH0qbEUae3dsjZmi8P3tgS4MnJF+f4ncSxxGkUHRwV6ly838yMqcXXdcRDJm7K0R/A3C03OQdfQbwPdcFxD+MFeWcxQfR8B0Y2Ezpwc8f0Adf2c4EONMlNNsumXxSIYkYR80nW6L2qo9Tfh4aAxT1UXyViXL0z+x7Jn1tE4SJI+pq+gahhkOxxkB/2mmIG/SXwjgP9vZKHiTTkUA6naHQ7V0+MsYMbuMHwQf/gHBtjQBCO3Wph+Der21+LgFUV7MOqWEN/vq0I9QJaBdLpyhnIA3l8aB1h3s0o0MLpMX5nnYpBo2dWHClcjbJ+yc+j+mFFUNX4WPwzkKA61gNszXi5G+DNeG6zMqu0zVupieE6KhhEx7cfIss6TehZvKXG/2uSe+ZOeAnOSp9FxqvdxAK6ocjpSDtFkq+nKXM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7033.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(186003)(38100700002)(1076003)(38350700002)(5660300002)(316002)(66476007)(83380400001)(66556008)(921005)(52116002)(4326008)(7406005)(508600001)(86362001)(66946007)(26005)(966005)(6486002)(6666004)(956004)(7416002)(2906002)(107886003)(2616005)(6512007)(6506007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g4bBv1oXKX17GHI21KZGqjZ00iEBz+7OuNtiM2QebsbJ0WXqd2slrR/tloon?=
 =?us-ascii?Q?ZdIOKW8yPM2AXoO36icQTrCbfRBDqQcd+Eew3XmJPX795+cxt7LKBZ4Dy/TI?=
 =?us-ascii?Q?MIngsji40qYyVI1YdyLGqXs1W0d2DsBEecDkCpCxoCbf0jqKYcUTcg5nupCQ?=
 =?us-ascii?Q?oyRiRJLahZz+nCvOxJwu82R/DSo6EeADptak9Y2NG0Tm7NbXMh8xGISwfWV9?=
 =?us-ascii?Q?7ZBmovkgTc9LsN1iv56iA5kbqp9SSxqqcGFIa2qORNzYgy/uQrveZgeHyhX7?=
 =?us-ascii?Q?NwAven5z//4ImXYNttiULFXwdk+GhV91yRtFAYOhK6onrPVJb1gedtvCr4wR?=
 =?us-ascii?Q?rWPPkh8jZYhPoX2NdTAyut70JpgH/1MELKYaJNHxdrpvdKdmBGClY3+vJv3L?=
 =?us-ascii?Q?3W/fahgalAuGyXMSKJ1nsITApPcY5V5oT0vbYxvnPdEyDMt9b8pgj2Bdc+tS?=
 =?us-ascii?Q?cM3CBka4e/WVODA3LubxoskZgxOEjArZ250iQa9xUl2OGelBf0g7O4BkeeQZ?=
 =?us-ascii?Q?psuH2vZyCdiALvvrZhTewPGx2109HiHfHvbQA6VmhZMgexK0Pa3BUIvjdQAD?=
 =?us-ascii?Q?zWr7oClQhwK409kwAYdL7fJVBhQieaTGnC1tsHxjtpRXriXOH2SjQPH6jmxy?=
 =?us-ascii?Q?N1RdsDFueseuT0PFyRSwxHCNGjQfZRDNQtBSqTx5d2eh5eSiX+GaCd/pngy3?=
 =?us-ascii?Q?84Cm4MsM6Isomajp2zkKQr7UT+ZJ2simwIpigonAZ/R+rcEoTxHKXWJ+EWWJ?=
 =?us-ascii?Q?tNp1SCIYP0doyE35/Wpck+D6IXr/+1K84wNh9WGJCTND/eggqW4rVyIGdE4l?=
 =?us-ascii?Q?s6hwAXBgrdR5unO7wNcK6XYNEFB2TAakA08r0lWQDL21cfHB5zaLjswnL4Ac?=
 =?us-ascii?Q?huTeO18U9e83Jpsh+P9BDcy4rKRMF73VqwEKAa6qPTpRj9YpdeUMcOkPpU02?=
 =?us-ascii?Q?A20duLt8o3osI3eydcjg7SDPa1873iZct8pjsyOtRtXL+NRtAkghwYw+J0L2?=
 =?us-ascii?Q?NCzr939xYfOfLFrPFf7kulRD5+A2VTlIFtVg6ZgFitKDHTkBdok+2nDD4EVo?=
 =?us-ascii?Q?N3G8iJDXuej3idN8WCEONmfkhiOyiZxfn/yiZjzjpOpm5Ggt0nBOEWKeJTMJ?=
 =?us-ascii?Q?v/4t1L2K6a/YsoolKzTLhWm5ffpRpkab4DGhOwpyAfUSgQtfDZ+2IxlR1rQJ?=
 =?us-ascii?Q?Qn2WxH6iMU1k87BInQ6r1Dyf/Wy4jTFlKYPTU7hoMjopNWjd1UszpyoscSth?=
 =?us-ascii?Q?AjJac/6qh+YLCkBgV1dUwxjtcJMUU95Wm7eyROnLOsJQifl5rm5ys44EqkEm?=
 =?us-ascii?Q?/uFRPkaHtb4hjXUFConiqdBGP0pPh+2ANR8P5x4HvKa+JFsQJSE0gtO06uhN?=
 =?us-ascii?Q?uSzpoom2EzQwTnibB6z6ZI7ERN+paS2mt1D3XGCuBl8AUAUONvd6Z/UoiB6s?=
 =?us-ascii?Q?k2K1L8SoNj+WejiSzgGpDwvY9OsF1CRxdsIRGqISTWDMgbJbWw9kJdp1pCij?=
 =?us-ascii?Q?k9E3sML4nRo/qJRFbUaZPDd/GRibfNFMZcKxTi36OMw3ypPI90FUx06HflN4?=
 =?us-ascii?Q?hysrGz8YCKBwVpaj8st/DDa5TzSYQuWTb+S+fK3AECLlRUAagEOKER5oiFvX?=
 =?us-ascii?Q?esh3NsRqW53EwLaGK+aOwIgkFhC5SLtamoXTT4fp+pfuUTPzrPiz4OgZp1oG?=
 =?us-ascii?Q?CtuY/NpyUWCMIi02vQzYycAzHKWE3lVSTOhev2iuA+lkQZhjAPlgbsz8CIn2?=
 =?us-ascii?Q?MXY+LbuvRQ=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec46937-4874-4489-db75-08d9af6ce948
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7033.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 17:07:35.9450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5V/ZYq+BRZX5WnagWQQuLTolbxtvmY5d1AyCGHfA4OGp126fuye6xjpDA1GPj3W3ZL3VAgfDRwDM4Koimb+pSkOd2TW4/JZviKQA5A2XTo5GcXF+TA2hPYl/no84cOBF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB5654
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This series adds support for the ARM Error Source Table (AEST) based on
the latest version of ACPI for the Armv8 RAS Extensions [0].

The AEST driver supports both memory mapped and system register interfaces.
This series assumes system register interfaces are only registered with
private peripheral interrupts (PPIs); otherwise there is no guarantee the
core handling the error is the core which took the error and has the
syndrome info in it's system registers.

This is meant to be initial support for AEST to address the current gaps
with systems that support ARMv8 RAS extensions but don't have
firmware-first support. This series simply logs all the errors it finds
and triggers a kernel panic if there is an UE present.

I have tested this series on Ampere Altra using processor errors to
exercise PPI handling with system register interface and memory errors
to exercise SPI handling with MMIO interface. Both corrected and
uncorrected errors were tested to verify the non-fatal vs fatal
scenarios.

Future work:
- UER handling to avoid panic
- Looping through all external abort capable (ERR<n>FR.UE != 0) error
   nodes in SEA/SEI handling

Changes from RFC patch series [1]:
- Updated for latest AEST spec
- Utilize ACPICA header defines of AEST structures
- Added support for ARMv8.4 RAS extension
- Dropped the SEA/SEI dumping of SR RAS registers
- Removed unused defines
- Unified RAS extension register printing to a single function
- Updated trace event with additional fields
- Addressed other feedback from RFC series
- Added myself to ARM64 ACPI MAINTAINERS as a reviewer

[0] https://developer.arm.com/documentation/den0085/latest
[1] https://lkml.org/lkml/2019/7/2/781

Tyler Baicar (2):
  ACPI/AEST: Initial AEST driver
  trace, ras: add ARM RAS extension trace event

 MAINTAINERS                     |   1 +
 arch/arm64/include/asm/ras.h    |  52 ++++
 arch/arm64/include/asm/sysreg.h |   2 +
 arch/arm64/kernel/Makefile      |   1 +
 arch/arm64/kernel/ras.c         | 129 +++++++++
 arch/arm64/kvm/sys_regs.c       |   2 +
 drivers/acpi/arm64/Kconfig      |   3 +
 drivers/acpi/arm64/Makefile     |   1 +
 drivers/acpi/arm64/aest.c       | 455 ++++++++++++++++++++++++++++++++
 include/linux/acpi_aest.h       |  50 ++++
 include/linux/cpuhotplug.h      |   1 +
 include/ras/ras_event.h         |  55 ++++
 12 files changed, 752 insertions(+)
 create mode 100644 arch/arm64/include/asm/ras.h
 create mode 100644 arch/arm64/kernel/ras.c
 create mode 100644 drivers/acpi/arm64/aest.c
 create mode 100644 include/linux/acpi_aest.h

-- 
2.33.1

