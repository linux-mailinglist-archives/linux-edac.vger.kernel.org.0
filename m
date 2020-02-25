Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3911716BD67
	for <lists+linux-edac@lfdr.de>; Tue, 25 Feb 2020 10:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbgBYJjX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Feb 2020 04:39:23 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:64962 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729080AbgBYJjX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 25 Feb 2020 04:39:23 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01P9XDc9025946;
        Tue, 25 Feb 2020 01:39:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=EbHAv5+DyQEvZ1HddA6aXB/WTUT1IxWjFvYfLPWrJOs=;
 b=pvWuITwXFCQisP465vUqWnkAu5ZOMX9O9/aU8Q2z+vzXtT9h7rkHzjFaqJfYBXeuKo8V
 c7FIgawOm++JmzFBpuzKFqmE3B2+MgzsHfqIpFHsC27lJnlvbfRD+dyaHs3w+K5muyp/
 oy5cnsNk6GtVz1a2IRogHsucvH/v793kgKtw7Xw4ed3TFZxlu0sD/hrm4XB5mCPr0WCf
 viJLi+IUliCRgVOpOVSXba6hfefRZZrkTH6NflC+4ThYzHegb6Nk7nwPcOhxXRqmJCof
 +7SkA2IiDg6iiZq5zFrq2kmPIDhBngQoOXHvfZ63//SGKWzWMoj0vzQ4BB1rkT+VCHag DA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2yb1r7tn3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 01:39:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGQybksqP1bevjtL68KL1Wd7BCywIWelokLBcOcKHHtGoFjP/KlKDaScrFVCxRbm0qDOq/okxIcTX6QsoCq5Vl2mwrSAO8rgCdGF6IpYlYcl+j9LHWnAPETHxwK0IEq20upND7HaYHx+dxiDskCboHbs9ZdB9frLiyXhXt0nLnxMC7O4okzkRE6klrxweyECEiFit2YUfCQpdiiJpP/Yn7lArQYIV9JyBsz4WV/E4MlqUAX430C4gk9gAGUniqDmOU+xA1c9JnNU69VcerEDftVe10NVJ6YN2e0yIal5Bo/XAjrB0n5fXTnzHrMwgX6gPhOCW9QOsW/Tw1WGp/b2cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbHAv5+DyQEvZ1HddA6aXB/WTUT1IxWjFvYfLPWrJOs=;
 b=CYr25RgFxl1bex5mwzI1DhPXKEZvXjxMaAX4C55BE0mvu0ZSdxBE+ZIUbvQueo/aFA1pVgjOdlxZ5h8MBvY5vv5bEyd6k/0j2WjKleKTq7Kjacub3ecRKc0xEwIRDgMThBgH3kWNELFoLw0KbtMiBio0GvV0kSBtljj0UUBnJJcTXZDGfqAuUpaapewybZNA/xSgoh1ywGTnD0ZaloJXlcNDLUC2BGyyzbHjPl56UmrpXBHYITnCOSWd5FMULyx7FfQhiGVNges5Zl3Rfez3u21BF5yLd74CqRWYodzx3NxAkO5spmbf4P6/eECelgmNeWXOGqqDREFdv5MrlaX3bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbHAv5+DyQEvZ1HddA6aXB/WTUT1IxWjFvYfLPWrJOs=;
 b=KRyzG/ZilJm9CkgnJ0dIUpU7TOJNExPEVY4hsmmTcWEfwxSVGrl8HWYo52rq/c9N60Gam/OUWbl/V4PMq59hyvpqhcuW9aEOsmjiSTQB88PsJ1y2lhzli2CoGczoclYbWsV0Lap06HOU2nNEG74ayPVV8JMJXOFrAPplNhgWP3E=
