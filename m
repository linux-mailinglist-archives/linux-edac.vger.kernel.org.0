Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0D572E569
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jun 2023 16:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240668AbjFMONE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Jun 2023 10:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238289AbjFMOND (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 13 Jun 2023 10:13:03 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925371FC3;
        Tue, 13 Jun 2023 07:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mg4++6yz0JIMbKNyG6hqEIri0rVp4t6IQuqlS9xX9Qanbbe5aVf22Iu84FUQEDdksMoqvAXZhp4QO/a9U34dRXE4YX/IkSo1uFhZYYi0dOVhtQn23RMIbiydpLmDohIoXNn77U7Heohd5T4zWEDmkOe4vVtSLXOeFFBHrG0il9yvL9t6k2F0L/I7WdxJXTChJkBR7BU5sTMr1rJd/lZBJfs9eD4m4WuoZzgF8Tjyt0431qZ04YYc/gO2FLsCnfPVxBkPjL8IzQ2/lBFAaXAfS3jqcMo3Fs5TNmjEB0IApoHR7U1u1aDiXJiIlnintd8n4XQe9W+F7sQ+P6NNv9L8Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60jYGvoSTLHO0+4pmWO0tRgkmjg/WJ3cN3rBglZy56M=;
 b=FuqDH19hFZKrFFXgBmXZtXzyunDDTo5HGRsLG4cGzR39eBgJZ+y9Q9XJJaB5ykzPW6QbwRgRX0oYD+UYhPLVm/clHR/ENk08g0Ecg8zHXq4ldoTauR18Cc11oyPAf3UcxUm7nWl3ZLZkGOhf7/wR0lYZGvxFUDlLpPGoleD/xbcYsIj8+qmD94fI3U5n3kiR78b8/qwTt4avUUmQ1SenVP8ixZMW2j7HAxS6vitBCfQVw4zV+VRonMlYmdSS2J6LKAdW3WvqABv+7/vNd7r14uJ48q3NG3uZTANa2l0dl+SHHhWyNVUEfbQIGvMQ89IKoLrSMnO5b4htEoPlQup2xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60jYGvoSTLHO0+4pmWO0tRgkmjg/WJ3cN3rBglZy56M=;
 b=EHsOCt1p+RfVJcxnzahyjavVv7nSw8kA0z4bx5tDqQwqZ37YI09ckmovGPbO8Xe+nFAlSxAHQfRREupM3W29gfdlgEpzs/tmQTN8OuetP/YZ8tD39Vn5cnDYJLHU7sgziO/iC9xYi26i9OPgmNhMl/BXluCiFrf3xsoz4MtYVUc=
Received: from CY5PR15CA0252.namprd15.prod.outlook.com (2603:10b6:930:66::26)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Tue, 13 Jun
 2023 14:12:37 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:66:cafe::2c) by CY5PR15CA0252.outlook.office365.com
 (2603:10b6:930:66::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 14:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 14:12:37 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 09:12:15 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <muralidhara.mk@amd.com>,
        <joao.m.martins@oracle.com>, <william.roche@oracle.com>,
        <boris.ostrovsky@oracle.com>, <john.allen@amd.com>,
        <xueshuai@linux.alibaba.com>, <baolin.wang@linux.alibaba.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 0/3] Properly check for usable addresses on AMD
Date:   Tue, 13 Jun 2023 09:11:39 -0500
Message-ID: <20230613141142.36801-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 95938367-6fe9-4cf0-5d2c-08db6c183ded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zWnEW3f368KRJxY0GPy0U0fjz2qXzIUlfYdv2ScJenERkrjD6WwVXbUX8AGBM7+2HNcMaIGl/3Jq5ue/NVogvnXIOWOxk0s4aV4BrXThBFPauBPcxwhilj87WbbrPTx8YrsVtJW1EVCpEZwwL1iQ+Qtmqws9ZVf40hdJwJr23FrrNlnIGdknF3Ee3rbI+uQgT4NBE+D3tm0CEdumK2K+7z/4zj/Ba0CGEVsllGTwG44dYxbuH8wheWwO/NvsbkqjI5EQl5E3RspRuXC5PqqS0Gy/ULaOMpVuVO6s9kATQSvSwDDfcdSaG05D3TRaGStr49u5woUf8Dcs6uAGA9CE9MfntiALVU6wO12hwrECGH3xP4e/13KRByCtQj3khRZmph1Tr/3h+P84ssMktEkcVlS2q0J496cmSfqlWIomCkwt0wh0qXcEPRTk1up7hG57iyTaITey2MC2nPc8fdlgQQexL2xjiGteZvn5gJfBdC9xLZeLF46nMNZY6KDCMWNiUA0kYe7eCTVn0FPs0E0c79Rv6oQAFK/kIQ3d85uuQs0bMEpZzy/y4GqqzLyOzC2ngpCr0hHHgxP3hgHnzPHhuGS/bO60xPiqKDbcyehNb9QJRZUVi90GYgUbxy0OX1znjCSr+cmSUv0MxxAXb1bvXNa9KLZJsIM4qWi7l4UVUumlpUQk7uWVHYRUHVWnqq37PckwqQQn9dbOjSq1I3MdB+IbTQYZWdA39hAd8VgiHhNCHvuSL9Bwm4bhqovz6OcPyGzKI1bPPyCGHa6dS2tMNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(44832011)(4744005)(2906002)(8676002)(41300700001)(5660300002)(70586007)(316002)(6916009)(54906003)(70206006)(4326008)(8936002)(6666004)(478600001)(36860700001)(82310400005)(7696005)(1076003)(26005)(86362001)(16526019)(40460700003)(83380400001)(2616005)(36756003)(186003)(336012)(426003)(47076005)(82740400003)(40480700001)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 14:12:37.5944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95938367-6fe9-4cf0-5d2c-08db6c183ded
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi all,

This set adds proper checks for usable addresses on AMD systems.

Patch 1 creates helper functions for memory error checks that will be
used in the second patch.

Patch 2 adds the proper usable address checks.

Patch 3 restructures the current usable address function to call out to
vendor-specific helpers. 

I don't think these need 'stable' backports, since there isn't an urgent
issue to be fixed. But I can include 'stable' if there's interest.

Thanks,
Yazen

Yazen Ghannam (3):
  x86/MCE/AMD: Split amd_mce_is_memory_error()
  x86/mce: Define amd_mce_usable_address()
  x86/mce: Fixup mce_usable_address()

 arch/x86/include/asm/mce.h         |  2 +-
 arch/x86/kernel/cpu/mce/amd.c      | 68 +++++++++++++++++++++++++++---
 arch/x86/kernel/cpu/mce/core.c     | 32 +++++---------
 arch/x86/kernel/cpu/mce/intel.c    | 20 +++++++++
 arch/x86/kernel/cpu/mce/internal.h |  4 ++
 5 files changed, 99 insertions(+), 27 deletions(-)

-- 
2.34.1

