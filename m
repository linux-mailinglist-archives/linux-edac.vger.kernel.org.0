Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00F3520083
	for <lists+linux-edac@lfdr.de>; Mon,  9 May 2022 16:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbiEIO7s (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 May 2022 10:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237860AbiEIO7r (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 May 2022 10:59:47 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E7D195E88;
        Mon,  9 May 2022 07:55:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0hzlWkgp/Z4aV6jSOZ1VfLtMaf4wl9VSLvuS7xGcCJjzz4OSNBDAiHLEAAq0sUhTDqPdIMX7nlJ1EiB20nZIDYqXFjSeF6MAjm+tII0veIDBS+l5zZwP0usmzbFFacE6qWaCYUZF7Lf30mcXFZ7mCef8H6WiK05lvU71AQ0AbQYFw+z5dLQe73nD55uwNXw6wtN/pyygQcCWjeSGVLpevlAGp9fgylP2rnHR64SVq+vmtjSd+DQ5cCK5df+LoAHJKHVd54E/vA1dphrM2s3oWalV3hA4MVbHFov+shFBm8iMm/n1KZVtnDhEHYNDOOsKN9f9/Z+nba/bxs5IWePLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POg79NfO9tYZC/zwzNPVwIkmzCH6eFTJvhBQsrUaaeI=;
 b=SquHOaYdao7ntLyT2qNmpSygXvWG2G/d6VYuLUdBg7R/8rRciP7t6bamJtkytwSYoxQlj7+RK4YQkeC3QEwzmjwLPy4quEN1tmImGOEBuyQpSnVGUK0Y5bnnyICgBHef0cp4e+2Kp9eHZMfECiGhbxTJUjjyzPnK4gaZQHitjTIaIXmLPtjtDZ+j6jeC2ZAUMLFAEV1wYg2wVdjLk6a9A2c1DW79NWctBc7MfLdnCY0DjGs4BKEmind/+SHp9q17QK8hl/aXAJBcGpPoFP2XHpf462MrE7536WDt8Al7M8tI4nkOUD3AeZwvM91VSyduY2vJrMmA1hXu9tXMajHNfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POg79NfO9tYZC/zwzNPVwIkmzCH6eFTJvhBQsrUaaeI=;
 b=11BWlknP4RNEljQQGagiVwjV6H2HV8Z9TKIcIGCqw1fV1Pz0GX3rl7McgzJF3djuTcguD9xIJz0/Id5T5ViSkHT5QzTP+LZu9rOtNZilKWqOax+3cqowaQX13PthH8UKhmp2p+MSRvDkCnBrH1Glk0alOF+LL3/ue6CxcisbYhw=
Received: from MW4PR03CA0309.namprd03.prod.outlook.com (2603:10b6:303:dd::14)
 by BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 14:55:48 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::28) by MW4PR03CA0309.outlook.office365.com
 (2603:10b6:303:dd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Mon, 9 May 2022 14:55:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 14:55:46 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 09:55:45 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <Smita.KoralahalliChannabasappa@amd.com>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 00/18] AMD64 EDAC Cleanup and Refactor
Date:   Mon, 9 May 2022 14:55:16 +0000
Message-ID: <20220509145534.44912-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1149f0af-383c-47d6-2607-08da31cc0012
X-MS-TrafficTypeDiagnostic: BYAPR12MB4597:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4597DE9E188FB1B1235AC807F8C69@BYAPR12MB4597.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jSEYTF1qbkmG1QvHVZ5UGhw4YuC8GfEOYoSxMqawZmGBNVKjb3dcHLLJ/stS+U/gr0AMk+NvsN2bSHedWlKhvRA3Z9hOPUDP4UwBjvnSOe85HlEkX9uzm0yJ+Vv/4i+256qqgzIZf6NnAGCAop23pp1hnIq5KqSj7y5PFsK3nF3XJlHIDzTh52S8tyGywEW5hXjOoVSSSg+TTD0LpJQLEpYg2ZvYU2NqgpjGeIipJvZ7gNSY3olNK39hzY+R4QbWQgPVu28Bfquf4mjqp495a5bjEu3ChZjf5TarI21a1ncWAIzvTeAsVjEElyfqi1H7BEvg2f4DFjwcOQdY02lcZV7OIdgPnbzULPBzKVmY/uumvH+gSpbNj1FC4veG8nVECUQQ/uHvH9/ewhBoxmlUcH0/uvXlRpZV5LeaK89iG/43QdMkXPZjaVIYsY7+xDokt/2JPbHceNhJ/lJWOfeWmCWV9K1FzJOb5VaG8YXx8DvRbgj5dyn0Jhp6Rpl7umWAXmRKEGF9u3KcZkJoyZReGvHV06gZLvNMfqfcinY0Ac32GElBEFSTGQ2182r15wS4JPHK9UtAjqpISAQMpHSFrh+ACrptxn8l0PTU/0m/aW0+1yDPtioHf3ydrSxeY1avaGGl0imxRa8OSly0GWfgolPYWIxtzyvIQtJl2JmcJdaZlHPgwtLksaRxH8IdghMPVPsSNJJ7pu2Rso1dTCVxOC/M7DFmkih3QmAaDEom5UQDsJg0sVi82zxlZtEVmxU9y+JW8h8gy3p4Yrw+tVR6E6OTGtA8EzgLAN69AqIwKM8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(426003)(44832011)(316002)(70206006)(966005)(47076005)(70586007)(26005)(6666004)(7696005)(186003)(81166007)(16526019)(36860700001)(2906002)(110136005)(40460700003)(54906003)(8676002)(4326008)(336012)(508600001)(356005)(82310400005)(2616005)(83380400001)(8936002)(1076003)(36756003)(5660300002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:55:46.8750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1149f0af-383c-47d6-2607-08da31cc0012
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4597
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris,

Please apply this set of cleanup and refactor patches.

Patches 1-4 remove unusable and useless code for Family 17h and later
systems.

Patches 5-18 refactor a good amount of the module code to prep for
adding GPU support. Initial patches and review here:

https://lkml.kernel.org/r/20220228161354.54923-1-nchatrad@amd.com

After reflecting on things more, I think the best approach is to split
the code between modern and legacy systems. It's possible to redo some
of the legacy code, but I think it's better to just leave it as-is. I'd
like to avoid introducing new bugs or changing existing behavior for
legacy systems.

Thanks!

-Yazen

Muralidhara M K (14):
  EDAC/amd64: Merge struct amd64_family_type into struct amd64_pvt
  EDAC/amd64: Add prep_chip_selects() into pvt->ops
  EDAC/amd64: Add read_base_mask() into pvt->ops
  EDAC/amd64: Add determine_memory_type() into pvt->ops
  EDAC/amd64: Add get_ecc_sym_sz() into pvt->ops
  EDAC/amd64: Add read_mc_regs() into pvt->ops
  EDAC/amd64: Add ecc_enabled() into pvt->ops
  EDAC/amd64: Add determine_edac_cap() into pvt->ops
  EDAC/amd64: Add determine_edac_ctl_cap() into pvt->ops
  EDAC/amd64: Add setup_mci_misc_attrs() into pvt->ops
  EDAC/amd64: Add init_csrows() into pvt->ops
  EDAC/amd64: Add dump_misc_regs() into pvt->ops
  EDAC/amd64: Add get_cs_mode() into pvt->ops
  EDAC/amd64: Add get_err_info() into pvt->ops

Yazen Ghannam (4):
  EDAC/amd64: Don't set up EDAC PCI control on Family 17h+
  EDAC/amd64: Remove scrub rate control for Family 17h and later
  EDAC/amd64: Remove PCI Function 6
  EDAC/amd64: Remove PCI Function 0

 drivers/edac/amd64_edac.c | 756 +++++++++++++++-----------------------
 drivers/edac/amd64_edac.h |  97 ++---
 2 files changed, 331 insertions(+), 522 deletions(-)

-- 
2.25.1

