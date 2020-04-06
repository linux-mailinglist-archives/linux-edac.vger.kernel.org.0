Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B71F119F68A
	for <lists+linux-edac@lfdr.de>; Mon,  6 Apr 2020 15:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgDFNOC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 6 Apr 2020 09:14:02 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:48254 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728167AbgDFNOB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 6 Apr 2020 09:14:01 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 036D58nm016507;
        Mon, 6 Apr 2020 06:13:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=2et/XuZug6kjmJtkLC+ntwLPkH6Re+U+W7JzYghvQpQ=;
 b=i3fcfFQla0rdSBuMf4gOB6ozrxAVcQa2yKRVJUbUttVnBuEdpkpbEE+W76wONMu9CPGL
 qZx4tvANfQdTDfUb4G3RVRBT/Jq5b4+J4nuBQhecqqecEYtvChl6X+Tdib/T/8UDjmr0
 86ui4dOEuean66S2YPmlZfKPcE3HOc4UrbESWiPKZ5vK27miBiMAjUdi+WeGCY84drjc
 WO19HteV9Oeedt7ho3CS5sMGoMGvndvPm3V9PZu+rxmofHyfyfts6DbKJKrG1BXYfGOA
 iY1ZNQdoUYvJrnEAnv24uI380ut/gpJ2fib4Dnjg78E68f0QGE6XjeWDpvctqAJqi44R 1A== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by mx0b-0014ca01.pphosted.com with ESMTP id 306ntxxmbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Apr 2020 06:13:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcSNRki2OtDljn8P7hGu9O71mGVYvwwlywCbFuGYPhyOfQ2IAzi2q240wqrsn+aqW6JwfjTgwBwEo1/HzhRSOD0zN3jk1IOfDxa2IQHuwJRW+eYMGBPb3zsxtQFY9IHEcfHThPg1+Bh5SEqSbUmS2BABZ4D5DBJ8cOFZHpiKxMfx5ha2AYSdChrrlqdOdKi7Zr1AY1MCNvSzM4h2DAQrrlVikabfElsODc3x8mFEzFqykxNfrBhiKTe9VWkDW/LjXJcfzxZRlhxvjDUzL1WmI1PxsbpZ3wpM1eJxE8uhRJxSeJi0wR76Vvay61wyoyDknMIdOcgt+rUzvVihslKPOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2et/XuZug6kjmJtkLC+ntwLPkH6Re+U+W7JzYghvQpQ=;
 b=nCw1PfJ9DPtg123YPv8Z3Xbu9wzc9c6WZFnqkphJJs3QxhjtHH5q39NX70ADVCQRCtHSgXU0zCasaglr4Gyswf9fBeRW5f5mzi4Y9q6qmgBdOwqSbfnY6skHNtaoDPA8azCAjNrj4esn9R6QGfzi1j20lay60h9hSKhebxNPS3V/adGSB01rKvCpLFaxCzSXNcEiNEMBApd0Kwxs4hHen2DOxO4mKq3LADGC9i2oaSFFvED15I242WKjvdWNEGNsx5dJXOz+3mbx8X12Ptsflg0O+0+Al+cT9YqkmJpBjmoTES7FqnHhFdlSzI2Vkz6LWW7Y27wItEHIQ3lJbftDiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2et/XuZug6kjmJtkLC+ntwLPkH6Re+U+W7JzYghvQpQ=;
 b=lHmXFjd4hzEmzxa8EJnMPZnMC4GxfnKXqEsxJXDS4piv5f/Ak9P9YeLEGcIf9+MFnJawIskz70Ss8HnRE+GOd5ZBKzw/0reM7N/mu3xB00r8h2Y1n+lYvw79kQyHcycIrMf4dBAbiI6ogkL3bhc4KLswS7yyAyaIy3BuMHR1k9k=
