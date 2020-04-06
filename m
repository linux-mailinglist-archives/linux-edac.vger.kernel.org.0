Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE4219F2CB
	for <lists+linux-edac@lfdr.de>; Mon,  6 Apr 2020 11:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgDFJmf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 6 Apr 2020 05:42:35 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:38308 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726675AbgDFJmf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 6 Apr 2020 05:42:35 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0368ko3a003741;
        Mon, 6 Apr 2020 01:54:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=WtowDfSd4ZD5Ow+x6zpsGWGIbQ1Ry/7xJkw2mXFUEhE=;
 b=OWP8BQrid3hzQDdlDexolm+xA7fdK6gkWJrrEZSUI97UUIW9k9p2yGrWbk+xK1iv8Sdq
 hjmowuWm4SsCdxxa8A10h/ESmMvLg4p1yWd+74kvk8f8TLkXRIy0FkWWOwwgW7LzNvul
 1jGyMpCvaUBIi2iOptJII+QBSEc/v3PhZG7E2GC4UocPt2en6PIuH9UM3VIckgjN1wFS
 8Bgpb57OlDzluS9CB+rakuWPRyXklSiGHXszuvrXGEqE//AW/oPZu13MzMEgDNmJi4ux
 /Kv2vS2W7C6xxnrfQx9p4kzkM9epy6qozOilXQhNLm+IuwRimbURIMsLNB0/y6TWeHxj 8Q== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0a-0014ca01.pphosted.com with ESMTP id 306psvwmxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Apr 2020 01:54:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBv8wVaMpi5oHyfmPCJittsct7yv7xwInhmcc7w14XN9aAKQP8E8M6rPB6nvJfBR4LWaadnU59bHonoQ74sviUI7IR+kVZLZ9vIQxu2golIhcj6YaczAydDkMWLfOnLcTDrTXHqvPqkFbcXYHGX36CW/6VkZl/QBFgPH8briN9N47UnYBouO6bSDUzYoWOWxoW1pbNjOU2GqmijwCA7/FyzcGBwjy1HE6Xz7ShP0RIa2bvF1/GDuG4X8rEHLCifcmJa1xsgoNXAh3PDg+TOv98wHhTSM3ujBdKieuTCB/ACZTgN4ggSYuYsTEl06wrcaS1lErWmORjl3Jkr/RCr3Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtowDfSd4ZD5Ow+x6zpsGWGIbQ1Ry/7xJkw2mXFUEhE=;
 b=mJNW61jIbLdh3t2X0dMomPmWPOghalBiosKCuEku25gBag0IxjOVhof1KTyEh6pSHX4UJLGiTN4SwmxFUeicva/kOgb09zD3FbrM0OoIWwMHe2467zzq/YhrPS8Fs44MpwqNleQySOYcpcXxgCWqvLfwUJ0kge+dl0cKbkTi8pLz/HGok4gph7vi0OnE+dzxBe+DdxOuZp+Pbgqg6+YL0t6So/iuAZ3JEp7uSDpk3Zzru13c/4SCLHr0i6eq4tWnJDk62JAaon6KctnC/XQ/QgOm/UdALdPZgpRC9fOAKr533M+kwvSw6yclwKSRT9RYb30U0S7mWVYi6E6yhpdTYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtowDfSd4ZD5Ow+x6zpsGWGIbQ1Ry/7xJkw2mXFUEhE=;
 b=ylfnx7MS39GCrMDhM9Ub2mEpoAdjiEROGkYlV0ESBZNVy/0RfCvff/E0Bacl2ldrj/C/xlQCPGIMe9jrs5FjKS4g7nC3jF/94kRRze3N+JFTsBLlUdl3ADYnVMJ1z1e8XmfBBQusFTyht1pML2Bov2svjvoEo8KrQBs/4hhJbRk=
