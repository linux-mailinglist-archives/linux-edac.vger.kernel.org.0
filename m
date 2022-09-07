Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1B85B029B
	for <lists+linux-edac@lfdr.de>; Wed,  7 Sep 2022 13:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiIGLPv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 7 Sep 2022 07:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiIGLPu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 7 Sep 2022 07:15:50 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5CA804AC;
        Wed,  7 Sep 2022 04:15:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHmlC63JEO5Ox8Rd8Jv9luZYQTQIsKVaJ7O2T2qMP6rDPHgfRyzzqVGnp0Na+68ILbX+miE+2N+JUvyaBLUm5e1yxc7zUuNJsbYSEv5XfwTWoSIp+mVbTQr0JwFxZcw1uD/RBXglcWStNdy6RNlnwoGOYAu8OtgUhpW8LMea+yBmAmJvgtJ1TNjX/htLE/sKJ4Z8WVfSiZm2vPCdKVvrtj0lTiIm7mj3vPAbKo11pCts7PACtORWXNM1gr32woATik8LdJmBBwOoSseNo+XnZdtCbUj7mw+gyb0NZJGG/K6po7xCTo6dmx8/MJ7+QApj0CScDlnHFT+ad7QjDjfOwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7atuUSZRiqNs3iLE0AyVxB2Yzs56T+ZzjINIcgyfNO8=;
 b=PbnWE9bDGaA/OqdjVloUWRRq1mobWu1q5t2CNRmI1ntWsPsEWvB8BCC8iJCt0jCloNftLTRFGYAhjfn+M/z72t42ba0Gfh3F81jd0gmsnhpTbKxKOVjEzc/UjiXBkox2M65/efhYhWgNNpAdFYDIVShEWidQcjYnsKHvK0EcyY0/rmMp8nVv6i/k4+c1V3ansVY5NecciiFI2cKYu29S8yDNTLdXMvlyKPKZ+DWY6gqIFa1EaCvHoxYbhdRrAeCnYfnpCqT51L5BAArddXaQnu+YwHIPX2wQeterLJesZX4CtT/G2ffan+5Mu/89vfuL4rcFHnL96P3ROLQAogcgkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7atuUSZRiqNs3iLE0AyVxB2Yzs56T+ZzjINIcgyfNO8=;
 b=FL5DF4Jnp4GV2Sfrn322ZGkKCkWj5YdBO4mA6UXQ2nfaLmtDJiN/dPLded/7jW1JHAcAv/avtkNqBeBpwm55X+axwnVZ9Y8lRuMJ3vBSYhpP0R2cE0mKdU28ZKt0+UgXoFN4z+VAz2sEPWDoxjxlgcpfYo9pUktFHtKDdaZSVno=
