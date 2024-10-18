Return-Path: <linux-edac+bounces-2136-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DF99A3235
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 03:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12E821F23F85
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 01:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ACD140E3C;
	Fri, 18 Oct 2024 01:45:47 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C8813B288;
	Fri, 18 Oct 2024 01:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729215947; cv=none; b=BfFFqHIY1y8Q3K5x+1wPUafZSI0ZoMsJFmUKO97ZA56zkiJO3EL9vxScITxgKqM5utCwNfOJrID23lFBiCgnfwKGBiwh14jINmG5neI503LfPjLaVjM7WBs1kO7Pd3bsz/J/zLOK2XGwOHmecRN/yIw0bQN7f79yaBG0IKP1IBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729215947; c=relaxed/simple;
	bh=bdft0GveiJOgmlwiqu80tDEqUiGpXv4NyBkfkR8QmsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Of53xWQQ+zSAhUPuCrjOAKZxicjMT5JGVrgslacpTG431VWiNv4Wg3HSyH6Rg92lapJknGoH1GG+0vCV5Xl/aEWSp+ykIpoXaVZ6lKDKzyPMzZTaY/KhAUkfCl9cRfHmcyVJvUv2J23z8cRv1JaGEYjN0YWzS+EdlU4FT2oYN1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.90])
	by gateway (Coremail) with SMTP id _____8AxvvDCvRFnSTcjAA--.51955S3;
	Fri, 18 Oct 2024 09:45:38 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.90])
	by front2 (Coremail) with SMTP id qciowMCxSsa7vRFngI0yAA--.18897S3;
	Fri, 18 Oct 2024 09:45:35 +0800 (CST)
From: Zhao Qunqin <zhaoqunqin@loongson.cn>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	chenhuacai@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org
Cc: linux-edac@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@xen0n.name,
	loongarch@lists.linux.dev,
	Jonathan.Cameron@Huawei.com,
	Zhao Qunqin <zhaoqunqin@loongson.cn>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 RESEND 1/2] dt-bindings: EDAC for ls3a5000 memory controller
Date: Fri, 18 Oct 2024 09:45:41 +0800
Message-Id: <20241018014542.27283-2-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241018014542.27283-1-zhaoqunqin@loongson.cn>
References: <20241018014542.27283-1-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qciowMCxSsa7vRFngI0yAA--.18897S3
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWw1rtrW7ZFyrGw4ruF17Arc_yoW5GFWrpr
	s3Aan7Kry8t3W7Aan5XFyxAa1Fqw1kZ3W7XFs7Kw13KryDWa4FvFyYkryUXan8JrykXFW5
	ZFySgr42kFsFkwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jr9NsUUUUU=

add device tree bindings for ls3a5000 EDAC driver.

Signed-off-by: Zhao Qunqin <zhaoqunqin@loongson.cn>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes form v5 to v6:
	- None

Changes in v4:
	- Added tag from Krzysztof (thanks!)

Changes in v3:
	- None

Changes in v2:
	- Fixed the errors raised by Rob
	- Addressed review comments raised by Krzysztof and Conor

 .../edac/loongson,ls3a5000-mc-edac.yaml       | 44 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/loongson,ls3a5000-mc-edac.yaml

diff --git a/Documentation/devicetree/bindings/edac/loongson,ls3a5000-mc-edac.yaml b/Documentation/devicetree/bindings/edac/loongson,ls3a5000-mc-edac.yaml
new file mode 100644
index 000000000..52f10bc94
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/loongson,ls3a5000-mc-edac.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/edac/loongson,ls3a5000-mc-edac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson Memory Controller EDAC
+
+maintainers:
+  - Zhao Qunqin <zhaoqunqin@loongson.cn>
+
+description: |
+  EDAC node is defined to describe on-chip error detection and correction for
+  Loongson Memory Controller.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - loongson,ls3a5000-mc-edac
+      - items:
+          - enum:
+              - loongson,ls3c5000l-mc-edac
+              - loongson,ls3c5000-mc-edac
+              - loongson,ls3d5000-mc-edac
+              - loongson,ls3a6000-mc-edac
+              - loongson,ls3c6000-mc-edac
+          - const: loongson,ls3a5000-mc-edac
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    memory-controller@1fe00600 {
+        compatible = "loongson,ls3a5000-mc-edac";
+        reg = <0x1fe00600 0x50>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 42decde38..6cc8cfc8f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13237,6 +13237,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
 F:	drivers/thermal/loongson2_thermal.c
 
+LOONGSON EDAC DRIVER
+M:	Zhao Qunqin <zhaoqunqin@loongson.cn>
+L:	linux-edac@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/edac/loongson,ls3a5000-mc-edac.yaml
+
 LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
 M:	Sathya Prakash <sathya.prakash@broadcom.com>
 M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
-- 
2.43.0


