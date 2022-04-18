Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96D6505DBC
	for <lists+linux-edac@lfdr.de>; Mon, 18 Apr 2022 19:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbiDRRxb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 18 Apr 2022 13:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237550AbiDRRx3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 18 Apr 2022 13:53:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F05326D1;
        Mon, 18 Apr 2022 10:50:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrZ7y2c3aWSG44Gtmls9+24RXMuMeqOSAFoCFUKp8075kyv7i4fqTtMxafLhxyPpNHchavauKJVBJz2TDjC/pu6okib8RC7809eqk5e0+xxP8hlCPdPmECZObJ0hnRf3l7c46ks9sMBqi+6bH9uAujukKpbY+yYRPvB2DuLcLU5mUio8wrOYxsHu2bj+T6N2pUccZhpKpl/92z7dQ2lABsno6uKSjhWFDCCYTABZpWHMnFLEyZ7o969KFMf/DQy2bge81MSxoo6uJ6qatGRQPCP8sPLN2SLClH0yE9iUc6H525BR7JxUA0+rEoV7Ecjp8/cwGH3s0mzI7Fjabj2rrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neYCNoJD3Mp2wV//7N6z9CaSG1EjN4TT6S47BiLXW4w=;
 b=C+bMtDop36OviYCfvM8K9Sh0DL7BmRlw0csmV1jx+9QggAhUYweVwTCvtmQQopStQkc9GOShJhQhyYF0aZp+H0Y9V6k76J4WyY2/+G3ON/jEu7x7zbWeyqH0UQgrT693shsg/0/xcDxIOtAtpTM8lRgqJnXX/keArUM26munPV8FiM5TpvqXVoibDMLrLK9HeiHXqqsL5fZUiYCWggZBNqOv1fStf2co9n2bSrIBUmKVSpcvgLHJXd7tpthMnZZhPbGAHFu3De84FxSS8o1n8wVApNjuRNu9hh3aO4l2U9FgUrtvGTE4LOwlpmoPRpXv/fKs8BYtvw9Pw8n9dOPQ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neYCNoJD3Mp2wV//7N6z9CaSG1EjN4TT6S47BiLXW4w=;
 b=wfWtUDPHRAVgEvq3gvpTYH/AeKW9MnJZv06byqucvcW+PRqcbdfFzH9SWpJsKOcNReZrJO+AL17t3j9EWEiHLgE0yR3Thlvp6TOgATszIceKx9PJK6hpjHZQHGObpr2d5aJR0nsBnYiToUlZDeGqjIFfmRmUP0TS8n0NfKmBMLs=
Received: from DS7PR07CA0021.namprd07.prod.outlook.com (2603:10b6:5:3af::23)
 by BN7PR12MB2612.namprd12.prod.outlook.com (2603:10b6:408:29::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 17:50:48 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::2e) by DS7PR07CA0021.outlook.office365.com
 (2603:10b6:5:3af::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Mon, 18 Apr 2022 17:50:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Mon, 18 Apr 2022 17:50:47 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 18 Apr
 2022 12:40:34 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 0/3] New SMCA Syndrome registers and FRU Text feature
Date:   Mon, 18 Apr 2022 17:40:07 +0000
Message-ID: <20220418174010.330559-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 929aad73-e9dc-44cf-20b6-08da2163f84d
X-MS-TrafficTypeDiagnostic: BN7PR12MB2612:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB2612A030744CBB06C50E693FF8F39@BN7PR12MB2612.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: azNepQMXNkLeunBlSbFHgWPnu0qr/HDkJK4KVVX8adGdJtCtKgevz3UuD46/pfgSHw00icLXQWxK/pVARcHJhDFBo9hDQkUhWzCHH0a+APQ24LOQYhGP/j/M/BOR4/PoCMclsH9iFAaRQhZAYIfkTFPKY/MA7jiLwISBCfrelSu2TGpena5XR1AYYFjVj9565yFhiYgprWTJ1pJVhZnVyGQrpotoeqRaRpuazmM6QvdpM5MvpMbBDrAcml+/3qOzQ1sBKk2bosZhF0sEcbXRxqEYvpgy+iaz1cv6SdtpOMf6w6J68YY3SSyKhJnI3pgf+B3AWNYsHjCTbpcpOKAkLRKm0LvYwyMY1IWkEmmGISJdHXuvRoZ3SU0odDtD50zXMAlomDh+M4lLM90qYiFWo6WU2NkXUK4U41FVGItE2qNz5UoUhNx+eEs7n+mHYIZ1uX7LkM5YKOdPKmDB2mGuoKVxNubzaGIlRdKwA1RbacCWw3EO4nhWMD/02yApvQqde2dseQ+ElGDexaxAnd8MsPEixehAn4dwbMzu1ridzcZhnFKqsuFi6G3q5amNHq9Or99gheNgO8j3ODOEubBDl1UrOPIRK0oitLL0Wx0xMd1PpbaonzR0fUfdwSYd/YVgDovrNTvFpXkrc2Jp6/7TPxLJvdniRBTrrcpSydtKAb7lhrThNRXgQb2mE8ylu0qj4bmc9aaZRFuJRcpHZc+buA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(426003)(2616005)(1076003)(70586007)(70206006)(16526019)(8676002)(36756003)(82310400005)(47076005)(86362001)(40460700003)(186003)(6916009)(54906003)(508600001)(356005)(81166007)(336012)(36860700001)(316002)(26005)(2906002)(5660300002)(7696005)(6666004)(4326008)(83380400001)(44832011)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 17:50:47.6535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 929aad73-e9dc-44cf-20b6-08da2163f84d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2612
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello,

This patchset adds support for two new "syndrome" registers used in
future AMD Scalable MCA (SMCA) systems and also a new "FRU Text in MCA"
feature that uses these new registers.

Patch 1 adds support for the new registers. They are read/printed
wherever the existing MCA_SYND register is used.

Patch 2 updates the function that pulls MCA information from UEFI x86
Common Platform Error Records (CPERs) to handle systems that support the
new registers.

Patch 3 adds support to the AMD MCE decoder module to detect and use the
"FRU Text in MCA" feature which leverages the new registers.

Thanks,
Yazen

Yazen Ghannam (3):
  x86/MCE, EDAC/mce_amd: Add support for new MCA_SYND{1,2} registers
  x86/MCE/APEI: Handle variable register array size
  EDAC/mce_amd: Add support for FRU Text in MCA

 arch/x86/include/asm/mce.h      |  5 +++
 arch/x86/include/uapi/asm/mce.h |  2 +
 arch/x86/kernel/cpu/mce/amd.c   |  5 ++-
 arch/x86/kernel/cpu/mce/apei.c  | 73 ++++++++++++++++++++++++++-------
 arch/x86/kernel/cpu/mce/core.c  |  9 +++-
 drivers/edac/mce_amd.c          | 24 ++++++++---
 include/trace/events/mce.h      |  7 +++-
 7 files changed, 103 insertions(+), 22 deletions(-)

-- 
2.25.1