Received: from MWHPR17CA0066.namprd17.prod.outlook.com (2603:10b6:300:93::28)
 by SN6PR07MB4400.namprd07.prod.outlook.com (2603:10b6:805:5c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Mon, 6 Apr
 2020 08:54:36 +0000
Received: from MW2NAM12FT059.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::fe) by MWHPR17CA0066.outlook.office365.com
 (2603:10b6:300:93::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Mon, 6 Apr 2020 08:54:36 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT059.mail.protection.outlook.com (10.13.180.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.9 via Frontend Transport; Mon, 6 Apr 2020 08:54:35 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0368sWmq015091
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Mon, 6 Apr 2020 01:54:35 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 6 Apr 2020 10:54:32 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 6 Apr 2020 10:54:32 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0368sWW1004294;
        Mon, 6 Apr 2020 10:54:32 +0200
Received: (from dkangude@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0368sWol004293;
        Mon, 6 Apr 2020 10:54:32 +0200
From:   Dhananjay Kangude <dkangude@cadence.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        Dhananjay Kangude <dkangude@cadence.com>
Subject: [PATCH v2 1/2] dt-bindings: edac: Add cadence ddr mc support
Date:   Mon, 6 Apr 2020 10:54:03 +0200
Message-ID: <20200406085404.3983-2-dkangude@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200406085404.3983-1-dkangude@cadence.com>
References: <20200406085404.3983-1-dkangude@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:unused.mynethost.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(136003)(36092001)(46966005)(336012)(1076003)(186003)(426003)(107886003)(70206006)(70586007)(26005)(47076004)(478600001)(81156014)(82740400003)(356004)(6666004)(316002)(81166006)(8936002)(6916009)(26826003)(36906005)(2906002)(2616005)(966005)(54906003)(86362001)(36756003)(4326008)(5660300002)(42186006)(8676002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cf08fcd-f3a4-49bb-6c7b-08d7da0821da
X-MS-TrafficTypeDiagnostic: SN6PR07MB4400:
X-Microsoft-Antispam-PRVS: <SN6PR07MB4400EBFA5874AA7B7F44F017CDC20@SN6PR07MB4400.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0365C0E14B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dxM1uDlu41w0gTGbHa3TkG9e9sue0+SbpQWQSMXpmv+qHCAezIenJfhc1tv6XfLYvfxhDP7VnMLoKZsIwaEI0xJYPrSL+ADPX9mLB9M/tl2CIahQivRhrvtvc38LKCB0gFSAwtQ6DdVW22YlibWa5tIb19laORVHAMnfIW1xvM8QxIk7ih+6eG1002qN3/Sz9AjX7y2Yp7I3Dzso3Ff1N4ndPK3GePtmjRF4sGMe7H3RcEMeE19Xc1udOvoiqLAibJHt6NiD70GvfdRj/4JdkDLKyk9L8BDrNMy1xlDauBIACwoLXDa3BrpKNQv6HJ4UA1jYpMz3gpcEH4g/huheesdXwrV+YY8N/FPr248mejaJYiA+jrgnYz1Pqc/N6tToytGM/wh5K/9VRAecKrXwkalak2d5iQ9AMSBgzk2WCeXEuEKZHynT/L7098iSMgrJe9Jy4d8tZFa6SGUF/q7uA0nX8rs2WwSg+pmZxxOtas8g4uaklAThyZUUmXZhQ3Uq62Uo8/XF54E/vLlFdWojSEZIy1DwZeDoCoxX25QzhYknQmTpupgmDAIEEnzojQ6a00/EP4KUNQsTX0iAihcyVmlT+4UgWzvo0xlHwf+Zpt6TGfkjiJu4V3DewpuZaZZu
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 08:54:35.8131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf08fcd-f3a4-49bb-6c7b-08d7da0821da
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4400
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-06_05:2020-04-03,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 spamscore=0 clxscore=1011 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=961 mlxscore=0 suspectscore=1
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060076
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add documentation for cadence ddr memory controller EDAC DTS bindings

Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
---
 .../devicetree/bindings/cdns,ddr-edac.yaml         |   47 ++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cdns,ddr-edac.yaml

diff --git a/Documentation/devicetree/bindings/cdns,ddr-edac.yaml b/Documentation/devicetree/bindings/cdns,ddr-edac.yaml
new file mode 100644
index 0000000..30ea757
--- /dev/null
+++ b/Documentation/devicetree/bindings/cdns,ddr-edac.yaml
@@ -0,0 +1,47 @@
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
+      - cdns,ddr4-mc
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
+        compatible = "cdns,ddr4-mc-edac";
+        reg = <0xfd100000 0x4000>;
+        interrupts = <0x00 0x01 0x04>;
+    };
+...
-- 
1.7.1

