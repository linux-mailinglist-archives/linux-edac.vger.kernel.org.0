Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F5A59BF22
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 14:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbiHVL6q (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 07:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbiHVL6p (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 07:58:45 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642591209E;
        Mon, 22 Aug 2022 04:58:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIY++qSuHeGXVLevTkOePLS/iCqY9dSuSyucrtIvogwLOsakWDl0LyurPgL9yriM+J8RdHyTrwOfFV1b8iL+hlNkKL/G+HUAQGc06EPaEwsJVoVAR8v8N72VoFxehllzBZ/GkxtcFdCTHKj+0Qr9JLR4VmKX+Cbip8O3ba5+qUBxNvh69FbuMhEmCJvkNUXPx+u4AN969ANe2UwG/sjDIcFnpKIIdbHttJ0eVq1LNAVqmEohtXmAr5JtW+HWBv5iKGKz7bIT69hOjS1KKtZmrUD/jLbK4WOy7k48aWGrLlnS4DDDzL06uRNeoMkSTEixgU72wxcSDEb9V6ab0oqN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WeV/xKU8LrXoOfQS4dpAHE/glNbXml9B9RlsLmi+3q8=;
 b=TReCrVS4qidW8BcuD95ZvDxtXIRGfyIfmpn3wTWzj7IbLNqjNcWaae3H8QcWlXyI3ofX5iAcRl83udoy89z3XTjGwp69NoFAPI81fe/YLNenLvz5kGkvcrpOC8BoUtNKRkqHQb8UD1fVmvqXfPPuO+k58p4jlmjywpm4WrWywUKD0BzStObfH4Et46EuEacURK8quNoUuI99GE+65GCwDqsEzUPWlaJuyp4HAdZZTHALcbJRK3QgxvabSDePW71iJp7NdINi4Gp6wfkVoAfPrThY3wCg8I3xnQf36H9a2GOquLVPJfFE7AdLMi1UxhMkBBqI1zMX5Vto0SoW90IBQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WeV/xKU8LrXoOfQS4dpAHE/glNbXml9B9RlsLmi+3q8=;
 b=MKmq61qYSha2KGZccXNLHj/NY8oxneO+53XDNf0Ni2Zd+aAYS5i9byV3U4UUcB/SyzMIqvBR2SwUiBhoNNhGeXpGm+Vj1mlvAt85fnHKol/NLRaa73REIzNP+tDxiEiYNOl1ls3pMaI2Kwx8P8af0Pp3eSPB/cFC0y1dAh//4Lo=
Received: from BN9P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::26)
 by DS7PR12MB6286.namprd12.prod.outlook.com (2603:10b6:8:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 11:58:40 +0000
Received: from BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::ec) by BN9P221CA0007.outlook.office365.com
 (2603:10b6:408:10a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21 via Frontend
 Transport; Mon, 22 Aug 2022 11:58:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT097.mail.protection.outlook.com (10.13.176.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Mon, 22 Aug 2022 11:58:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 06:58:38 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 22 Aug 2022 06:58:33 -0500
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
Subject: [PATCH v2 0/2] edac: Add support for Xilinx ZynqMP OCM EDAC
Date:   Mon, 22 Aug 2022 17:28:19 +0530
Message-ID: <20220822115821.3907-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f363cf11-576c-4b20-a760-08da8435a74d
X-MS-TrafficTypeDiagnostic: DS7PR12MB6286:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pFTK4sVEz/z2KZHS9yo7CQ4B6RJ9C65/+zZGTHnI8Yh20FMn8tO8JmCWZ6DHnE6FiKmi4TjG16+ye9QUIw82Nfg+S0oDVg+LY7IX2DF70q00mDAxMvUZ/3kimBSI/JPXU7/8Rskgu+ybwzeUP/vOx4iBSw+nDHaC1dlC9BZv7ZINxmNgmS1dbrOQyN6LB1gBn3m3es34vHe1AUefWkSXJ9h62SPJ9qB7kU0vuIvXWSVBnIIW9ReoZv4KDJDQ5Vq4+qSLhGaTDXfg/unW+4Iz6BlSF7bZCO4NOwlnHKkx5qIkGGhFp1/wiFC2ILtfE3tV16eE/btViN/acyON5uhGDokGtkANgYyGOhCCdnMfngK+teJrIgeJvzxSxsmT9XpdaKHEX3P/KOonQfuiksVhA/6Rf80ogU+1Ar3veMDFTirhS0AFzzpSWe7JZPuiKpwqIaOPCpzTZ2pfxb44KYla0vQHxqK8uNeqrLIOzUGQkuU4BYiZcJjnT/tfY7uuo90VjukH4f1XVAFmTTZzkuGiPC8YK4FJBTtuPS5yKvvUj8AaEn47mK1gEkWtX3kPbL9ppCANMOR9sWgzk9QgRTC9aHUTFhQcJe6Wmn5VAwNhiDEPTqr+AZbmcjnDa91UbL3BpmcGe0udDMMNbjWx4lQluVEHEpeY97U0KB407gYNacXWvBlbHIYHfB/rNzQO7rzxI/9jz8jNz4BdbGjYr8V19eJ/tyRTc7BLePIzMcyJLpjjKSHY972nlPRWKqaWu04/4kjDuAOEdO4oR/Rh/nVj1CdOHJnYFBGdd4Tj9L9sDY65iVg59saHX458ZGLzDv7i
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(376002)(346002)(46966006)(40470700004)(36840700001)(426003)(26005)(47076005)(83380400001)(2906002)(336012)(103116003)(1076003)(186003)(86362001)(81166007)(356005)(40460700003)(36860700001)(40480700001)(82740400003)(82310400005)(41300700001)(2616005)(7416002)(5660300002)(8936002)(36756003)(70586007)(54906003)(110136005)(316002)(4326008)(8676002)(70206006)(478600001)(4744005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 11:58:40.0738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f363cf11-576c-4b20-a760-08da8435a74d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6286
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patch series does following
- Add bindings for Xilinx ZynqMP OCM Controller.
- Add EDAC driver support for ZynqMP OCM controller.

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

 .../bindings/edac/xlnx,zynqmp-ocmc.yaml       |  45 ++
 MAINTAINERS                                   |   7 +
 drivers/edac/Kconfig                          |   9 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/zynqmp_ocm_edac.c                | 622 ++++++++++++++++++
 5 files changed, 684 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/xlnx,zynqmp-ocmc.yaml
 create mode 100644 drivers/edac/zynqmp_ocm_edac.c

-- 
2.17.1

