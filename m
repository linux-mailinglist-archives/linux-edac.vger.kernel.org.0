Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3060425F2C5
	for <lists+linux-edac@lfdr.de>; Mon,  7 Sep 2020 07:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgIGFsk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Sep 2020 01:48:40 -0400
Received: from mail-bn8nam11on2074.outbound.protection.outlook.com ([40.107.236.74]:38752
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726722AbgIGFsc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 7 Sep 2020 01:48:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRpO4U33rFusl622wtROsYrz3V0dvlfS/DUOAU/p20lQx4M7KTzQN0gn2bZ7UsRfhL+wv/jOtWX1dwSPikYu/I6NfPX/Ld0gUKpr5flamLlLcIOR8xjjTU9nFpLEe6Md2wuoIU7FIwGMeOXotoxITPktDSKrY+9LXqLfGsoaGS3eBks7x/iv382pL/pSe9a7OgBfH7AXxbrQRaFf2Kie2gwZoyWhc7JmfHdOhtmTSGu7BxiOebt6KvCmNsJPSEiFpCffWTUYPGAKE0vwvQ5+WpjrhOOshiwm9TJFAJ4/NrdpdJDxhm+cD120lAv5Sd76rrsAq7LELk9Qhtrwsni5cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edaubNebScrLazGFfVDZfXo46tuczlTu8YJDPZg88Ss=;
 b=cQJCTdIl64fGorlSEYeuuY4uuEBzcwb+pAJ0mqtZcHobMFF7SmcTcf5I38PZmYwbwFVlJKvN7Z48ukd85nK8D+4wlKW4fOdZV+wUAfZj705+LYaIv8iV+quS0fV0Gskr/A2ijDuxemdZKjCNPXuKdT5R/jRxcpFHLSnTKPqjov/iqn+hFL7aI0WnrCf93Bsztpjs71LufQDnKwVPeH47s8qvMg+wemqrOmYvjB9BhEtDPNrQGlihGR3Icdtamge+ynT+LpVxB9wQRblrD1M3sBmXVUArYs7JaTuVBGc49yjFzqE0NzlOWclRa+MPGu2Hak2Ew8nc+LMd3mOZjWGwvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edaubNebScrLazGFfVDZfXo46tuczlTu8YJDPZg88Ss=;
 b=TOoNtC0Meu12QGVy2Z97azUAjq7Ne13KTL3V+sJzzs62PoEu2F/szqSRBNULXLTxol+NWSAzlrqOe47vpuR/+LKoqebq17cmGZWPGjUtBkHNqdI7d7+Ep4KFmMsnsWjzwqS/GhmzFg7ZQUtGLREoIxiXL+qpsmSwcwfuUq+Ip5U=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from BN6PR1301MB2020.namprd13.prod.outlook.com
 (2603:10b6:405:34::34) by BN6PR13MB1569.namprd13.prod.outlook.com
 (2603:10b6:404:119::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.7; Mon, 7 Sep
 2020 05:48:30 +0000
Received: from BN6PR1301MB2020.namprd13.prod.outlook.com
 ([fe80::4596:33b0:db2c:dea]) by BN6PR1301MB2020.namprd13.prod.outlook.com
 ([fe80::4596:33b0:db2c:dea%3]) with mapi id 15.20.3370.011; Mon, 7 Sep 2020
 05:48:29 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     robh+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com
Cc:     aou@eecs.berkeley.edu, james.morse@arm.com, rrichter@marvell.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v2 1/3] dt-bindings: riscv: Add DT documentation for DDR Controller in SiFive SoCs
Date:   Mon,  7 Sep 2020 11:17:57 +0530
Message-Id: <1599457679-8947-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599457679-8947-1-git-send-email-yash.shah@sifive.com>
References: <1599457679-8947-1-git-send-email-yash.shah@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: BM1PR01CA0141.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:40::35) To BN6PR1301MB2020.namprd13.prod.outlook.com
 (2603:10b6:405:34::34)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from osubuntu003.open-silicon.com (159.117.144.156) by BM1PR01CA0141.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:40::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3348.15 via Frontend Transport; Mon, 7 Sep 2020 05:48:25 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [159.117.144.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b99ff1a8-b5be-468d-de71-08d852f1a5ef
X-MS-TrafficTypeDiagnostic: BN6PR13MB1569:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR13MB1569F4CDADC8220D590B6B1282280@BN6PR13MB1569.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Ek0Ywbey1cSQyOR2V+7A0PvKx2S59miPu5GZiPZQDc9ESJeGdxGJ7vMSdpWoRh/XPTR4b9dvH7hUo1hJcQO1G2NltcnQGZmmUuhcBwf0Q6El+OJEwxeH5qiDiVgf1Hb/0/W5c44nFXQssE8neQZoHbt8X5bAglQgPmAG64y1NSmc+fwsmSUG2rn4uGAtD9lzL0GeHEMCGfZlWFUdL8jNWvRrfMgDmzxD34Lx3El0SJJY1myPo6nL63Vu0IXLxvhq7EOazC+AETwV4ZFQUmKWSKWbtfAu4Q4FgQq2d2uGKHv28C3ZPtnZBblmHu8n4mf+f9aUUfTmRe9c+MSBC8uyYRXEI4FFgYG1rgPALdtClRinbKn1t/M1riTLsh8QdCqR5hubsaQ5UL90odKX+XG5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1301MB2020.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(376002)(396003)(136003)(366004)(39840400004)(346002)(44832011)(5660300002)(6506007)(2906002)(36756003)(6512007)(4326008)(6666004)(16526019)(186003)(8676002)(316002)(2616005)(956004)(52116002)(8936002)(6486002)(26005)(66476007)(107886003)(66556008)(66946007)(83170400001)(966005)(7416002)(478600001)(42882007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: eQJ431Xy3WUbo8d9df2NyYU9XmvTsAgzRxCPZ6ayyOs1+Z1EX5LFNVpzt0h/jF/hoBmQJULz8hk48tArFKk5jk4fHp+eJxn5ijbWyoyYJseZCtkbYWQMucqO0KSpL7fFgQFMQyS8H1pqdDoS8V9XgEunolaZx5niyM5BkcTsto7r4KN1+K3TpTLKcuggJXjuqdkhs77/a+UnoxB1Y0E7dj7nycHtwgWbzyq+iPjxGBzobp75WS4DMDbOLYJImx6Wjxw939m+MH1XcKXXvspPYCia7fko6xrK8FGzHD+KVdWd5+m+vlea5P2B/WKtJzSGjiCdqfIy5SedzfgmvUtfGoowVxsMVUwvnHcNOR+ZvT2O9W2xNyKex/9EG10taw70Kzghl4vYZWim47kJhr+QPyhzQ6lpxgqaXbGTtm5ZSsBRfIFnKpWGYbe8MC/9KZyGxDjlfq4scy/T5V2k/NzmaEmMm+cqkjw8x4s7RJxRZ/N2wCZlbd4ajf3I4nT+ll9wz+64F66qosNICLIirTjlb/3iWb5IjGP0glMVAQmKlyXRQiUGZf8klLHGjkIdaiw/q6QQ7UMmJr8MXgPprRhodkvdzGzFERSx8SW8xlDZxDCnJto2SCilIjOpkhY0MKnwfclW1n7jbdCyOf8lpbL0WQ==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99ff1a8-b5be-468d-de71-08d852f1a5ef
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1301MB2020.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 05:48:29.9060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhbDKpE4IjErJFEes4wYlW0EYCfUqVwISXbx+ykO1iKFwFM6xyQeUwToJng5NXTpuPjcJWQyXFaw/oONvRSkUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB1569
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add device tree bindings for SiFive FU540 DDR controller driver

Signed-off-by: Yash Shah <yash.shah@sifive.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 .../devicetree/bindings/riscv/sifive-ddr.yaml      | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/sifive-ddr.yaml

diff --git a/Documentation/devicetree/bindings/riscv/sifive-ddr.yaml b/Documentation/devicetree/bindings/riscv/sifive-ddr.yaml
new file mode 100644
index 0000000..0288119
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/sifive-ddr.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/sifive-ddr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive DDR memory controller binding
+
+description: |
+  The Sifive DDR controller driver is used to manage the Cadence DDR
+  controller present in SiFive FU540-C000 SoC. Currently the driver is
+  used to manage EDAC feature of the DDR controller.
+
+maintainers:
+  - Yash Shah <yash.shah@sifive.com>
+
+properties:
+  compatible:
+    enum:
+      - sifive,fu540-c000-ddr
+
+  reg:
+    maxItems: 1
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
+    memory-controller@100b0000 {
+        compatible = "sifive,fu540-c000-ddr";
+        reg = <0x100b0000 0x4000>;
+        interrupts = <31>;
+    };
-- 
2.7.4

