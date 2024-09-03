Return-Path: <linux-edac+bounces-1789-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E9C969C47
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 13:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6EE61C235A3
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 11:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF29A1B9826;
	Tue,  3 Sep 2024 11:46:17 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F0319F41F;
	Tue,  3 Sep 2024 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363977; cv=none; b=IFbkCJzo724zAVRzjWPhmqskvuFi34VBDqWeufkBExQ0gkefo5UWjlvohMLrAT7DzJarFV7nTqRTyRwmnmq+KtYtnWgDjlssV/qCm5cMUTaLrN6+DpQUYsdmXH3OyTuh3RIO3gTVTOMzUcOQFmi5Im1+GLTO5+Gp7Z1UIrh31+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363977; c=relaxed/simple;
	bh=qOsGnJZU+VeCZn5v++Lbe0UfkouHSmZ71Z4OyXA0Rrs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vCJV1u9c3Fsi6WGjeh8zbPkM59tcfWm7wPLgwYcEp6R7gwoMh5udQ6ZmGOq9FviDLi3V8d8P2i4T2TN8VcOwv5pgygXu36LCe4mW1LJgekl/TF2RmY+NwGJWe4cGl2ZKmzb7Lrq++Rqi+QsvCeFM1hztJSPQEUglnZwPyxLBHj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.90])
	by gateway (Coremail) with SMTP id _____8Axy5oD99ZmvCQpAA--.43163S3;
	Tue, 03 Sep 2024 19:46:11 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.90])
	by front2 (Coremail) with SMTP id qciowMAxvsUC99Zm7tUEAA--.13055S2;
	Tue, 03 Sep 2024 19:46:11 +0800 (CST)
From: Zhao Qunqin <zhaoqunqin@loongson.cn>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	chenhuacai@kernel.org
Cc: linux-edac@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@xen0n.name,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	loongarch@lists.linux.dev,
	Zhao Qunqin <zhaoqunqin@loongson.cn>
Subject: [PATCH V3 0/2] Add EDAC driver for loongson memory controller
Date: Tue,  3 Sep 2024 19:46:31 +0800
Message-Id: <20240903114633.11365-1-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qciowMAxvsUC99Zm7tUEAA--.13055S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7JFyDtrWDJw1rCw4DZF17XFc_yoWxtwb_C3
	W7Aay8Jr4vka4DJay2vr18ZrWjyF4UJF95CF1qqw15XF4avr13XFykuasxAa47Jr1DWF13
	ZrWkKryxA3WxtosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbSAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jwnYwUUUUU=

Add a simple EDAC driver which report single bit errors (CE) only on
loongson platform.

Zhao Qunqin (2):
  dt-bindings: EDAC for ls3a5000 memory controller
  Loongarch: EDAC driver for loongson memory controller

 .../edac/loongson,ls3a5000-mc-edac.yaml       |  44 +++++
 MAINTAINERS                                   |   7 +
 arch/loongarch/Kconfig                        |   1 +
 drivers/edac/Kconfig                          |   8 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/loongson_edac.c                  | 182 ++++++++++++++++++
 6 files changed, 243 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/loongson,ls3a5000-mc-edac.yaml
 create mode 100644 drivers/edac/loongson_edac.c


base-commit: 090786479325d85cf9f8565ef802cd6dc62c5321
-- 
2.43.0


