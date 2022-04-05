Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A324F53C9
	for <lists+linux-edac@lfdr.de>; Wed,  6 Apr 2022 06:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348790AbiDFEIF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Apr 2022 00:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573252AbiDESeg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 5 Apr 2022 14:34:36 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C74813F6F;
        Tue,  5 Apr 2022 11:32:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYrH2F9nCHNyaZ/pIuU2C3PCoy/uZVu0EjGMSYJNJgP4S+rMvp/HR09g24MV1jTNyK50iVjrJQQyq0sS0AH+GS0kbcwXHY1L9T+AjRUKYPs66z7QcNNIBwXsNpwWgofGRJxfY1mW/eUUnVXaBzLPjUWBwKYUlM/RFd2PnTOzkmyULc98xJKQkvqz44Gyh9yEi7i6L//hcun5W0TBq/3iCH7hyHas24bv/4PyeGwByyVQsTkAb0rwEsdsTm/ZVHdUxJvXLUToANRGLKnYDwrAIhK/u7q5AXcfIMMMIOhH7FyBqnFieD0Hhxhcmcy1vsdT8d/2JuIpv+oOOa/6RJjBkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIW66FtLtyRL6AQP7SjLFr33sMFJ1cRKJ151pIJvpo0=;
 b=hC7jdwHbQvf1aAUB4pKSyHmkLCUMIEPY2+yD5qEyH3JzTu/jFnOrpRODqen0XMgFEs3/pAUWQpNjz1LBlMDHRHxoosz7ZJOO0/LPR6QOsQjNDIU0OIisMtILBKko2NQTnp11aZkF/o32x+AVozKBNv45tpAXHZJ6R5/5ri2UQPKkPURvn3PELNY/ZSy9+mEpq7ciaoNY+E1r2fsU/kfZq5VeJMSZc52QHgxHMiAKdSjvOd8d6MyYiOKh6a1P6LUNNERWBbbrchlrVsnQKbWl9uRCaz+Jog1lUSHSvWIfnZi50hX0Fnz5xl7OHtvlt70huq7UDaO2iNvXSVzOtNoHLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIW66FtLtyRL6AQP7SjLFr33sMFJ1cRKJ151pIJvpo0=;
 b=nU7TK2zlBTPExkF6jBxivGliOnNInhvlz8xWH+k/TKF0eqMC7FkKsZ33jzJ1eqWSS+dkXbo2dxmT+wQCURy9yN2Udr1InxZi8H1sNve7gwwblUx8107c7vx1K2Qe2z5FKgaS5bEd9BnKv/26rIkQXVpdlPsvSE9fyJTZ/qa4BWY=
Received: from BN6PR22CA0033.namprd22.prod.outlook.com (2603:10b6:404:37::19)
 by BN9PR12MB5065.namprd12.prod.outlook.com (2603:10b6:408:132::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 18:32:35 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::56) by BN6PR22CA0033.outlook.office365.com
 (2603:10b6:404:37::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Tue, 5 Apr 2022 18:32:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Tue, 5 Apr 2022 18:32:33 +0000
Received: from ethanolx1ade-milan-genesis.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 5 Apr 2022 13:32:32 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <bp@alien8.de>, <yazen.ghannam@amd.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <bilbao@vt.edu>, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH 0/2] x86/mce: Simplify AMD MCEs severity grading and include messages for panic cases
Date:   Tue, 5 Apr 2022 13:32:11 -0500
Message-ID: <20220405183212.354606-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49e29d01-8f3f-4920-05be-08da1732a6a2
X-MS-TrafficTypeDiagnostic: BN9PR12MB5065:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5065F2641D366453E83DC678F8E49@BN9PR12MB5065.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: buwXvagm+UZeHzjajuO+s6ILMCnzyy5XCbAipNL6cbQHv6+DIBR6ifJcSaGhwmM8aF9hFJOduWc3Ur3edAw/peGdHzSela0OYlzoZP8PM4j12ep0duZJxqfuJTmMiLU8wauvVwI+puAPwzNe4ClrBuQ9b2LuETy1HIu0UkvJBE7ZSm59AlHNwGVp9gapaOQ/AGgj8l5Ab71jucbcyA6W7VTeijAJGb2vlknEjH9hDR5r8dFnzVdeCJnkBqD7Xlxs3+O6OGb/2PDF+qXv2PnVlD3OhXlvRLGOYPPovFVw9v2DLJBZ/I5ynYhConZcBY5hw9mTl+2MjPcd2PQPzM2aBESr9cblXI3e/L6cUoJeRa6mVHnYsP5eqPgig6MGz1xFTAfJovmkWPj47j14GRYLNZ6XDoJta2vDyzx4/ENl7EiIC/3ICbCK/SKAyCmBQU6jhbLF62e5acX1LD+7b54hUrkwJat7Z6Y8DrhGABr+KjHQNAVAKvItSDbZc/G0kILD0zqnvDRR9hyBYgYvFNZnvJBF60ty+vCkkqXTRcK4gaHbjNIKB7Uu7xPgkYCdLInBsLNJjPJFXMR2MFm43xw15Eay0Nr0ww05S6b+2T7L/PRa5ID9ej+gePr1X3sMZpZytGuYvdCRvrbrZ3ztqhf+Oft1ZpsqNr9nqs4QdvdKNWBlVZy5NEEGGur5yzsHpaOR30YElmskjDOTZSFN8wukkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70586007)(36860700001)(16526019)(356005)(186003)(2906002)(26005)(8936002)(8676002)(36756003)(110136005)(15650500001)(6636002)(1076003)(316002)(2616005)(54906003)(336012)(426003)(70206006)(83380400001)(4744005)(47076005)(4326008)(81166007)(82310400005)(6666004)(44832011)(40460700003)(5660300002)(86362001)(508600001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 18:32:33.7005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e29d01-8f3f-4920-05be-08da1732a6a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patchset simplifies the grading of machine errors on AMD's MCE
grading logic mce_severity_amd(), which helps the MCE handler determine
what actions to take. If the error is graded as a PANIC, the EDAC driver
will not decode; so we also include new error messages to describe the MCE
and help debugging critical errors.

Carlos Bilbao (2):
  x86/mce: x86/mce: Simplify AMD severity grading logic
  x86/mce: Add messages for panic errors in AMD's MCE grading
---
 arch/x86/kernel/cpu/mce/severity.c | 113 ++++++++++++-----------------
 1 file changed, 48 insertions(+), 65 deletions(-)

-- 
2.31.1

