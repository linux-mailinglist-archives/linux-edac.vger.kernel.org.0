Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E4266CF5C
	for <lists+linux-edac@lfdr.de>; Mon, 16 Jan 2023 20:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjAPTLO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Jan 2023 14:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjAPTLM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 16 Jan 2023 14:11:12 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D517A1A9;
        Mon, 16 Jan 2023 11:11:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgYq4+I5k6FzhVwdhXuqKrpb+qzQm2/C5GG1Tk9K1HhA9ymcErdtkNBTUnYBgQbsoZd97LVeG9kooGzt6IZtto7ESa2ICgf5Dw2UtQ6MhY4quno6dkhPWDAOgc+qDRShWB40XjAes9c13bRJgK4m5fJIO7mHHeJ/KdmBOpkw59iSOtHWuivGiQupepfSl58pvaW6ui7yQDPpxxqHbANE7zt95CKRvY7qNcpM5EigftbdE2ydhlgZer30CPZndww/v+YjAuo+XErHMI9kwgn+m5i6wdbYIXimN+cu8C5OI3CeCYWz/UiZ11MX45ZarJ8NILhSd/b7lLT9+xUCDl1HCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyrlARqUeI8ncR4CpfrGR2Bg9W1gjYgU6HItN2WQVFQ=;
 b=OKTPkXqb6yfB7rBFsxCuCHOhx7vessMnB92MGB+YAmpKXc6KM3b0tVP5CEv5na7ytboO1rxRAJsmB96umlqiWyXELzAXpj4hqMYbOtIRQmIfuk5e11fhI6VKdmd87a+T6YOwVMjRnXcaNpKXVbZ/HiGN/hIxXVANiZp11gab0hMyABaW4BUrxVceKAw/Wr3Mbyx/1iD1gO004Q5YiuITurSHx6v9twYSo5RNe0jjsA2yvIW/Lo8nkIBJ62Gwd+iOCm2rqQGoN0UzAiPW3mokIYiahDT4Fdw1tbgQejPelGAoBs5MDidPz/88HusYSDGOHWduN7u4oxdCJwgLsdnDCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyrlARqUeI8ncR4CpfrGR2Bg9W1gjYgU6HItN2WQVFQ=;
 b=PtxB6E5RuodWotQfa5k1/KUzKFEZwRlVO6J7e+L7hOeDZ607dhysNp7UzZm12g0fywLS70ONY1HlEHs1JJFJDZDU31xV7oIzr8rZp5kV8j2RdzC/FOZijQRXbX8C4+jJrScahiDLwTIULdPMMhJ5EANXKrdpkhxlLkqJ6z2by14=
Received: from MW4P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::10)
 by CH3PR12MB7595.namprd12.prod.outlook.com (2603:10b6:610:14c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Mon, 16 Jan
 2023 19:11:09 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::84) by MW4P221CA0005.outlook.office365.com
 (2603:10b6:303:8b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Mon, 16 Jan 2023 19:11:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Mon, 16 Jan 2023 19:11:09 +0000
Received: from onyx-7400host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 16 Jan
 2023 13:11:08 -0600
From:   Avadhut Naik <avadnaik@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <tony.luck@intel.com>, <yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v1 0/3] Update SMCA Error Decoding for AMD EPYC Processors
Date:   Mon, 16 Jan 2023 19:10:59 +0000
Message-ID: <20230116191102.4226-1-avadnaik@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|CH3PR12MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: f438f4cf-d9d5-4d85-5b17-08daf7f56cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5lo+xqUTnY1RRqnhOiIYrs/NKnnaRJmTPq7NtiNz9lyCcaBKJz3HcseCyVi4OSEkMAHduuol485ZLnwwi/Kn06ewLfFOx/j2j/Oo7NkSWaiTwoUu6H21p3faR9GkMMdyAQ00s6SaTkUIjaf5ZS/VRDwEAh/nOJ69NtZV4Z0AhkIuURIhpAfscJ5LLqAMp/sEuQl2FHc5qCCDIT1sC9fjJFtN1lS0eKqpGwMRXoJQZCj+Afj5FvDObwUFmdHoBc0umJWFnxLc04S+yVbWdEJ9+kJBBq+Lu7/Wvkv9rrERvyKyW0lonAgt7o66yFTDehdsTWqkhmCAN85/Gc/g/7q11R5GZSx1EPxEYOthmaNz6M1MIZqmGmwpFgluBX+Hm/srSvVGuR9lB9ARB4k5Sr/E6xCqB7bfKrH3vXTGKU7hXAIVmlt99PrqUeSLrVYygVCU0oo/6k0aXje014wtzYrlE1a7kgYvt3exdUXjnqtKliOjz508R+i90T2msxEzZ3ledRATRLmOhMGSgvFxxiJfmuN8Q8WiXlVDjVnPYGmYzrg/p3mSBZv1u8mc/Wlv6q/5eTftOXKcBL8zCqxN6RlXTtBt+954n3Qrv8FZDA7cbpdHaBQ44kF6PEUVtzC7Du4JfEzMwotka7kTvDMux2OZKsvfIPF3OE0F2GWgcRlm7ACiZ7++UZvZ0Zhp/uZK6YG5EQno7gfFwDfJe2/xH4ovBgDb0uGMdkTzW+i5JgbOY10=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(356005)(5660300002)(82310400005)(40460700003)(8936002)(2906002)(40480700001)(15650500001)(36860700001)(47076005)(83380400001)(426003)(82740400003)(54906003)(110136005)(81166007)(41300700001)(478600001)(8676002)(6666004)(2616005)(7696005)(336012)(4326008)(316002)(70586007)(1076003)(70206006)(16526019)(186003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 19:11:09.2244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f438f4cf-d9d5-4d85-5b17-08daf7f56cfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Modern AMD EPYC processors support Scalable MCA (SMCA) Error decoding.
Currently however, on Family 19h and 1Ah based, AMD EPYC processors, not
all SMCA errors are being decoded. This patchset attempts to address the
very issue by updating error description structures and handling errata
of some SMCA bank types.

The first patch adds new error descriptions for various SMCA bank types
while also rewording existing and removing unused error descriptions.

The second patch handles the mismatch, encountered on some AMD CPUs, between
the HWID read from the MCA_IPID register and the HWID expected by the kernel
for XGMI Controller SMCA bank type during SMCA initialization.

The third patch tackles the erratum no. 1384, encountered on Genoa and a
few other CPUs due to bit reassignments in Control register of the Coherent
Slave (CS) SMCA bank type.

Avadhut Naik (2):
  x86/MCE/AMD: Add HWID Fixup for PCS_XGMI SMCA
  x86/MCE/AMD: Handle reassigned bit definitions for CS SMCA

Yazen Ghannam (1):
  EDAC/mce_amd: Update SMCA bank error descriptions

 arch/x86/include/asm/mce.h    |  1 +
 arch/x86/kernel/cpu/mce/amd.c | 50 +++++++++++++++++++++-
 drivers/edac/mce_amd.c        | 79 +++++++++++++++++++++++++----------
 3 files changed, 107 insertions(+), 23 deletions(-)

-- 
2.34.1

