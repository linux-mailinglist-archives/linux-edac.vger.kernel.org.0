Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7937615E29
	for <lists+linux-edac@lfdr.de>; Wed,  2 Nov 2022 09:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiKBIqR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Nov 2022 04:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiKBIqP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 2 Nov 2022 04:46:15 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0514727B02;
        Wed,  2 Nov 2022 01:46:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coMzgRNP3/E+zTrUJ3ClK9r0+/cM23EJMobCkNJ+GQeUpZhuWhuyC0vLMuMtQDJh8eIjqXPk7cW+KjJ4wE8jwcUuTg9KXeYI9L3apqY+TRvsKX8KP4Ej5Q8fz1tGissrAziPbVvEzMUGnYQNXZzsg6E5z9a54ljM28/E8Jw82Ma4YqxlHfuT0HM5qM2QDGvv8kNmHxGgAs8CvsccVSb33RZ4/4BiP28EgdCCFuFY0yHHWqU2ahjVau8pRgrTTINreoLm1tzISOynHPfUIUhmKgjkodzm0wkykIYaDIrdYLYy31v/CXjFUvsvj2a9SBPzBkoVHYqfYXpYaCwXCFomlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ihf8iYoFjYFV2LJ8GMolub9sNBXuyZu5UN2Kf65ECW4=;
 b=TyXliLsAUUofQUmEgaquHQqyVRw41YCh5yD6pHFbMDdCPqXdAvZXjXbO5kIqsPA23Vwa3zbWAN1O/Ou5tmqZsOo51hOXlxpiHqhMOKhMdI5H1On86kJ1Rm/7Q1kPaDd/eZmBqjWfrQiLCZz1Th//IdFaSVGsq+XB4Tw5BSP4ogiV4V+h8Bo1lt6iR/xayVe9DKmwYwKTjH5k/PlajpAkJztMpp0ChJnwXYuqBPzvXgLKJBdlOlUMJy1jiEdY/GiHQ/Pif04nLTgIhrmr6ORn14DVt1MNEcFhJO9wf4afP5I/COJyNKIw/FpblvF9IXUXzOfUkv/vtzWGK9+MLk6JLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ihf8iYoFjYFV2LJ8GMolub9sNBXuyZu5UN2Kf65ECW4=;
 b=DBG7bKKAHeNKAf4PZTd/bNsBz6P+hlFELZG19UDXFbSxnyezCWFMFlGg46fiDrzmA1J05yyWuNGAkqK1IRccCd7bRglKYJe2O9t6CWMxGK1xdBz/BoZ7oB9hYTVIDDBiJgTD3ma3x1Qjdul5XI1xfv2EZYQ2+g9YFnKWoyio+mc=
Received: from BL1PR13CA0103.namprd13.prod.outlook.com (2603:10b6:208:2b9::18)
 by CH2PR12MB4309.namprd12.prod.outlook.com (2603:10b6:610:a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 08:46:13 +0000
Received: from BL02EPF0000C405.namprd05.prod.outlook.com
 (2603:10b6:208:2b9:cafe::7e) by BL1PR13CA0103.outlook.office365.com
 (2603:10b6:208:2b9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Wed, 2 Nov 2022 08:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0000C405.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.19 via Frontend Transport; Wed, 2 Nov 2022 08:46:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 03:46:11 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 03:46:08 -0500
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <git@amd.com>, <devicetree@vger.kernel.org>,
        <michal.simek@xilinx.com>, <rric@kernel.org>,
        <james.morse@arm.com>, <tony.luck@intel.com>, <mchehab@kernel.org>,
        <bp@alien8.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/2] edac: xilinx: Added EDAC support for Xilinx DDR controller
Date:   Wed, 2 Nov 2022 14:16:06 +0530
Message-ID: <20221102084608.28894-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C405:EE_|CH2PR12MB4309:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b3f5e92-d703-4564-2704-08dabcaeb275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4pqqYs0qBR+an0ChRDIEbj81IaSquENQzfle+YrfWeGXSOVlNR9egMOrFv2/e6TId2kBkT5JjOHWbKTfX/M5QKw0E+E0vaTFErKGg15FKbBE84A70B4s7Llyvm+IC7Tecy6na95UhtN7bc4JWRWz8XwsP2KeO7sFg8pcjnPSIguF3tQDlKBNujQQgvhioweRzfE/xGtawJkBRGLJx1BC+tCAEG20AV0AnCFeWs2bNFklihfCNFEcLjaYV7hs+E9Vn58gX7Agsc3QYHoU7zNlHAR5GABTVRQR25hAeMtow9xV089977pAEDvy7ssFdn63WVXvKNFCYK7CKtcuFHh5rNzLGQ5vBnLpyXPIgadhVbNrEMw92FttvfqWX+5r1wOtPB3oOesNpMVsTXP7bOXjtSuXTLXEMhoN4IElzvc/wEfM+1A4Ka2HFRWD03Z565AjogrMFbZFrEksF9m40p7RNIO8PQF8xHadntFLXPrXq2vF0Wcb/qKEygy41hI3JEQ11U1SJ6at5TfeSl028Spw6xWzTiBgDZOCUs0d4c6bhvAyPf8JoHaZVjtGQrTB7g8I5ygFWvlEG5jlM+pCkMROdbzDUXRm3F+DisWifarS4p1vxDSFYYs3SdIH7y8NOFl8GwdzZuf+tKRLQA8zTQ00JEROUdUyBhwJeW9iZZjb6zBWmy3h5rZ13S7d8XhmTO0drKTNy+9R3ntEej6T5RZKqTA3h629rEgmO2RUl28eeVMQ87Ye4heM5kYNdxQsT7DtPHoZwmtQOUdZ9MvEsDZsGLT4+yiPiBfRtzMKgHUKRhmGbNVVuqsncw8eDAk59gWN
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(36840700001)(46966006)(40470700004)(426003)(6916009)(44832011)(41300700001)(26005)(2906002)(336012)(2616005)(186003)(5660300002)(1076003)(4744005)(47076005)(83380400001)(36860700001)(54906003)(356005)(316002)(40460700003)(82740400003)(86362001)(478600001)(81166007)(82310400005)(70206006)(70586007)(8936002)(8676002)(40480700001)(36756003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 08:46:13.0231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3f5e92-d703-4564-2704-08dabcaeb275
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C405.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4309
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


The integrated DDR Memory Controllers (DDRMCs) support both DDR4 and LPDDR4/4X
memory interfaces. It has four programmable NoC interface ports and is designed
to handle multiple streams of traffic.

Optional external interface reliability include ECC error detection/correction
and command address parity.

Adding edac support for DDR Memory controller.



Shubhrajyoti Datta (2):
  dt-bindings: edac: Add bindings for Xilinx Versal EDAC for DDRMC
  edac: xilinx: Added EDAC support for Xilinx DDR controller

 .../xlnx,versal-ddrmc-edac.yaml               |   57 +
 MAINTAINERS                                   |    7 +
 drivers/edac/Kconfig                          |   11 +
 drivers/edac/Makefile                         |    1 +
 drivers/edac/xilinx_ddrmc_edac.c              | 1250 +++++++++++++++++
 5 files changed, 1326 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml
 create mode 100644 drivers/edac/xilinx_ddrmc_edac.c

-- 
2.17.1

