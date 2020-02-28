Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 338DC173461
	for <lists+linux-edac@lfdr.de>; Fri, 28 Feb 2020 10:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgB1Jnp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 28 Feb 2020 04:43:45 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:48618 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726005AbgB1Jnp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 28 Feb 2020 04:43:45 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01S9dg11024998;
        Fri, 28 Feb 2020 01:43:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=cK5l/fXeVfu9ikqH7tHP0X4ZTrpZdVpvfqdgInRowM4=;
 b=r1Ygq8Emcnbu/ypbIWeIfBgc9RAyxw1gBzBYFJ4GPYY84im1MIVjpEGNwNW+cBPaeoG+
 BJDSxcfa1TcvxZnm77YWq3wB6oId9v44egEeTdkKQ9FIudmIBslPPTS91DBG2AUSzufi
 24PYQoden/N+ZSenoXbDxVqxWewNRN7ifCJZxGBKb4xbw9kNxg2bprYvYx/rVoqRW2bE
 8XNhPs3x2LjsLVW6hzUjOGYb/uoR7C2EQEHsavArLB/AM9ARdaKPgI7Ub1afTB3cbLxo
 45cWjVzlaDJ5g35xOc+E0LY+39FmBVHPT/tIkRyF/jfk89cx2gwcT6cbS2SKUap0SpY4 oA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2yepvct0rh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Feb 2020 01:43:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgW3zLRdf0uDk3rdSOXvQOlUF9tMOj4CoCRHZtvSRhWdsPuY5MnWS0oyGDL9E51gAHULXhniLY2aplqZOxMb5PPs3M2/I1nIGTmqQOjL5VzFeIilXXnVmRvMZFJDrqaKtNs3xOtDqJiAqSaldcmuNJK3axGTsQq9HUDMrP1fhNtXdu9d4RchxoY+LI+80BnyYtbCMT+O6h+Q5Gu1J20aIuY3qByqpAZKdWIepJ0ROv5nm2KJSjMXbH24N04sExVanu/nrtbtwuWgcU3epF8lb1fTmPx4OTwS11j8Z0XyPXMznZkNj3kLwWmboJUPDilbo2dKIYiZbuI1XuiQgQIr8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cK5l/fXeVfu9ikqH7tHP0X4ZTrpZdVpvfqdgInRowM4=;
 b=OiQTF1iugevlePofcE3nVDkCWPccGS5p3Y8NQGa3uJQjySoRxam02sd5J52+je40UfivYPq4H/Mcqp77xvNCnlCY4vB2Oiqb8+8JMWAOPWLNZlUpcrWWwQ08DrqqBVLhB/Oija4A/EJS4KMc0TAm3U+LwZvU529/sQCfSzVZMeuOMjbQhvn7X681/x6SD3TiNKM5lTi0Z6t7CpRdAlm1M6wpdaK5TcGihUIKtt18nurcIm5btDnlDNfB7V1p4XpN14G77WK08AatEvpRiKOWZSnnsmAmPwq/OGVB9gk/bheKfPMko+r/PxJ3pbZcb9dIwvDOIKsNt4o8Uz3P1QLCFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.28) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cK5l/fXeVfu9ikqH7tHP0X4ZTrpZdVpvfqdgInRowM4=;
 b=yGipZaBWGuMQepYuTQd/1Xo7CYHOkpIv5IiHdIZIQJjR8/c0VEO/KHodLYZe+czm/h9i+DcgScfCps/wHtCpfQSFErv8HBXXLmTP6Kr6kflk87Q1FsPGPAafz+/OJUWxULteX2rubrZ2eAvSU0y8js7x+8Sn892ZV+9rNX0FaxY=
