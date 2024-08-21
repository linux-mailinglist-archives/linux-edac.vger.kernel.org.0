Return-Path: <linux-edac+bounces-1705-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B9A959507
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 08:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AAE51F21610
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 06:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746C63DAC0A;
	Wed, 21 Aug 2024 06:48:44 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A1D21C18C;
	Wed, 21 Aug 2024 06:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222924; cv=none; b=RA0U+zdP7IH0L8ql5BLvFA9zqUtWFOwTnZuywoiLzNEtPB0Sk4mFZBOj6qu+jiIwppKPg8EoB1tN7nHHjOyPmJrIEtdn5FBGqWdN9Er8/NxYa+bNbm+mLpDlyoJYQ3eH6jASNrT0CnogMblfwHdQT/h/86P5e8jb2/ghuLNrkoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222924; c=relaxed/simple;
	bh=X65EdLnfB4BTJZJJW9+FhPRXsPWM+IV8vfFzB49vd2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PzCteHLf0oCDbLKwjHDOxKZYCu3IyTreLAou/bIICTXP8790FAQDcVwKOSlUWoMTlmo2JAFw4UadIi6z5aD3WRVnvjPeA2DnPOZgtEAse+kGM2qV4PFK4j4ykmbLhQrVCWAHAVd9wk7hxU4CezEwF/j++RE+Qa/8ULOz0TjEe+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.90])
	by gateway (Coremail) with SMTP id _____8Cxe+rIjcVmkOkaAA--.58345S3;
	Wed, 21 Aug 2024 14:48:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.90])
	by front1 (Coremail) with SMTP id qMiowMAxVOCxjcVmQVQcAA--.59935S4;
	Wed, 21 Aug 2024 14:48:38 +0800 (CST)
From: Zhao Qunqin <zhaoqunqin@loongson.cn>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	devicetree@vger.kernel.org,
	zhaoqunqin <zhaoqunqin@loongson.cn>
Subject: [PATCH v1 2/2] dt-bindings: EDAC for loongson memory controller
Date: Wed, 21 Aug 2024 14:47:28 +0800
Message-Id: <20240821064728.8642-3-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240821064728.8642-1-zhaoqunqin@loongson.cn>
References: <20240821064728.8642-1-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxVOCxjcVmQVQcAA--.59935S4
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr1xCr1xKw48WFW8tF48Xwc_yoW8uFy8pr
	n3uwn7KryxK3W7CwsYgFy8AF1rX3s5A3ZrXFZrJ3sFgFyDX3Z0v3Wakry7Xan8CF18XFWU
	ZFZa9w4YkF4xArcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8XTm3UUUUU==

From: zhaoqunqin <zhaoqunqin@loongson.cn>

Add: drivers/edac/loongson_edac.c

Signed-off-by: zhaoqunqin <zhaoqunqin@loongson.cn>
---
 .../bindings/edac/loongson,ls-mc-edac.yaml    | 35 +++++++++++++++++++
 MAINTAINERS                                   |  7 ++++
 2 files changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/loongson,ls-mc-edac.yaml

diff --git a/Documentation/devicetree/bindings/edac/loongson,ls-mc-edac.yaml b/Documentation/devicetree/bindings/edac/loongson,ls-mc-edac.yaml
new file mode 100644
index 000000000..29e5b8381
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/loongson,ls-mc-edac.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/edac/loongson,ls-mc-edac.yaml#
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
+
+  compatible:
+    const: loongson,ls-mc-edac
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
+    edac: mc0@1fe00600 {
+        compatible = "loongson,ls-mc-edac";
+        reg = <0x0 0x1fe00600 0x0 0x50>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 958e93544..bc419e309 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13017,6 +13017,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
 F:	drivers/thermal/loongson2_thermal.c
 
+LOONGSON EDAC DRIVER
+M:	Zhao Qunqin <zhaoqunqin@loongson.cn>
+L:	linux-edac@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/edac/loongson,ls-mc-edac.yaml
+F:	drivers/edac/loongson_edac.c
+
 LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
 M:	Sathya Prakash <sathya.prakash@broadcom.com>
 M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
-- 
2.31.1