Received: from DM6PR17CA0016.namprd17.prod.outlook.com (2603:10b6:5:1b3::29)
 by BY5PR07MB7330.namprd07.prod.outlook.com (2603:10b6:a03:203::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 09:39:07 +0000
Received: from DM6NAM12FT067.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::f8) by DM6PR17CA0016.outlook.office365.com
 (2603:10b6:5:1b3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Tue, 25 Feb 2020 09:39:07 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 DM6NAM12FT067.mail.protection.outlook.com (10.13.179.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.6 via Frontend Transport; Tue, 25 Feb 2020 09:39:06 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 01P9d2qT127657
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 01:39:05 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 25 Feb 2020 10:39:02 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 25 Feb 2020 10:39:02 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 01P9d10A007387;
        Tue, 25 Feb 2020 10:39:02 +0100
Received: (from dkangude@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 01P9d1lD007386;
        Tue, 25 Feb 2020 10:39:01 +0100
From:   Dhananjay Kangude <dkangude@cadence.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        Dhananjay Kangude <dkangude@cadence.com>
Subject: [PATCH 2/2] dt-bindings: edac: Add cadence ddr mc support
Date:   Tue, 25 Feb 2020 10:38:56 +0100
Message-ID: <20200225093856.7328-3-dkangude@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200225093856.7328-1-dkangude@cadence.com>
References: <20200225093856.7328-1-dkangude@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(396003)(136003)(346002)(199004)(189003)(36092001)(86362001)(70206006)(4326008)(5660300002)(966005)(2906002)(70586007)(107886003)(36756003)(54906003)(316002)(36906005)(1076003)(42186006)(356004)(8936002)(336012)(6666004)(81156014)(478600001)(81166006)(8676002)(2616005)(6916009)(26005)(186003)(426003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR07MB7330;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:unused.mynethost.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05e6ecd7-38a6-4677-7943-08d7b9d68ed4
X-MS-TrafficTypeDiagnostic: BY5PR07MB7330:
X-Microsoft-Antispam-PRVS: <BY5PR07MB73307EC8A8FAEDCF068ADA6ACDED0@BY5PR07MB7330.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0324C2C0E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7iD1jr72qxVUjFEmAOz9pevZLm7A2b47wXlZ6g0jL9LFsdsCFA5jqxHZ8WpamyxHgaklLSUyAKLH2gJL+MwlLY5OwjmwcxfJz/XgYRebsMwxdmF8f03hPvdo/+5VF6edipazTUKOdFLNwlJ0pOfNSZnTXM+j4f7RpyIbjcM3KcD9g8sPZlgrf0n++hwrZp4jDWmCkCZ6TojGM8o/qU8MypfrqhYAqYEf5dV8JoJWRUUNRwRDVN8DJBBodqdD/Gx8rmrrHvNVs79UbVf09GTMwLUjAoh4JCUXNqkD+EcldUTZcSLB/yEh+Nb45XJ+TPJs+V+a/eM0BpV4jiK7Jfw/moCuAHhhPHfG4MM4sAexSV2hxyokjaWJzOmgeG4PdhTnbaISEIDRfVoEnoxeBRu7hL22yC9HdpQe6d9S49EfU4jmliPUmnm/afv7pP9tCgwd1HOzQZ1KOuA+FfNnqRCoR0EO163Pdd0sB7PDGDm9vG+SD9mHwYnMpVzt3d7+Y8Zc6oP/EePVfEG2i9BAtAIcmk5EXdMG2M+koKLUvNySmieQxxXbqYNpQeLRzzyewnjJ
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 09:39:06.5544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e6ecd7-38a6-4677-7943-08d7b9d68ed4
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB7330
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_02:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxlogscore=937
 mlxscore=0 clxscore=1015 malwarescore=0 suspectscore=1 phishscore=0
 bulkscore=0 spamscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002250078
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add documentation for cadence ddr memory controller EDAC DTS bindings

Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
---
 .../devicetree/bindings/edac/cdns,ddr-edac.yaml    |   56 ++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml

diff --git a/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml b/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
new file mode 100644
index 0000000..df70647
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/edac/cdns,ddr-edac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence DDR IP with ECC support (EDAC)
+
+description:
+  This binding describes the Cadence DDR/LPDDR IP with ECC feature enabled
+  to detect and correct CE/UE errors.
+
+maintainers:
+  - Dhananjay Kangdue <dkangude@cadence.com>
+
+properties:
+  compatible:
+    enum:
+      - cdns,cadence-ddr4-mc-edac
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  reg:
+    minItems: 1
+    maxItems: 2
+    items:
+      - description:
+          Register block of DDR/LPDDR apb registers up to mapped area.
+          Mapped area contains the register set for memory controller,
+          phy and PI module register set doesn't part of this mapping.
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    edac: edac@fd100000 {
+        compatible = "cdns,cadence-ddr4-mc-edac";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+        reg = <0xfd100000 0x4000>;
+        interrupts = <0x00 0x01 0x04>;
+        };
+...
-- 
1.7.1