Received: from DM6PR17CA0036.namprd17.prod.outlook.com (2603:10b6:5:1b3::49)
 by MWHPR07MB3053.namprd07.prod.outlook.com (2603:10b6:300:e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Fri, 28 Feb
 2020 09:43:30 +0000
Received: from DM6NAM12FT027.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::cc) by DM6PR17CA0036.outlook.office365.com
 (2603:10b6:5:1b3::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Fri, 28 Feb 2020 09:43:30 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.28; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM6NAM12FT027.mail.protection.outlook.com (10.13.178.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.6 via Frontend Transport; Fri, 28 Feb 2020 09:43:29 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 01S9hPFJ026489
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 28 Feb 2020 01:43:28 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 28 Feb 2020 10:43:25 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 28 Feb 2020 10:43:25 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 01S9hPGw013674;
        Fri, 28 Feb 2020 10:43:25 +0100
Received: (from dkangude@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 01S9hPtM013671;
        Fri, 28 Feb 2020 10:43:25 +0100
From:   Dhananjay Kangude <dkangude@cadence.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        Dhananjay Kangude <dkangude@cadence.com>
Subject: [PATCH v1 2/2] dt-bindings: edac: Add cadence ddr mc support
Date:   Fri, 28 Feb 2020 10:43:22 +0100
Message-ID: <20200228094322.13617-3-dkangude@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200228094322.13617-1-dkangude@cadence.com>
References: <20200228094322.13617-1-dkangude@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(36092001)(189003)(199004)(4326008)(478600001)(966005)(86362001)(107886003)(36756003)(7636002)(26005)(8936002)(8676002)(246002)(42186006)(186003)(316002)(336012)(6666004)(70206006)(26826003)(426003)(54906003)(2616005)(2906002)(5660300002)(1076003)(356004)(6916009)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3053;H:sjmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc1d4886-c95e-48b9-bb98-08d7bc32ab08
X-MS-TrafficTypeDiagnostic: MWHPR07MB3053:
X-Microsoft-Antispam-PRVS: <MWHPR07MB30539E0DD66355B78F5005AACDE80@MWHPR07MB3053.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0327618309
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aFojHo4tejyXTnM0Njw4h/otCvu2j9okLxUaHYa98SZddZGKlgtlyqsNHc5BYKFdpec28rOHUcWa2ccfUZowXq1pgVqH3/G9/bzcCj6sWoFXoKVUAS8NlsF6Kz0jB215luv6ElSyhIeepB+b7suGKtHs0u3ZLR5JmBsYaQFiZ0uHXMjs4Ftsez1ZcB3qaYZscuwtt/0hW53Fn3NN1revQWrcFQweN2hf5oCUJ7Tb+BM4tv+fUfW8ZvLWtqao34AvNZCwal14MMw14N+t7O3PYxw8NVyjrTXY6Iz8MClN9zQaUHQEsUeZwF7jnsWzrZtKYLHSzH8aAGxGDWRnQhBRGmIgEl7NXYdZYoP0aE38orwGRQ4xLhf3gQNXER658xb4ratqWufvHXlm/dTXYrNqZVJqYKuTMnKUKMr1DwBYZ569wbFcWXzMNRIJUMeTyMDRGbVznZx1NvPlnHTebKDP7xpVK925o62O8wq0Q4xgZbGTT4VUHbBW+Ln9HqgpzPBbxmmdcliqUNKnwEHvWNz0x/oNFtf1X93wBcK+nhh6dsWer4haW1wAnVIXQ/8KCWTd
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 09:43:29.8978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1d4886-c95e-48b9-bb98-08d7bc32ab08
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3053
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-28_02:2020-02-26,2020-02-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 mlxlogscore=906
 clxscore=1015 adultscore=0 suspectscore=1 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280081
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add documentation for cadence ddr memory controller EDAC DTS bindings

Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
---
 .../devicetree/bindings/edac/cdns,ddr-edac.yaml    | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml

diff --git a/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml b/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
new file mode 100644
index 000000000000..d83d8840d57b
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
@@ -0,0 +1,59 @@
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
+  ranges: true
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
+  - ranges
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
2.15.0

