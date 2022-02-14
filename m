Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713A44B5E51
	for <lists+linux-edac@lfdr.de>; Tue, 15 Feb 2022 00:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiBNXhG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Feb 2022 18:37:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiBNXhF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 14 Feb 2022 18:37:05 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AD9113AD0;
        Mon, 14 Feb 2022 15:36:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLAMcde3sQK+vXa0Jg25q/eQcmDru+/3CdzvvKxY/80LNctMvd1ppjWnlFfzbwt0L5KCd822FCyoov9MqiegnwqFOxd2gJmJ3pH/vPdhQmivN2WoUCBc3xUXbIX35KCT37/0axg7TiVHXdRKJUEpm9Bi87o/P+EqaHX5oEOb+vqLD1z2BBhUafEYb7r8q6EgMUmIpiETc7pysZwzcxSTZM24pbHVgiNnke9hY7xthyrQbxwJx8cCYBjdUTsdq2BqrXVgCRvVjntvsuCnEoszESwYwMwmY4ybImqoUDZMGCOywTEFCwhuEp1FywqMwojEzVeDKcRcnrAQUcNcdO6Fug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRu18LNznql3VdxQHphONQbka39Z4b/Xd0dHBKzhSmA=;
 b=TG1ZTowjSIsz19F1MRqg/DXP4iBSmJJc/n33ezlJ5D9LOIOU9qF5eXXPbZUJviGyDQ1gqizrcFVQ+Kv4nk0KzXk3lD4w+cy0KuxNRXOQHCo6C2XTZJo0YXKYV+9o5fK3Qqi8RauKJnb6793xUTAQl0u2CMRC9kuf0PyCi67p453+GWS4TAZvsq1RYnW48RVE5KcmcFPcY/R42xG8lsCnls/FZ+UCeoo2emA0dpbrb8Uocc4uoP6sjQDpkTjFJxNY7aq3zGyKm5anSgVsXeA2GTrNcCcLe6adyIE/6IzuqSzkbydFzyFXWDckyiWsSiQ6FG2zhBobmGhV0f3pyYfoWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRu18LNznql3VdxQHphONQbka39Z4b/Xd0dHBKzhSmA=;
 b=HQlihoKyaQSnBCeM7IyWaTcAiSt/uAiWL5Gbxil/F6pqMje2TzchDPYuiiq2WeX5ZPEAvXbRpZxhdQxJJulCaazBZ1GrkZt8/Q1usa00cgYzjVlXzwQVXEdDjxufFTByZ+3cR+ALPvNmID1iHDxjIYIe4D0o8gCpE53HECJb0CU=
Received: from MWHPR13CA0009.namprd13.prod.outlook.com (2603:10b6:300:16::19)
 by PH0PR12MB5499.namprd12.prod.outlook.com (2603:10b6:510:d5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 23:36:54 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:16:cafe::1c) by MWHPR13CA0009.outlook.office365.com
 (2603:10b6:300:16::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.6 via Frontend
 Transport; Mon, 14 Feb 2022 23:36:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 23:36:53 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 14 Feb
 2022 17:36:52 -0600
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v4 0/2] x86/mce: Handle error injection failure in mce-inject module
Date:   Mon, 14 Feb 2022 17:36:38 -0600
Message-ID: <20220214233640.70510-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c855095-5115-4c58-e4e7-08d9f012e203
X-MS-TrafficTypeDiagnostic: PH0PR12MB5499:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB549937BDB8F3B8B07CED794590339@PH0PR12MB5499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /jLpnOENcWxQFx1WdKh2DriewFqVeEKJ1Ne2qNwsAof5xcnJJwNzRN7SmGNV5GI6+tI/yg+gKMDXg/viZG43ihrG1CHFj3U6hG0HE74KBQUreaVyje0w9u0rMkHKkQ10SAZUkb11OdNoVs9iWP5Ea1DHLwApmPEIr6EMdbIYKMwAvfUriX66bom6MROekxx42Im/B+T3lnpCqfvzEDbo481BjpbFR+3OMzenv+kdpy8WA0Sf/NjrmqboM5sSdcAOHYYICxeY0p/BUmnVc4gAgDDwFMh01/7W+gdT5n4A+ov8t0ZGWhYmxio3QtzLz6Br4FGs7WGgU/usJdhtFnp+rJ72yUPfUa65xWNYAC4NjV3LQO4d8jdNb/K4kWtRiBKPjdrfksHFq5nCliAeXNdTkJ81TNsg3CmnFRbqeHqCI7J0ty/qU6IWc55J7Ak+umBU6zgk5ogJGx4F1zQwa37Sm01G7VjA5G5kyqG5tDsINfoS3qApj6/M1mAwJt52kEwMdR+BCxDabv6ZNU/rn9NfkLWIWlAXG4Fy4n4QksMraUSUvggWp3GLqynMvPJ0CrXzi3GznEcn6cQ3lwenkuqrGcZHxIJG6zXJCm9fJMJ5+MK3OJ8FnlT0lHXGiQVJQOvTFBaRyRMhhpQAxWQEgezKp4KAxZ6saU6BQhau1JRjXJvLRTFrJ50o/Mp+V+GuHlM43Mn8J14l2LZrpD7rs0a9MA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(7696005)(2616005)(70586007)(70206006)(8676002)(26005)(1076003)(54906003)(110136005)(508600001)(86362001)(6666004)(82310400004)(36860700001)(316002)(81166007)(356005)(83380400001)(16526019)(426003)(336012)(4326008)(47076005)(40460700003)(8936002)(36756003)(5660300002)(2906002)(186003)(4744005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 23:36:53.5994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c855095-5115-4c58-e4e7-08d9f012e203
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5499
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This set of patches handles a scenario where error injection fails silently
on mce-inject module and returns appropriate error code to userspace.

Error injection fails if the platform enforces write ignored behavior on
status registers and the first patch checks for writes ignored from
MCA_STATUS register and returns appropriate error code to user.

The second patch assigns and returns the error code to userspace when none
of the CPUs are online.

Smita Koralahalli (2):
  x86/mce: Check for writes ignored in MCA_STATUS register
  x86/mce/mce-inject: Return appropriate error code if CPUs are offline

 arch/x86/kernel/cpu/mce/core.c   |  1 +
 arch/x86/kernel/cpu/mce/inject.c | 42 +++++++++++++++++++++++++++++---
 2 files changed, 39 insertions(+), 4 deletions(-)

-- 
2.17.1

