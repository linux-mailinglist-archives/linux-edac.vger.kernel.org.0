Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138F5251835
	for <lists+linux-edac@lfdr.de>; Tue, 25 Aug 2020 14:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbgHYMGn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Aug 2020 08:06:43 -0400
Received: from mail-bn8nam12on2054.outbound.protection.outlook.com ([40.107.237.54]:53856
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728093AbgHYMGm (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 25 Aug 2020 08:06:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjmz51EcgBVq0/QKnIpo2l3Gk8AnWxZZ96FGxdA5gfk+JhUym9VfblAlXRyXL1p0j/OhpKvznvbQGOvLAtoZfMDpEsqREAt3PSAGbSpelcRzxxNtyjFH8/uVGNYztsSnYMzpCpF8KETEEkiYCkJ3XwSFrO31AXTudT4HWLQYsFxrQP5tWPfZLSV7jPPBXchJfGT5V8qJorXtGICcfRsoFdzoOIH/c+Igg7vQi6BcI/KT+sw1Tt8wbQQXJ8BdCOZHgUaiQGPAPvtUogFoi5xyT/uiRj3x/j5gho/MxTA9xcMs25AxTDsaBqJXrlDjNtI1gYK5mlNqQcm+AQgBFuvkRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Rekb6uX1LL7EeX7g/5W1Ayw40lIC967hBLVFRu8ENc=;
 b=U2bTWeVeEKMIe6+XAb1vZ56HxnKI9207WzNDaeFCl5Kp8zxym/9VYdYb/PU+wTkc9TxCRL00taTr0fZth9U+gVJe78/h7L0LNb7ewGubd+BrmG5u7xojrR6rNcu3eD9tEph/b0NJZvqULOalumXdxXbDxNOxpQPpX5RXbO9slPVIWEZ9b4Yk1FKp+jtsvtj9xubBLvSi3Oe4I2e98TFzBiry/jVCbpc8O1d07DkuaMw+Eh+0vaHZFvp4dGCBv7MkK+/GTObpUkmyBosDC52acXRMcWvpvPTbJIptAEF4mGCSOdc3SlOBbyl8jMhFCCMKQ7MCZcgvWWZ1JZN+zv0L/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Rekb6uX1LL7EeX7g/5W1Ayw40lIC967hBLVFRu8ENc=;
 b=rUnxFenL5Nz/e6V/sVfkBwdmGClIW4IHXDp9zLemAHHKy1aK7cGeY15e+914MXDTVf52DTL9agv7vWUk2ebE/y3NG5+ufp/DD6eP/DXYqTPAnUaytR1mw6b81MTwCuG02yed91SYArL/u9BG/5srV1WFzyYr2yc0bQDQOQpUgiA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from BN6PR1301MB2020.namprd13.prod.outlook.com
 (2603:10b6:405:34::34) by BN6PR1301MB1873.namprd13.prod.outlook.com
 (2603:10b6:405:34::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.11; Tue, 25 Aug
 2020 12:06:39 +0000
Received: from BN6PR1301MB2020.namprd13.prod.outlook.com
 ([fe80::a446:9877:b346:93ad]) by BN6PR1301MB2020.namprd13.prod.outlook.com
 ([fe80::a446:9877:b346:93ad%5]) with mapi id 15.20.3326.019; Tue, 25 Aug 2020
 12:06:39 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     robh+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com
Cc:     aou@eecs.berkeley.edu, james.morse@arm.com, rrichter@marvell.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 0/3] SiFive DDR controller and EDAC support
Date:   Tue, 25 Aug 2020 17:36:19 +0530
Message-Id: <1598357182-4226-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::33) To BN6PR1301MB2020.namprd13.prod.outlook.com
 (2603:10b6:405:34::34)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BMXPR01CA0023.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:d::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3305.24 via Frontend Transport; Tue, 25 Aug 2020 12:06:34 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [159.117.144.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 393b4aa6-0c28-4ee0-5409-08d848ef5252
X-MS-TrafficTypeDiagnostic: BN6PR1301MB1873:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1301MB18738F9E0C8911A42143089D82570@BN6PR1301MB1873.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m2Kbwzw+ffYLZsCovJCsOBGebB6c0onZn++f0vAKuEb4SBQmlw7k7MTBgIng52zFuLYqb0xKnyqef5Er3BC3oYiOPqvLD6wwvEFkkvJOtyRC9Iucxlcvp8TNFKXODco1hDMCs0U4IFGWvDcwzYt/g8oWkTTbyUz/gFFJhLPeENieQ/o+NduCXYIVw75sm/6AnGthzZvtgmadOzmqqNK4PAcLYFlxjQzmCEEGjpOTshxAggAy6s/7GKRFfl2WETy0/O73HZ7FyWjqo2y0JN8At9FartHXKOytfCFnM5WJ7EZHMEY5AP6KWxSYoBRou192IXlBH6La8r8G5hjtFh93PA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1301MB2020.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(396003)(366004)(136003)(346002)(39850400004)(376002)(7416002)(4326008)(6486002)(66556008)(52116002)(26005)(66476007)(186003)(107886003)(8936002)(316002)(83170400001)(16576012)(42882007)(5660300002)(66946007)(6666004)(478600001)(36756003)(2616005)(83380400001)(956004)(2906002)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: PfZ4cxIv+XUx6jwsJtewtIyynGYJ3HcF4u4RoEOYcj7A/akI1+UOs82OumQ/l3N1JVQa0+ySUyWA1SxVYHFKlazg116AlhPLKK+zglRRMoSZeDAPjEMvKzJIq49roCTizV0TdwoL12BjBP0BuGgIaMvTIbJ+L7UkEIC4kft5lM1fYTU2BVfnd+zRTg2aL63/s1EeLQj1NqNxsRw2yduVeO/9w7xuphaZkuvxnEG9GlZj4V2b/JCbDecma2GtqiZjsleod9LKDOyJy/Fy3j3kyeQKefIWvQ3lWzUQ5xvLwklYu+cVFS5DjpECPk5Pqf4GmC2gS32l358DYQsUxkmHLyc/xnDIFYV4V5CPCWKg43SFKj2nuQxPR1Dx6OCe7cEkKALDvodG3SpQ4yF6DzYlm/g+ovXFHtmG5aMqszOJGTwIr7k5DrFotqTk/dUJTS38J4OjAigGZHOU5KQMlSyvapDY5DlLJMk01HptLSQc/BSQdOxw2eY3vMFEg6FGaWuK/cZekSL8EZL0Qw/u9hkB3a0HIxRENz+RzxrIIYTR7Tr70gureWjjY9bsSh+lnSueiTp+DGdkIkOP6ZmPtRlO4UC6P7xeD8UFQMHIenpad2Iuy2KwMJRk8TigditxaeC8B5DIK+12kfo66XVJoFaNdQ==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 393b4aa6-0c28-4ee0-5409-08d848ef5252
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1301MB2020.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 12:06:39.1754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +KanYP9o44S5UlbKe5pWlQnJQViKn20gBt9WZstjw0aT+3MWkzCJdkA3fcLBD0U5BYtxbU2dkyMLwkmQ58YwKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1301MB1873
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The series add supports for SiFive DDR controller driver. This driver
is use to manage the Cadence DDR controller present in SiFive SoCs.
Currently it manages only the EDAC feature of the DDR controller.
The series also adds Memory controller EDAC support for SiFive platform.
It register for notifier event from SiFive DDR controller driver.

The series is tested and based on Linux v5.8.

For testing on Hifive Unleashed:
1. Enable the ECC bit of DDR controller during DDR initialization
2. Erase the entire DRAM in bootloader stage
3. Using FWC feature of DDR controller force ecc error to test

Yash Shah (3):
  dt-bindings: riscv: Add DT documentation for DDR Controller in SiFive
    SoCs
  soc: sifive: Add SiFive specific Cadence DDR controller driver
  edac: sifive: Add EDAC support for Memory Controller in SiFive SoCs

 .../devicetree/bindings/riscv/sifive-ddr.yaml      |  41 ++++
 drivers/edac/Kconfig                               |   2 +-
 drivers/edac/sifive_edac.c                         | 117 ++++++++++++
 drivers/soc/sifive/Kconfig                         |   6 +
 drivers/soc/sifive/Makefile                        |   3 +-
 drivers/soc/sifive/sifive_ddr.c                    | 207 +++++++++++++++++++++
 include/soc/sifive/sifive_ddr.h                    |  73 ++++++++
 7 files changed, 447 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/riscv/sifive-ddr.yaml
 create mode 100644 drivers/soc/sifive/sifive_ddr.c
 create mode 100644 include/soc/sifive/sifive_ddr.h

-- 
2.7.4

