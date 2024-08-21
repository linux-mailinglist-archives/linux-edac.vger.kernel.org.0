Return-Path: <linux-edac+bounces-1703-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D754A9594FE
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 08:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833931F22712
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 06:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DB22139CB;
	Wed, 21 Aug 2024 06:48:25 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B5A21C168;
	Wed, 21 Aug 2024 06:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222905; cv=none; b=ZJPe6O+8w08WrOZwZs2Ud20XJxr8/MVC6FVKqkVejfDs3WawkBdAL2jVchFkUo/Ox4O6F90KMz5RhpRLDrb3KB0n5GYD6ku62w1maOiiLsZwzjQ2zGMVRJ6/uKMcDhyJWGpw87bpEX4hRPXUrQnzWfHBtzp1GF9NalNIFJO5/Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222905; c=relaxed/simple;
	bh=TnfqwPhCDzvHlQgyCowvuGGh7oEQuJ1Tf2kdo2IYJS0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sTBmGAjxUxoHR6eUaDdWLrLrlK11auCHfcidPxGbOyLUh/aaF/4K22qLPikZ96owXcgnzAvmPLgtvNXvfwb9nThb/FjZ83iNTkGtqZ29LNkW+6CKcQH1fkksiAkpUzEno9CkKmu2ojSQO5okQ14D5CUfJLiUkhgj/ClnYxJVwJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.90])
	by gateway (Coremail) with SMTP id _____8Bx7eqxjcVmS+kaAA--.58093S3;
	Wed, 21 Aug 2024 14:48:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.90])
	by front1 (Coremail) with SMTP id qMiowMAxVOCxjcVmQVQcAA--.59935S2;
	Wed, 21 Aug 2024 14:48:17 +0800 (CST)
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
Subject: [PATCH v1 0/2] Add EDAC driver for loongson memory controller
Date: Wed, 21 Aug 2024 14:47:26 +0800
Message-Id: <20240821064728.8642-1-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxVOCxjcVmQVQcAA--.59935S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7GF18Kr47ZrWrJw17JF1UurX_yoWxKwc_Ca
	4xAaykGr4kKa4UGayYqr18ZrWaqFWjk3Z5C3Wqqw1rXw1avr13Xr4Du3W3Ca47JF4DWFnx
	ZrW8KF93Z3WUtosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUceOJUUUUU

From: zhaoqunqin <zhaoqunqin@loongson.cn>

These patchs are based on 6.10.4. Add a simple EDAC driver which report
single bit errors (CE) only on loongson platform.

zhaoqunqin (2):
  Loongarch: EDAC driver for loongson memory controller
  dt-bindings: EDAC for loongson memory controller

 .../bindings/edac/loongson,ls-mc-edac.yaml    |  35 +++
 MAINTAINERS                                   |   7 +
 arch/loongarch/Kconfig                        |   2 +
 drivers/edac/Kconfig                          |  10 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/loongson_edac.c                  | 208 ++++++++++++++++++
 6 files changed, 263 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/loongson,ls-mc-edac.yaml
 create mode 100644 drivers/edac/loongson_edac.c

-- 
2.31.1