Received: from DS7PR05CA0098.namprd05.prod.outlook.com (2603:10b6:8:56::8) by
 BN9PR12MB5366.namprd12.prod.outlook.com (2603:10b6:408:103::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 11:15:46 +0000
Received: from DS1PEPF0000B078.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::52) by DS7PR05CA0098.outlook.office365.com
 (2603:10b6:8:56::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.5 via Frontend
 Transport; Wed, 7 Sep 2022 11:15:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B078.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.11 via Frontend Transport; Wed, 7 Sep 2022 11:15:46 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 06:15:41 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 04:15:38 -0700
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 7 Sep 2022 06:15:34 -0500
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "Robert Richter" <rric@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <saikrishna12468@gmail.com>, <git@amd.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH v4 0/2] edac: Add support for Xilinx ZynqMP OCM EDAC
Date:   Wed, 7 Sep 2022 16:45:29 +0530
Message-ID: <20220907111531.703-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B078:EE_|BN9PR12MB5366:EE_
X-MS-Office365-Filtering-Correlation-Id: c8072b68-b7dc-44f1-6ea1-08da90c24fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DN7ELpbe06WXiCiVoZYSTcSsVyQ1Kj5zug6sN7zGydtJOsnNosrXErphg8P6GPOLNrBXy2pE/6mN7hibjjs+aparSXh2Ln7F5HzY2EH21Cmqsgko8GjhsgkwMLth8+LM0ojTb7Lh+ImGOVT1YBVPEVaK2tx1PmcDisPwbjjrLUnu5fo5fZdh7ZG7nrt+Ytuc6CQ8jJUb/4JUaAbLHbyPw9kgVDjuq7SlLSDoEBI6N3pAfE6j49RNI4QKGwkCkml6EAD8r6b7np3wMcBoghNGy8ZJXC1AgP2a3eqagqzvIaYlB2hH8hVDkViZ6XIpgYVNMKrM7xn5vVkp4BlNYQH97r6uBqKIGxTMV7CGJjfHxKNsrYoYcNZvH3WFVg1qtSAxhbhbMYgMxxWun3nSRWwLnD29k5WdOdPLf+daqe9nCYtaRkPiVFiXQWNa8N/F156kakeHuzD0eWsKbAgsIC2sAOecaOP1VLLHo7nI9O1C/kCGkRifsP9AVGorE1jgZulMcdbP9QQBJhr9TlmBdNSG8IkeM1DI1oV+9BEBaGZpiFHtbx6tl5najfigGvUWPfWs0bOp4WLuNatLmTihnuSIZcOp/aw4CXJfOUyqA4VXYmF2YPnotq3v8Ga2HIrhbHHt0FIHOuUMbW0VJRewZKyDJFmp6OADH6wS9LMfgxJ4J9ilscRHCjyIuZwoLdeGYQkWODL1687sCZ0xmSyHfO1j2iXmZP645FarFrafA8HWip0ISm5pUVSnufrZMAmH+46tXMQelZ1oC89GR/cOonsjviQG/A4pSobrm3rrEIaoxKcBvx4BIPCdT2+s/kGajXsJ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(376002)(396003)(40470700004)(46966006)(36840700001)(103116003)(36756003)(82740400003)(86362001)(316002)(70206006)(70586007)(4326008)(8676002)(81166007)(356005)(36860700001)(47076005)(83380400001)(426003)(26005)(41300700001)(478600001)(186003)(82310400005)(6666004)(40460700003)(110136005)(54906003)(40480700001)(5660300002)(2616005)(2906002)(336012)(1076003)(7416002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 11:15:46.3023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8072b68-b7dc-44f1-6ea1-08da90c24fda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B078.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5366
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add binding and driver for Xilinx ZynqMP OCM controller.

changes in v4:
-> 2/2 - Replaced \n\r with \n.

changes in v3:
-> 1/2 - Moved the binding from edac to memory-controllers directory.
-> 1/2 - Changed the file name to match with the compatible.
-> 1/2 - Used additionalProperties instead of unevaluatedProperties.
-> 1/2 - Used macro instead of constant value.

changes in v2:
-> 1/2 - Used define for interrupt flag.
-> 1/2 - Updated the description and title.
-> 2/2 - Removed Kernel doc for probe and remove.
-> 2/2 - Used COMPILE_TEST, used wrapper for get and ioremap resource.
-> 2/2 - Fixed few comments related to static variable declaration
and print statements.


Sai Krishna Potthuri (1):
  edac: zynqmp_ocm: Add EDAC support for ZynqMP OCM

Shubhrajyoti Datta (1):
  dt-bindings: edac: Add bindings for Xilinx ZynqMP OCM

 .../xlnx,zynqmp-ocmc-1.0.yaml                 |  45 ++
 MAINTAINERS                                   |   7 +
 drivers/edac/Kconfig                          |   9 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/zynqmp_ocm_edac.c                | 622 ++++++++++++++++++
 5 files changed, 684 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,zynqmp-ocmc-1.0.yaml
 create mode 100644 drivers/edac/zynqmp_ocm_edac.c

-- 
2.17.1