Received: from DM6PR03CA0026.namprd03.prod.outlook.com (2603:10b6:5:40::39) by
 BYAPR07MB4999.namprd07.prod.outlook.com (2603:10b6:a03:15::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.21; Mon, 6 Apr 2020 13:13:49 +0000
Received: from DM6NAM12FT057.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::26) by DM6PR03CA0026.outlook.office365.com
 (2603:10b6:5:40::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19 via Frontend
 Transport; Mon, 6 Apr 2020 13:13:48 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT057.mail.protection.outlook.com (10.13.178.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.9 via Frontend Transport; Mon, 6 Apr 2020 13:13:48 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 036DDiTd018857
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 6 Apr 2020 06:13:47 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 6 Apr 2020 15:13:44 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 6 Apr 2020 15:13:44 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 036DDion001337;
        Mon, 6 Apr 2020 15:13:44 +0200
Received: (from dkangude@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 036DDirY001336;
        Mon, 6 Apr 2020 15:13:44 +0200
From:   Dhananjay Kangude <dkangude@cadence.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        Dhananjay Kangude <dkangude@cadence.com>
Subject: [PATCH v3 1/2] dt-bindings: edac: Add cadence ddr mc support
Date:   Mon, 6 Apr 2020 15:13:40 +0200
Message-ID: <20200406131341.1253-2-dkangude@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200406131341.1253-1-dkangude@cadence.com>
References: <20200406131341.1253-1-dkangude@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.cadence.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(346002)(36092001)(46966005)(82740400003)(36756003)(246002)(86362001)(5660300002)(8676002)(47076004)(8936002)(2906002)(6916009)(7636002)(356004)(6666004)(966005)(107886003)(426003)(54906003)(316002)(36906005)(1076003)(2616005)(70586007)(70206006)(26005)(42186006)(478600001)(4326008)(26826003)(186003)(336012);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a88dbcc6-997a-465a-dad9-08d7da2c57f7
X-MS-TrafficTypeDiagnostic: BYAPR07MB4999:
X-Microsoft-Antispam-PRVS: <BYAPR07MB49996A43E6243A8A778B99BBCDC20@BYAPR07MB4999.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0365C0E14B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8VMcJeuyxsiX02GbQ/iN2Ui4ACNv4i35VZFxHozMj7Y3i2PHc0oSqCfrTZpUnXRtfHKX/1wsY24K/eojPn4XjZFddJOGgZIU1pj4biNigThIVpo96AnLWXJOfsikXBGgGqtLzUMtQhvJCynq9w1jDWtYHbZA/sy0aune3/jT1FPHNIGfXSC/cy3FM3IjbWr+7t4KQu7H6vkaeRjFKohs5Bhht7vSAMCdGii/DDIlNxSGhcpfGjiQguXaCzcuT6zLUDn4d8FXw2ROzca4VzDfmaCBd6gjt+RMeh97nsauMlE5hUbgvnGi7dj/gb3Sv0Pt/PpvMHAMoSYcy93lvWHyeQHALomCJzEHZ84VgHYoEcBi2vYXG4kMnf/Eg1WoRL/uHohoQQjx+P7+Ea6atZiuZ1vJDYoQJlyyzMh3ZiZ5kYYdGoTdIqX7lBZ0kx1+BY7EdhpY26Eq8wXVmFGgllZaL3Xevwhu1AlFJ/tb8YRRY0G0pzxmjohylw/xGvGD0iLgOUJlCPEsbKTOoFVC5jIU9EduhpBDI+nbEm2ckQ8r5CjPiTyrSwtPb0+GT9wxRIPuhaianRe/pDDMZXOn/zYUEHuztstM2wQczt79/boBbCei2Z7fR7hjJhBhqsJbf9nO
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 13:13:48.4412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a88dbcc6-997a-465a-dad9-08d7da2c57f7
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4999
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-06_07:2020-04-06,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=961
 spamscore=0 suspectscore=1 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060112
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add documentation for cadence ddr memory controller EDAC DTS bindings

Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
---
 .../devicetree/bindings/edac/cdns,ddr-edac.yaml    |   47 ++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml

diff --git a/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml b/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
new file mode 100644
index 0000000..30ea757
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
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

