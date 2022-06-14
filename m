Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB7C54B7E1
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jun 2022 19:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbiFNRoE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Jun 2022 13:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiFNRoD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 14 Jun 2022 13:44:03 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36E13BA75;
        Tue, 14 Jun 2022 10:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHV0EmrtBTwO2jpUuSkfVpN0dfCWPJuF0xB77f62DT/QI4FLXqFgH8RK1OGwjK3vnF81CHuE+Z+7RtQYo7AolSsuUGN05hG7cVywuuG3EMAa9cCo5SBoInoTjQDj0x6xnQwXDfZ+Bvoxd/SNjcoedJoQDlwlrYBR9hWL/Tpe5VfbxLOaoC9nxmzvvHsnaB/WADcyXjIh0T4Tdx2ZEv+ekkphPX6ll3BYVYRgKZbZREUqWRFR8wa4On2s1a2emAr3bL3zsiCcU/LaqgXc0mthQuz+lS2jrYgB7p7QxT8+33GN0PLe5W6dDu9oifOdrAaWuEmfLPOKQB0g/OxcfyTAug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Er/WqZdG1KBlOxmlskdZ3tBWKd2HPYl+floCiWEGLPg=;
 b=StDhqpYNO/MoAhw4FeXxQ3GgexKGVKa6ubGm2rtYxwl80Fk9r2mqnc+Uo5fFLst5qoaGfZuHxaMRl0N2ib34aRQp9mCw6A0jBrJt9YmyglpAwAqzxGn/Fht5THfSnzXBZ7aKJU9KCdhT05o0cHefv3dMmHic1g7ejnUP4uu9+vkPzHE0RIXTXiTs6wx30ZqrzMNsFb61MChibkN4s40ZfNndl+PtAM/y8/t9SGJv36ZTmrqBxyJKOoFws8NqUqNmVvNy5J64HpKypxCMp+ow+AApciMTaVkzSlIsrv2vucvv256/kdy8mpNd6rCbKzjTbH34KF4ewBkhSlSEDpTc0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Er/WqZdG1KBlOxmlskdZ3tBWKd2HPYl+floCiWEGLPg=;
 b=lYC9UCUU+GizDp1Ugq7rX9QHH1apFZExmy/4xDc12jsRAzDuIeG3uDMGeuZFlQgeCNx7XxVbDHEcTpMpIU0dbOigQ0BTpjj0yYCNnaETdtuAbWHItXzpG9dMixH2xCmY7cxyrlnGLUrWlRJdtaZEnoXkroe4/oTMMlpQW8g/+eY=
Received: from BN9PR03CA0493.namprd03.prod.outlook.com (2603:10b6:408:130::18)
 by DM6PR12MB3977.namprd12.prod.outlook.com (2603:10b6:5:1ce::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Tue, 14 Jun
 2022 17:44:00 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::9d) by BN9PR03CA0493.outlook.office365.com
 (2603:10b6:408:130::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16 via Frontend
 Transport; Tue, 14 Jun 2022 17:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Tue, 14 Jun 2022 17:43:59 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 14 Jun
 2022 12:43:59 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <mpatocka@redhat.com>, <gregkh@linuxfoundation.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH] x86/MCE/AMD: Decrement threshold_bank refcount when removing threshold blocks
Date:   Tue, 14 Jun 2022 17:43:46 +0000
Message-ID: <20220614174346.3648305-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 561ed60e-4258-4745-035a-08da4e2d76d0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3977:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3977E5196B465E3D51F5B377F8AA9@DM6PR12MB3977.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MOtZks5b5U76uAUIH3Iknnycv+/Avc5MQX+XC4q2d2zCSZGc8BHVMmiWuMVCw0kYc5dHRm0tBJGQ4AHkQYxZiuLL1j9q3ZhbGJePaNBo0K11tmXiZEgjPG4CJhoTOXisJqkzARgr1C+HSHX3LEE3eBMlUfCidFXWyUV015sZpWNC7RSTPXlnnFqVnbFGbE/Zfbm2L83Gpf9ZvAlXzkjJ8vkWFBaQVxeviY9gR0TxiZFiHegD4V6N7oJINypwX05hZNzzntJoYvF9ggfU7XPAUkqT/c0VpbReptkEy/9VQUQUuBJCENtLekEEiwDRAcQAXLhP6oPekK0IT39R280/4VxfhAa9x/GI0bCFHk1b7VYB0kLi4fYra6JA77yiBGuQVaC+YLBT34ebvJ3GIzNRT8iIKKjoh39lGEoRGI3Ck3vyx0EAe1RfBmcppdaXXiCyhIXdnZnSOudI0cPxe8VAusajH7TryaOSNzkqDX5VsZC73CYHQJPgMGC7SR6hxN0oRmWiubheNgS6d+eHewNEfYgMtUMZqV7TQ9EODz/kk0wmm77zuirdAPmqMfoPIyNvRE3RX2L6X3YQibmXzEi8js88lpbbS0Z2bBqRwa3dKm54WJC1i4BqRwLrRW6TvT4IAShqg8Nms2Vw4OB1+urbYz06tnEHw8C3xsWmx9ET1depzyRJpPq0XfItbExxKEMMqGAm066XQPi/i4NuQ/xeA4wbbg7GCPGTf5wXphiJMYjFe3pPNWbktYaf+wZN9O1fzB5Jt72iMcNWqFQNUNjbktYJ2bfMnEaqR6Bxl+O/IEs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(40460700003)(2616005)(82310400005)(86362001)(6916009)(186003)(316002)(16526019)(6666004)(336012)(36756003)(54906003)(1076003)(36860700001)(4326008)(426003)(83380400001)(7696005)(47076005)(966005)(81166007)(356005)(508600001)(2906002)(5660300002)(44832011)(8676002)(70586007)(70206006)(8936002)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 17:43:59.9403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 561ed60e-4258-4745-035a-08da4e2d76d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3977
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

