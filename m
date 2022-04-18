Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359A7505DA2
	for <lists+linux-edac@lfdr.de>; Mon, 18 Apr 2022 19:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347214AbiDRRrm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 18 Apr 2022 13:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241488AbiDRRrh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 18 Apr 2022 13:47:37 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA0660F7;
        Mon, 18 Apr 2022 10:44:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nW/n9dd2wgyl+lk3o/DPVySiTQWr26dFl2oFIqADePIK00lD27tdf7c00BLSeIQlqvS6XJQd2/dTZu+i93lzAFINUVor2ku24F/Qs7YErP2tmPG2DZ3HaNlO4ITRlUD4SKw7Yy2XtWCODDpgOdztxdH4JVbBvkgmerhFXbs/xTWiCv/UKVLKzKzbSCDrqbJ4yvuHstE6Hmm+nLXOtoA9AgPu1/eOcmeQMkLQX+PZL5E/d0k7wMlFkksZAsP8BNkRUa6TF3k6j23r83GaPX2B6PHqmfeqCqcWOnIsz7Sh4MZ01/Nj7vBP2SQ1EaXbt4pCg6eBs7Y74JHVgGt027Ax9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neYCNoJD3Mp2wV//7N6z9CaSG1EjN4TT6S47BiLXW4w=;
 b=VUnzj5+oifXrS9+fKzFVgxDIpIz3hxvWgyDg2LkjPZDs7oO0bHciDOHcpPA9YHbgaCTh0HcjmO8bsk9vpgk2zZ3v0Qb5xgVrdh2+LVUBAj8B5mexdXjNLyXt0+5aS1B3uRejw9mUFJGQ6/9a6L6DyfsrqDGGAnINzJCNb44jLBee4Z2EORJNseaJpZdbGc4nhLasnZDcI/SfYSriOoDSi0SL3eUBzUZbvvRMkksE9Qjf1Gsn5/buLrPquX/+uprRsF7xNwKcd7C/43+RLG6A7HE8htuNR/6F9iuGjxdisM2fI16ZRPn84v95Zd0untFipxu2sloVzrt5mLJzhiW+Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neYCNoJD3Mp2wV//7N6z9CaSG1EjN4TT6S47BiLXW4w=;
 b=W7NRw/GWWwkyXC8KSIaJvw3xWWcNyQ1Hg7E0ui10epgjldm9FZ0XJqcdZpmdklzqlWLdHheVfErMcrGZrUqIRTwCub5V8FbZ6rHhcs6Byqi4YojU8ZVfa/e78BDp3yadNnDuUK0iS+38BAgteRZDmeDfOeqnNgQGlSxQbFs/e+Q=
Received: from MW4PR03CA0262.namprd03.prod.outlook.com (2603:10b6:303:b4::27)
 by CH2PR12MB3960.namprd12.prod.outlook.com (2603:10b6:610:24::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Mon, 18 Apr
 2022 17:44:55 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::4f) by MW4PR03CA0262.outlook.office365.com
 (2603:10b6:303:b4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.21 via Frontend
 Transport; Mon, 18 Apr 2022 17:44:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Mon, 18 Apr 2022 17:44:54 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 18 Apr
 2022 12:44:52 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 0/3] New SMCA Syndrome registers and FRU Text feature
Date:   Mon, 18 Apr 2022 17:44:37 +0000
Message-ID: <20220418174440.334336-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d2def49-b9cc-44a8-95ad-08da216325bf
X-MS-TrafficTypeDiagnostic: CH2PR12MB3960:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB396030B6C11B74654344EC01F8F39@CH2PR12MB3960.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZMIcSVbj5/nMnBOr5xEiPaHp0oUimPlZpLkk6OOjjC2nG4N/pQDVQ58zUnTuH7s4aiKZxuWz8mgyjuoI37sWGfOST4HVAhqX3H/QlZGl4J35FhtpAosdlisxS8oF9wyG+p5jZxbjzpIAj9k/hIzjGhLuvPIfbhgWexZ2iuC8Vg5tzC6bvIq9WE1WAJg9anGh+EkztX/taUZH7hx/1pF9qYjxO+oxW/dbtE52vyx7FgEBuMtcph5OIjKg5GPn2S0cDckc/HB05eSCZKpAWP/bEJCjDn/KYPX8ybkSKqNjxdJXeTXh8Kzzv8w2lIxvWIxeW6zNIeOPo8JQLsQJ/X36vGhsyXj37nDgFbENO4VJZI3yTpImRjDQ5u+g3GFjfLzwyh7DEvfqHqJjhDkavwJfWl7QFQCj3FkqxppEuVTVTX7ULwTNqsSmUKw/5ariECavcyfbRHsMxbi2RNgVT9EfjEH1JIAMmjiBdGIKhT9BuT8CjgVDvmIs1Bb2nRFZrN7zpeASPIsxxQ/MMD6eRX2NEvDUJimxUf8B2pU6sFeYSmbWN2SdiHdGDmrn2QA5tkkxrWgmriJPX0WntsmHVgp4L6XMvW9jgYxkoTB+6+FAL/2flJCxhQXsC0o27wM7c9PSAOR5mWXFgreQhaYB//+fZ+0BXUBs3rs2lSnjPM2pgWxAg45AjyJ1kHMLjcyBT07T22T8bhUSPjg1hEEiQONZ0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(426003)(6666004)(86362001)(83380400001)(40460700003)(6916009)(70586007)(5660300002)(70206006)(336012)(316002)(26005)(16526019)(186003)(54906003)(356005)(36860700001)(2616005)(1076003)(44832011)(4326008)(81166007)(8676002)(508600001)(8936002)(36756003)(7696005)(2906002)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 17:44:54.3263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2def49-b9cc-44a8-95ad-08da216325bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3960
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

