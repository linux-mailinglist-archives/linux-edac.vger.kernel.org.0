Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1724F5B06
	for <lists+linux-edac@lfdr.de>; Wed,  6 Apr 2022 12:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351176AbiDFKIU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Apr 2022 06:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348736AbiDFKHC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Apr 2022 06:07:02 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A7E2494B;
        Tue,  5 Apr 2022 23:35:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0LV4utRvBL9PiVyXg0O3u5J0YMgqqpC60ceoB8F3jZcYM87pvXU10B+PHMQpzXKJH8qD2dPXIM+WtlQXN8SrBSQx+KYYjSlCnouBZz1fgsfTKasbqcI+uwG7otlbEhwVfRFgxVnX86ck+ZGDCUCIBztOfT+CXbHUpU8cIwcjCvGbnFkzzCIdE/6lnJfzB04O5NGTPX0LzJ9LSeVe/UuDMNx21QnRxH7clrKa7KiKUFgxXuqusO8fo6Nu0oP/czc+LnSDrONcQssyK3+o+y+luS9PdPKSO09v+L0PQE2I9+1L1ySy7Roeng+zaGtt8mxx+EztVetGTJdKOr5Yiybfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jb+LtWe1krJpWmlvEgjq+Z8PkUwRd5RU8PfxThJ3fYA=;
 b=QefB6E717TAYV7Lr+eA2gPVUeNp5RgoIt4OOOmVjWdu91rNxWtzahZSKva2+AtB+hb62ReJeoIzUCDXCZmcn+Y4xO9Dh8ZfDbc9CSxSwZmCm+UzrVszpvcKbNpfFx/bXyyt28pyT/ptHPM3EVZxT2QNmYqGtCjU/KVzVO+O57a7KP48X+XlrOBCxQAsdysi1dZU5curn+B2HsANs6fp3BbR5IfbNt/gaImL5Xhpy+NicjYZB4lnBuULS4Yr6UhElY5BFIfwVWwJ8cRCIgA4flAO1BK9HLJy7ugwMScgX80ryqf4IR3pdaFuS8xjPSinYSFzQdOSJYQanKs357LxaVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jb+LtWe1krJpWmlvEgjq+Z8PkUwRd5RU8PfxThJ3fYA=;
 b=uJxTbYoDqG0Ed/cZ6QUo7bv3mtgs0rxJxDS/vt6y1BZ+PYIcVODiWbKWY2s/sC5Fh2xXi9tH2JrBaG7Mgi9NWCDnEwL6p0Sr+epTWfsiGn6L880WTsB66r4Cn+nvsksErOyXT101p/VhCSxcnoaJMI6sVxVgA8LMFzbNAXLaK0o=
Received: from DS7PR03CA0352.namprd03.prod.outlook.com (2603:10b6:8:55::32) by
 BY5PR12MB4997.namprd12.prod.outlook.com (2603:10b6:a03:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 06:35:57 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::e0) by DS7PR03CA0352.outlook.office365.com
 (2603:10b6:8:55::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21 via Frontend
 Transport; Wed, 6 Apr 2022 06:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Wed, 6 Apr 2022 06:35:56 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 6 Apr
 2022 01:35:55 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
CC:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        <hpa@zytor.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>
Subject: [RFC PATCH 0/5] Handle corrected machine check interrupt storms
Date:   Wed, 6 Apr 2022 01:35:37 -0500
Message-ID: <20220406063542.183946-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f0e4fe8-0caa-4973-82c9-08da1797b4e2
X-MS-TrafficTypeDiagnostic: BY5PR12MB4997:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB49979AABBD8466D7C6D223B790E79@BY5PR12MB4997.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: clfM2WRtsfLIUOV4sViy4OYlXNyR8foSyhX2la7c7FLh1QbuwZnGGlvwNaNyJFiIEYjQMfRpv8UjSrZ4ENEzhy/mpAeRB9t7KwFlrktJ9fGi8OMP8Soo/QhugRwH6m8kG83N1ckHDDpMhMbG3gc2yvSOO7pI62vGRELbv237I3nwhx8ylN35HN/9N7J6zW7jmBtmN4oj6P5FPHk4/Y5SMtb+50AdPp/hU8Rdhs0XT59KHo9DjtufNriPJUd8NJtspeuLLOeDxAlXDidX8ZeQhbh8kOlr3C028vvNQ9WewINz/bjju4eWmx7hg2JyMgbnqF0NdLdNx0joLEBg41wyta3lWS9AAW30jYGrgAnKbnVCv4Bitf/FbR/NHxUBDYXcahy7mhNpD5I14DpQcCtgCaQue2jrPvQoZv18I6F8jSeY791bW3x1KIeukKAjwCqIR+XPgSQaJEkavV6q60Lv1k0j24FtBXO6PWH5tE/AEQviIi4xsqIhRl0GtubsF4bcPml626fmh8U3zWkgmzPciskHYSbfP3Zg3a2ODXqdDepG5IacZw+gAsWvqZK7sAB+b4JHuoziaHNbySjo/Jw7TfgJ1TG+KzUZmRgprUlztv3C7eIaexrVUfp6jkxhax+spAyewFbAtysRzOOEfUsAr5pl5mOFyFHS1I2UFl011AU2Gad2yueOgaJwFtPbVOZJDmQVj2ADQuiTMkRbStz9ig==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(336012)(508600001)(86362001)(426003)(8936002)(82310400005)(2616005)(5660300002)(26005)(186003)(16526019)(1076003)(6666004)(47076005)(7696005)(83380400001)(40460700003)(110136005)(36756003)(70206006)(70586007)(316002)(2906002)(8676002)(4326008)(81166007)(356005)(54906003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 06:35:56.7496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0e4fe8-0caa-4973-82c9-08da1797b4e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4997
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Extend the logic of handling Intel's corrected machine check interrupt
storms to AMD's threshold interrupts.

First two patches are from Tony which cleans up the existing storm
handling for Intel and proposes per CPU per bank storm handling.

Third and fourth patches do some cleanup and refactoring on the CMCI
storm handling in order to extend similar workaround for AMD's threshold
interrupt storms. These two patches could be merged into Tony's second
patch of CMCI storm mitigation.

AMD's storm mitigation for threshold interrupts also relies on per CPU
per bank approach similar to Intel. But unlike CMCI storm handling it does
not set thresholds to reduce rate of interrupts on a storm. Rather it
turns off the interrupt on the current CPU and bank if there is a storm
and re-enables back the interrupts when the storm subsides.

It is okay to turn off threshold interrupts on AMD systems as other error
severities continue to be handled even if the threshold interrupts are
turned off. Uncorrected errors will generate a #MC and deferred errors
have a unique separate deferred error interrupt. The final patch adds
support for handling threshold interrupt storms on AMD systems.

Smita Koralahalli (3):
  x86/mce: Introduce a function pointer mce_handle_storm
  x86/mce: Move storm handling to core.
  x86/mce: Handle AMD threshold interrupt storms

Tony Luck (2):
  x86/mce: Remove old CMCI storm mitigation code
  x86/mce: Add per-bank CMCI storm mitigation

 arch/x86/kernel/cpu/mce/amd.c      |  49 ++++++++
 arch/x86/kernel/cpu/mce/core.c     | 129 +++++++++++++++++----
 arch/x86/kernel/cpu/mce/intel.c    | 179 +++++++----------------------
 arch/x86/kernel/cpu/mce/internal.h |  42 +++++--
 4 files changed, 231 insertions(+), 168 deletions(-)

-- 
2.17.1

