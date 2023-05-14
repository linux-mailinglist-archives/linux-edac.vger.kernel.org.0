Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78576701EB1
	for <lists+linux-edac@lfdr.de>; Sun, 14 May 2023 19:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbjENRYr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 14 May 2023 13:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbjENRYo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 14 May 2023 13:24:44 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B911985;
        Sun, 14 May 2023 10:24:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1MuKHwom84hpPZjzhag9mxJl70E0bHSb9DwT6tstG3SO4Tzl6SxkANsDWM6AC1g/gqzvHXT4iBp3eB0vtq8KJ8ouu5QBfakpvfqZ3hyLGp/5OY84IlvBsAqXVSsCB3G4oy2vGy71/qkHw7kJDuKxywiimuLUkZKEBNFdKBD+mYVB1ZD1n3kO7YeCh0HPMDSkSljT+arJ+acltGnau+pdwHdlgyod4/IKQHyDFklpldUPSytrcB/SkhSf6c1bd4TRuBV+23MZaIpvgHuL/xie4pR+2+9qYSulsq+ArWU1hSvu8dicpqw3rP+tSzQDN5oHV+TJpbHJiu7D7EjRNTIZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDS1zo72rzgfnUwh2WwsTFvrMXopKLpXf29QUKMkzPA=;
 b=eDcPyghf3XT29l8RQuS+1mLqfQ4IB/VyCxWbhbE4HQdPbQMPf/c+fqQfdsqO6gRRw7EnMuZmpfPYEN+h+/pXKq7y3cJPswrIOjRU8Ye1X4xJEpWubbCC+SRaN51yL5xB5DWWGTdoEiZyBBR7xKx/MrlNV+VZ6QwJH/pwE1L1EIv6lMuNAYY0X/z5pqWZn/Y7HHsV8VvEH/YDOhwybdVzG4fYXlRPRYItLyKY5fbVxAA91mvu0mDkQqMQH58Vfm0eoaqP88u+7DhngIJxuiCqnNqng/EHRJcSxQT1zQmHACGICK9iYVa2rjiqms8EpSLih3ANvOT92IT+B/c3qpcQMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDS1zo72rzgfnUwh2WwsTFvrMXopKLpXf29QUKMkzPA=;
 b=UqQ2Y1EKG5OczE6xvf/6v7EAjO3kDQUVWCZUD4RtaqOyHfVA0kPMK3OJN+byz1I/uV1n3xVLlXsUKU1qkubq3ierGdlSoXJGgguSksIc0ikAIrXGPevvhgrHTyujo0upAKB9o1YJDUC6YCIG04tFxZnXwQO9lJQd22U6tUYp5yQ=
Received: from DM6PR08CA0026.namprd08.prod.outlook.com (2603:10b6:5:80::39) by
 CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.30; Sun, 14 May 2023 17:24:41 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::15) by DM6PR08CA0026.outlook.office365.com
 (2603:10b6:5:80::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29 via Frontend
 Transport; Sun, 14 May 2023 17:24:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.14 via Frontend Transport; Sun, 14 May 2023 17:24:41 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 14 May
 2023 12:24:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 14 May
 2023 10:24:36 -0700
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Sun, 14 May 2023 12:24:33 -0500
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <git@amd.com>, <devicetree@vger.kernel.org>, <rric@kernel.org>,
        <shubhrajyoti.datta@gmail.com>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <mchehab@kernel.org>, <bp@alien8.de>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <sai.krishna.potthuri@amd.com>
Subject: [RESEND PATCH v6 0/2] edac: xilinx: Added EDAC support for Xilinx DDR controller
Date:   Sun, 14 May 2023 22:54:30 +0530
Message-ID: <20230514172432.12505-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT012:EE_|CY8PR12MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: 314c718c-216b-4a35-ce72-08db54a01a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lpiVkDPDH3WkG+Eo1Rm1krHCKsIz7FD01LFuyaLgsaNie6RbF/HkIb/eKcQUyEkcdmo/nKd99wZK5psz8KeNpR9Fg4dmwlqhtZqNZna1qgD5c5xhWn0Zdnp/Nk4NsmwgCNROdzx2arxwyOI4NjP/s2seMBzVkLJY9JRLQizATdxABoApe07vJRZjyLr6tEpnkt7fdQoWzmvcn/1KGbpvX10+1v2wq6JuQ/ob9t4UbFVwDHwB7KrAgZ5k2zMrT/MtwOvyX/zOzv3o2g1zt/n4VkOcQ20VGvIYTK966EAd0rrF7yO23uX5hUEISaZUxkkpJaRIqxM7oD17shRx1Nsy3vtiFbiUVIG1qk+/x+1Bc1pQkjen7CIFpeQpua5SQIzsg5gIJ4S559BqLixwLSRagwET1Z0WYMd9FPMmjOBZa0Gc7Q07BOR6n0dLTpDXuMZOwJ2ELBErPIVLftn8JN8JWCbpbHdYLFINK3Cpmkr1NnM5plf1xMcCqoEtuinOxhYr8xJy4uPMvkdvtnT7OIvenjp/w4TQynBq4GoUs4kNeKmFu65a47bUfmkjmy1m1ih2iuFm5Rv8V1+7+U+OLjkVHYQEd5/5W9EV08KBYg18+AKiFrvE6TCVx09jZv5EsDjjZO89ieDVPAAciAV2+3Y4klSCbtwd6Jj96lkyXT3TgKc96Y4lH/33AanFuwO8r+s5xw5b9wmBU6fYnvenS9LWMFIL+EnVBCUQkGyuuT+gZy+GjxKotnkRnbwbbnQHYo5BsncnHxcc4QNRwzvzPFT6kA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(47076005)(36860700001)(336012)(426003)(83380400001)(70206006)(70586007)(2616005)(26005)(1076003)(40480700001)(478600001)(54906003)(186003)(7416002)(5660300002)(44832011)(86362001)(40460700003)(8676002)(8936002)(2906002)(36756003)(41300700001)(4326008)(6916009)(82740400003)(316002)(81166007)(356005)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2023 17:24:41.0520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 314c718c-216b-4a35-ce72-08db54a01a05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7435
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


The integrated DDR Memory Controllers (DDRMCs) support both DDR4 and
LPDDR4/4X memory interfaces. It has four programmable NoC interface
ports and is designed to handle multiple streams of traffic.

Optional external interface reliability include ECC error
detection/correction and command address parity.

Adding edac support for DDR Memory controller.


Changes in v6:
Fix the warn.

Changes in v5:
Update subject

Changes in v4:
Update the subject
rename the driver file.
fix the debugfs file.
fix unneeded capitalisation.
refactor code

Changes in v3:
Rebased and resent.

Changes in v2:
remove edac from compatible
Update the description
update the ddrmc_base and ddrmc_noc_base names
Update a missed out file
remove edac from compatible name
rename ddrmc_noc_base and ddrmc_base

Shubhrajyoti Datta (2):
  dt-bindings: edac: Add bindings for Xilinx Versal EDAC for DDRMC
  EDAC/versal: Add a Xilinx Versal memory controller driver

 .../xlnx,versal-ddrmc-edac.yaml               |   57 +
 MAINTAINERS                                   |    7 +
 drivers/edac/Kconfig                          |   11 +
 drivers/edac/Makefile                         |    1 +
 drivers/edac/versal_edac.c                    | 1078 +++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |   10 +
 6 files changed, 1164 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml
 create mode 100644 drivers/edac/versal_edac.c

-- 
2.17.1