AMD systems from Family 10h to 16h share MCA bank 4 across multiple CPUs.
Therefore, the threshold_bank structure for bank 4, and its threshold_block
structures, will be initialized once at boot time. And the kobject for the
shared bank will be added to each of the CPUs that share it. Furthermore,
the threshold_blocks for the shared bank will be added again to the bank's
kobject. These additions will increase the refcount for the bank's kobject.

For example, a shared bank with two blocks and shared across two CPUs will
be set up like this:

CPU0 init
  bank create and add; bank refcount = 1; threshold_create_bank()
    block 0 init and add; bank refcount = 2; allocate_threshold_blocks()
    block 1 init and add; bank refcount = 3; allocate_threshold_blocks()
CPU1 init
  bank add; bank refcount = 3; threshold_create_bank()
    block 0 add; bank refcount = 4; __threshold_add_blocks()
    block 1 add; bank refcount = 5; __threshold_add_blocks()

Currently in threshold_remove_bank(), if the bank is shared then
__threshold_remove_blocks() is called. Here the shared bank's kobject and
the bank's blocks' kobjects are deleted. This is done on the first call
even while the structures are still shared. Subsequent calls from other
CPUs that share the structures will attempt to delete the kobjects.

During kobject_del(), kobject->sd is removed. If the kobject is not part of
a kset with default_groups, then subsequent kobject_del() calls seem safe
even with kobject->sd == NULL.

Originally, the AMD MCA thresholding structures did not use default_groups.
And so the above behavior was not apparent.

However, a recent change implemented default_groups for the thresholding
structures. Therefore, kobject_del() will go down the sysfs_remove_groups()
code path. In this case, the first kobject_del() may succeed and remove
kobject->sd. But subsequent kobject_del() calls will give a WARNing in
kernfs_remove_by_name_ns() since kobject->sd == NULL.

Use kobject_put() on the shared bank's kobject when "removing" blocks. This
decrements the bank's refcount while keeping kobjects enabled until the
bank is no longer shared. At that point, kobject_put() will be called on
the blocks which drives their refcount to 0 and deletes them and also
decrementing the bank's refcount. And finally kobject_put() will be called
on the bank driving its refcount to 0 and deleting it.

With this patch and the example above:

CPU1 shutdown
  bank is shared; bank refcount = 5; threshold_remove_bank()
    block 0 put parent bank; bank refcount = 4; __threshold_remove_blocks()
    block 1 put parent bank; bank refcount = 3; __threshold_remove_blocks()
CPU0 shutdown
  bank is no longer shared; bank refcount = 3; threshold_remove_bank()
    block 0 put block; bank refcount = 2; deallocate_threshold_blocks()
    block 1 put block; bank refcount = 1; deallocate_threshold_blocks()
  put bank; bank refcount = 0; threshold_remove_bank()

Fixes: 7f99cb5e6039 ("x86/CPU/AMD: Use default_groups in kobj_type")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Tested-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/alpine.LRH.2.02.2205301145540.25840@file01.intranet.prod.int.rdu2.redhat.com
---
 arch/x86/kernel/cpu/mce/amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 2b7ee4a6c6ba..680b75d23a03 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1260,10 +1260,10 @@ static void __threshold_remove_blocks(struct threshold_bank *b)
 	struct threshold_block *pos = NULL;
 	struct threshold_block *tmp = NULL;
 
-	kobject_del(b->kobj);
+	kobject_put(b->kobj);
 
 	list_for_each_entry_safe(pos, tmp, &b->blocks->miscj, miscj)
-		kobject_del(&pos->kobj);
+		kobject_put(b->kobj);
 }
 
 static void threshold_remove_bank(struct threshold_bank *bank)
-- 
2.25.1

