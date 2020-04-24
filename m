Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4FE1B6FC6
	for <lists+linux-edac@lfdr.de>; Fri, 24 Apr 2020 10:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDXIca (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 24 Apr 2020 04:32:30 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:17228 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726298AbgDXIca (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 24 Apr 2020 04:32:30 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03O8QthZ010760;
        Fri, 24 Apr 2020 01:32:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=j75imNqAtK8gLlJcJ1u7mBCm/uefAC1yb/nGFPGKQ2w=;
 b=CQdcB4TOqpcDkTdTyt8ZdTWw+opK+dAEFUB9uZcgNABXJbSiZuhHCVMNqlf2dlsp2HNA
 apIM44Lb1fOu8wGzE79C+CmXExt9jtOS+VvvTkp3+WbXaJAEdkA4Q/JNwkEmjM7ADtfR
 YGH+eKJJWUn2n2KmbvXBjdadstGBwEYC38+lyofQiMdGAmTy2uX7KlU5YZSpMSdBqe9H
 xSlhWQghFRH4zl+tN7phqXdPELHquQ3Sx+WvPCeiFO8nGMyyq1KtQo06tedXuxO6Y8XY
 m62qRgSwUVqjwWJ/SkeWJ6cSFIKpYuZcxXzI05GE88R29HeHCZwuDuFsm4o0U4VgS/kU cQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0a-0014ca01.pphosted.com with ESMTP id 30fx3v185a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 01:32:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VS6cRVAGQLzHMSlhnnm5R21H+EXn5x/5w5M3Tx7B1TGJjUexQYkAkHScnlalgseQiZuCzfHZnVkDwOVUCRHg8X7VhyLneJPS6ut5gu4Z1kj5C83ipbzMpL6HA0UJ4nLPxcDK9FS6eqZWsQ26YiMjBVFv+kvsNAWlootYNRjgAqMraM3c7Xcf05I2M101C0+gHU8lJZy0kqOc8dpeVaO0LW4vQzP0r3KTdy1N2q9aiCXklReCCCs3DYuHX9V2OEmV6nwwwIVUc05swe/d2tkZnUhpNmrW1vGD952OyJV7u+JHnyk1domQGn0LcOsaFw4d50XACteujzmsDMIDRbkwbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j75imNqAtK8gLlJcJ1u7mBCm/uefAC1yb/nGFPGKQ2w=;
 b=DPeNSf7NznmN775IjD9QAIzYtxSv/b8zhDotheUg5cRL05XM9CRaiZOFL2/DRgsFJJFDVQBCUOEVld8stdikrz0lSWbO+kcVsp65Bqr4UnPxNRsFdp9/D9XQZn7fGp+FyhHZlpuG3itaMT5admDiMK857dry4MbtMvVQc4k0OAP7hnU+h5BCn6sXKDUmPCABzrk/hRvkFZ/6XgkZtLGG01W0ubepSQVd+7qVBAcuL4g+Rg24mB1geT9s/EWmvCCfRd1N92aGQ8ZkLM5ZXCeGY/nKD7GfBB0SPDQ/Rtw/sNHSULE9NdFPvJzY5Tfx6w64HVV8tm6UnlSO/kVnJNmyzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j75imNqAtK8gLlJcJ1u7mBCm/uefAC1yb/nGFPGKQ2w=;
 b=UbZ2h+3BPNb3PMKicAqbyBAtX/AVHCekkHe0lhxxWU0qFOYhiSbxX8WnnTgCjNYf8x4ni5/Nj27/wWrR53147hUz8AHP7W+POPKtm3/5VU1y7gJg9yxCbOzisSxbclDo8BmtsAkzekKNPa97w7qTbrX2ChVcZHIZQufa6f7R0NE=
Received: from BL0PR02CA0018.namprd02.prod.outlook.com (2603:10b6:207:3c::31)
 by CH2PR07MB6469.namprd07.prod.outlook.com (2603:10b6:610:27::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 24 Apr
 2020 08:32:04 +0000
Received: from BN8NAM12FT039.eop-nam12.prod.protection.outlook.com
 (2603:10b6:207:3c:cafe::d8) by BL0PR02CA0018.outlook.office365.com
 (2603:10b6:207:3c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Fri, 24 Apr 2020 08:32:04 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT039.mail.protection.outlook.com (10.13.182.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.12 via Frontend Transport; Fri, 24 Apr 2020 08:32:03 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 03O8W0s8029879
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 24 Apr 2020 01:32:02 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 24 Apr 2020 10:32:00 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 24 Apr 2020 10:32:00 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 03O8VxkB031018;
        Fri, 24 Apr 2020 10:31:59 +0200
Received: (from dkangude@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 03O8VxsI031013;
        Fri, 24 Apr 2020 10:31:59 +0200
From:   Dhananjay Kangude <dkangude@cadence.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        Dhananjay Kangude <dkangude@cadence.com>
Subject: [PATCH v4 1/2] dt-bindings: edac: Add cadence ddr mc support
Date:   Fri, 24 Apr 2020 10:31:54 +0200
Message-ID: <20200424083155.30918-2-dkangude@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200424083155.30918-1-dkangude@cadence.com>
References: <20200424083155.30918-1-dkangude@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(396003)(136003)(39860400002)(376002)(36092001)(46966005)(8936002)(86362001)(7636003)(70206006)(47076004)(82740400003)(107886003)(336012)(426003)(356005)(42186006)(70586007)(54906003)(2616005)(4326008)(316002)(36906005)(36756003)(26005)(186003)(478600001)(1076003)(6666004)(2906002)(6916009)(8676002)(5660300002)(246002)(966005)(82310400002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 517fb093-076b-405e-b621-08d7e829f76f
X-MS-TrafficTypeDiagnostic: CH2PR07MB6469:
X-Microsoft-Antispam-PRVS: <CH2PR07MB6469526D5461584CAD1EDED6CDD00@CH2PR07MB6469.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 03838E948C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WmQsbDgBf/wM4/AM2TjEeLIMbZuqs/u8jWCDlZnb5lS/XDbPPNsSsqFCoIIv0BPy1tHdPnf5q3JsSWsqw6sgz5V+u5hJgRaLirX2lSoc2ZG7as16IN5OM05tu64v4YN0nI5eMit5+ECkFojPZqH77mh6kEh9axlpyCHYAlHStiOOZ4ReERmQDItyWX9OLDSk3qY7fUTzYM3b07qOZnkDo6oZIap/7A/c7HR7LsP4kzK7XgNMaI8/zW36Sn/d65lD4Z16aMrIqwKZnuNrbIJ2oDT5NExWz2SGV+/udmyoNiOTRmLea9oGyZfBqn8+U8654fztZiX8dK1kf0RbmcPaR78hC9Dw1+RqDc3ApeSZhXR2GUNtBcr7DiL9MdfEOFE8yhHJnUiOgRBjbVmVOJtGIrkn+hg2xw/l8rjkzkynmfaZs6elUn5MLB+F1rO+NvF4OWefv25nGtWp1Mmi6XQLwa5m9pLUdgxBn1qqDkFaZjAYkZ7sDyXypvwLYnjtOHKBaH/DZp3qtKdqIlIHcsqk4Muhmw7UaCfDvsBqCDiYEpL5MBLQE6WzC2vw2hRSm2PlBBjYDUOBB2AUC1tZoyc3fkgtCWSnfIg/i11gHItp1S0I9e8wpG7WptNZpeIogt6I
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 08:32:03.7471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 517fb093-076b-405e-b621-08d7e829f76f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR07MB6469
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_02:2020-04-23,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=1 bulkscore=0 mlxlogscore=952 mlxscore=0
 clxscore=1015 impostorscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004240066
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add documentation for cadence ddr memory controller EDAC DTS bindings

Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
---
 .../devicetree/bindings/edac/cdns,ddr-edac.yaml    |   45 ++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml

diff --git a/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml b/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
new file mode 100644
index 0000000..198e60d
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
@@ -0,0 +1,45 @@
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
+    items:
+      - cdns,ddr4-mc-edac
+
+  reg:
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
+        compatible = "cdns,ddr4-mc-edac";
+        reg = <0xfd100000 0x4000>;
+        interrupts = <0x00 0x01 0x04>;
+    };
+...
-- 
1.7.1

