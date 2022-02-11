Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096CC4B30AF
	for <lists+linux-edac@lfdr.de>; Fri, 11 Feb 2022 23:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354089AbiBKWfb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Feb 2022 17:35:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354214AbiBKWf0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Feb 2022 17:35:26 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E5ED9F;
        Fri, 11 Feb 2022 14:35:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4mO+F5zOlykbYzJTRk4Chj8PN+yIyp0T+xTjbF23dNYeJXepPjcspVDIXZcjfRmGMDoM14SrsY8Yu3FZssxeevlH0yeP1sa/sUfII3lGO+DedbXh+4lpYuzl8S/ZoqjzunJx7w3xVhgFp5+olCMdZ8LyatnD9VUsQOh619DvtnpPiw9mIi2Z2DdsZYJldnrRJBpEWLQLH/aOVj4pLzjZ1WZwD/+UvVqaPAiRWbBnKVbJ9fWUyQ8PPoM26n5FwiPus9fBU4Cb6jrI7oAmV3MHnvGvHrYCENNXXDlC4LugFBek5KNi3wbN6yuacQrGJKnaCKuQXWJ7q5RsQhNh3CWLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIsmljq5qHlsLFDkR+301nEOFT82sTtF53ucqfVO0Ww=;
 b=ONtXoK8z2Gmn/GBK7VuG9epfDhu/cn48E0pbQkNnB9uVFdDGZj3pR8X3yS27BctypRcYpPVNJ6aIWy+q+EOSDmvDRCXjMpnad3Y7puz6MoLcYThIUrSyNZJPkTjRFoq/IXWt4PKg0bTqcylUKqkNsoAQVrriwGFiCQYZS46il2zzZhJ0QJEfwbTQJDDMybC2wpYo8/bRjsnjqfWk+Oy/MO3C1/Ay2Nc/lqsqTEqIfPcXAztJidHHb1w2eBHQZNtz+ZIkM5VfB8i+WDooJVEwdTmtLJIm8bGQMFZOt+xTwPeOgOdC40c9DK+TeCPTjCDxCo1TuEJO+L+YO6bmOoiacQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIsmljq5qHlsLFDkR+301nEOFT82sTtF53ucqfVO0Ww=;
 b=W+yZhjZt+UjKWLAGuAuviVbX2QSdysnf/6F++aGBOV2JySv5GJsK5A+2ZGaCkVuqUb9wyitmAwvK+/g4FrU5No8/RusNZmESpsnktwDKGWzCkeJAqgpbgLpTnJGC7qpJkejDNyxC637fd1z/rQNgDRS+PsjPQnuUxJPhJ+Kpb5A=
Received: from BN6PR18CA0013.namprd18.prod.outlook.com (2603:10b6:404:121::23)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 22:35:09 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::35) by BN6PR18CA0013.outlook.office365.com
 (2603:10b6:404:121::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Fri, 11 Feb 2022 22:35:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 22:35:09 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 16:35:08 -0600
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v3 0/4] x86/mce, EDAC/mce_amd: Support extended MCA_ADDR address on SMCA systems
Date:   Fri, 11 Feb 2022 16:34:38 -0600
Message-ID: <20220211223442.254489-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c605542d-b5c9-4108-2919-08d9edaec2cc
X-MS-TrafficTypeDiagnostic: MN2PR12MB4126:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB41269E004B1679B1F30F5DD890309@MN2PR12MB4126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HjnHtds3b5Os2ekfuPuAMNlFGmVfc9Fma3zxmSxiE+1heSUjjfEiWaUp2XoH8wmTlhvmRVv3pC0IrN8Eei+0DnihwepB2aic9QaTzwdD2toTmA2UQ2tnwzsk8BPdVWYKpQus27Pp06sML9o1nBRP0CWZ4tqlJle3bxURxWVLSbkaRieiArxEAgq09S6ujEdrkr+4Qq7ltEqVo4k3tVDxrvbj1AKGR0B56Ifm9R3BO8GnH215ak3iPTh2J1d3fpCHmbROQ1s1HMJp6mbdXId0HjxDbwkOMq9fxz/dFkA5Zu2S0Fi2H8WKuFkVH39wX1sGwGWN578Sfj9BMTRxSSvsJOJDgi6pdmjSXHWlOxTZMrB4jgqrcxJuR+ABHTfLbtsQsgt8/xk7UCt0oYB7kCkGKbC/DW4QSqh2kUfBsxDmAaZzPObLvnSNFs6Efo0UaG97UkEs5LF+eHFIskhVsDt/q1J+WCO9Y0G71puMaSvgBK6uwuBw027LsKDso9L0b2bcDcvMBz3XdP0vZayAAhD5TQX2bDDNQmh9fUr1nStYTzu9CtigUsdP17Cs4sNVg0CCmxz77pAbCf+TcnnSiwMPuMOY6EQn1ChESv3nUXujE6A8TV139McfLH+urQXv7LLTzh08zLjohq1GxHkblefxF25K2gfGvTR77MCh8EtKyHf+RScM7C+YCh4TxLStS7aCaXNLl8QczEds3wxBk8fRrJEbjAuO9RD14Z50m4UOzuBk+vMehdiPw8WogYn8hKFolWlmD+AxDi/z58q3Z6UPMExWZHV+k9d23vthN8jmHCM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(356005)(6666004)(83380400001)(47076005)(5660300002)(36756003)(508600001)(16526019)(36860700001)(186003)(1076003)(26005)(82310400004)(70206006)(336012)(316002)(8936002)(8676002)(4326008)(70586007)(2616005)(966005)(86362001)(2906002)(40460700003)(110136005)(54906003)(426003)(7696005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 22:35:09.7263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c605542d-b5c9-4108-2919-08d9edaec2cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This series of patches adds support for extended physical address on newer
AMD processors such as AMD 'Milan'. It also, suggests to cache
MCA_CONFIG[McaX] similar to MCA_CONFIG[McaLsbInStatusSupported] to avoid
reading MCA_CONFIG register each time.

The first patch defines a separate helper function to extract
MCA_ADDR[ErrorAddr].

The second patch adds support for extended ErrorAddr bits in MCA_ADDR.

Third patch, caches MCA_CONFIG[McaX] similar to
MCA_CONFIG[McaLsbInStatusSupported] in the existing mce_bank struct.

Last patch, fixes unnecessary padding in mce_bank struct.

Link:
https://lkml.kernel.org/r/20210625013553.231528-1-Smita.KoralahalliChannabasappa@amd.com

Smita Koralahalli (4):
  x86/mce: Define function to extract ErrorAddr from MCA_ADDR
  x86/mce: Add support for Extended Physical Address MCA changes
  x86/mce, EDAC/mce_amd: Cache MCA_CONFIG[McaX] in struct mce_bank
  x86/mce: Avoid unnecessary padding in struct mce_bank

 arch/x86/include/asm/mce.h         | 14 +++----
 arch/x86/kernel/cpu/mce/amd.c      | 59 +++++++++++++++++++++++-------
 arch/x86/kernel/cpu/mce/core.c     | 20 +++-------
 arch/x86/kernel/cpu/mce/internal.h | 26 +++++++++++++
 arch/x86/kernel/cpu/mce/severity.c |  6 +--
 drivers/edac/mce_amd.c             |  5 +--
 6 files changed, 86 insertions(+), 44 deletions(-)

-- 
2.17.1

