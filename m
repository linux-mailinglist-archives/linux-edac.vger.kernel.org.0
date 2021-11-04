Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1BD8445BE7
	for <lists+linux-edac@lfdr.de>; Thu,  4 Nov 2021 22:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhKDWBu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 4 Nov 2021 18:01:50 -0400
Received: from mail-mw2nam12on2056.outbound.protection.outlook.com ([40.107.244.56]:18337
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232258AbhKDWBt (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 4 Nov 2021 18:01:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoskSwTbqNpRBFVHpqAVpRKCJAYLjGUjuHsNHYn9Xa3aYf2qi8cCM+UmT3s+34CXQWTQWRArK6t04wLoQodM/3TPg/oDaZCyupcnD3nhUxEeJ1oyk87ZfvH+7s9U1rB6VV83hAmpE2X90T99tIv4sqSk8F7g5vyuyL7rydzDmXS0I4gbWyY/T66XAosFxD+4z1Qdof2lVIqdjEBStn/6RqQZMeazTHDiorx0o/5vdD52x2bkF5StvffwJU1uB+9XqwP9U21+WfddaT07FU9Jowxy8DAktXAhC4UmBjmSS25+DI0QFQVWYI8YEml4BDZFlYu402tdg2vQbjSWvqidMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyY7c4IlvA95eWFpcVVZ/4G6/MjI6ToPhFNn1tr8d9s=;
 b=aKUIMZrGFC7Rq4SBT0WSrIkSoN5/5kaTZvufbBUNjU7rj4DbJhL5NPFPlC6kKvXk1LhrR7fGdH6U4/8LN9uBDEmELlBtjyiqezoaCgg4xTLxEU1piE2SdDVsoKGd4nKihZK5i/+EcNyN8VssmmBFktWYizyH0mx3b48sAeCoLciTSrKnOe1fnstcBhR5aAql17846iXv3jY2BASGhpBWb3orWoa1ylMz3Arm2fib8x5ksl2krsb8nz4M3HWDwOwjlRxwyVWuGorYDlXOkIaPwo0KsoDymUvSAwxmNjvXre+A1wS2n5/5GxpffcnqX8uUECnN5EgifQNEnloSUTYq1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyY7c4IlvA95eWFpcVVZ/4G6/MjI6ToPhFNn1tr8d9s=;
 b=ruATsmU8D0mDdDJJNkHVWEhAF6bkVbV9iDNwZ0YNt7SFCKiGgVG/A9eU4uiI6g3f7nPxHb4kAvIN46NP41kgtuvhrghh4NOssSBm5TPlus7m8fW2xoBtz4s1BYjjvzBb5JuFfX8RO9a725wTXyOF7HouNp7qeVEKiqFrjPy8hkg=
Received: from MWHPR17CA0067.namprd17.prod.outlook.com (2603:10b6:300:93::29)
 by CY4PR12MB1686.namprd12.prod.outlook.com (2603:10b6:910:c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 4 Nov
 2021 21:59:07 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::95) by MWHPR17CA0067.outlook.office365.com
 (2603:10b6:300:93::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 21:59:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 21:59:07 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 16:59:06 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        <yazen.ghannam@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v3 2/6] x86/mce/inject: Set the valid bit in MCA_STATUS before error injection
Date:   Thu, 4 Nov 2021 16:58:42 -0500
Message-ID: <20211104215846.254012-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211104215846.254012-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20211104215846.254012-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f9d5bda-7497-4bf8-9467-08d99fde5301
X-MS-TrafficTypeDiagnostic: CY4PR12MB1686:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1686F80A40970EC0B996F1D7908D9@CY4PR12MB1686.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gH3h40EcZq7mxavqXDTlEuQaQ9e57EbS+C5Noy91moIzFInHz8+UBkbeEKmre3kOkpEUXbQod6RpRy8MeXAwi0BSWMvHkZmDDQ+U2JiyMXdf6gcVB9XYncv6///9LvTNmrBCjfTtycPCHksMkndHidgaFRav7PJxfAKjVEjG+sSG2knth3n6QJrQiKxDug7NBTFjKg+7bzjfHdIPR7FPnktccZWuxFgR7MftdGlC+0T90EUN90T0Jf5rkbmeDxUGphbpqHZBz128L8mQ3jTcn8w0oRAxbCtHbAY+6L9nlxpDozES79dx7+4ggGxHqNfeK78qhOMtD/Eq2ZmaNJOdQIzaIvs4o0oREqheK5NYkBuJA3nifgnOWhKfnnACmMQfc6pUSAj1EMXtli3BNkOSwg3BdR8TXtB/wAm6MF1vhYPipJVOuP7D6rnpGELylRoItMaHsSupQxuGR306UvPxfC8SgPn2Dw/o82PnIYM5JjMgzm4cxniFxbebzbBx5I2UAOJTlwXPejcItbd5iWtNaAqQ9djvfatHbO0EeGhbLRHWxqAGYXB/mxm/zbmjiZO0GmIlleiDKi1L4hPKYqGTd3G7aDAEMIr3LNptaFEGiD2Md21kwghco1VrfGiAqMtrtb4Zd8blQ0jE2yaFDeYl2px03anyshth7MLCMI5DnH6zHbxRA94KBAUkpUfv15fgjkQTqRvhcnfTWG8mHTJl4bxALoLIF2C4wYs0Dc3m52nQWJu+LWJIf2FvEMVji99t4GL0DWWGBnbKJOvylXVys7eiawFhH6Y1hcgSBB8JSlNJT95DaKQMi6brPYVKk3A1
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(186003)(4326008)(70586007)(16526019)(8676002)(83380400001)(26005)(70206006)(54906003)(356005)(81166007)(316002)(6666004)(110136005)(966005)(36860700001)(7696005)(82310400003)(426003)(36756003)(336012)(1076003)(47076005)(508600001)(8936002)(86362001)(2616005)(5660300002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 21:59:07.1935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9d5bda-7497-4bf8-9467-08d99fde5301
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1686
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

MCA handlers check the valid bit in each status register (MCA_STATUS[Val])
and examine the remainder of the status register only if the valid bit is
set.

Set the valid bit unconditionally in the corresponding MCA_STATUS register
and correct any Val=0 injections made by the user.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Link: https://lkml.kernel.org/r/20211019233641.140275-3-Smita.KoralahalliChannabasappa@amd.com
---
v2:
	Added a warning statement instead of setting the valid bit.
v3:
	Reverted the changes and set the valid bit conditionally.
---
 arch/x86/kernel/cpu/mce/inject.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index fcec99e6c5d1..5e83a1ce7ac8 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -503,6 +503,8 @@ static void do_inject(void)
 
 	i_mce.tsc = rdtsc_ordered();
 
+	i_mce.status |= MCI_STATUS_VAL;
+
 	if (i_mce.misc)
 		i_mce.status |= MCI_STATUS_MISCV;
 
-- 
2.17.1

