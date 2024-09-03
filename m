Return-Path: <linux-edac+bounces-1792-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C18969C4F
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 13:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291951F23BD2
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 11:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773821B984D;
	Tue,  3 Sep 2024 11:46:56 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBFF1A42DB;
	Tue,  3 Sep 2024 11:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364016; cv=none; b=H81LgruS5WbmAIrcHOrlxBSJ7kBpeze/C3vj2hOKuFZOfEbZHQWOPQobRna/XAiQo7G04t4mFOxpjV9FAiaT1G7y5eHXM7hdLZ7yjvezEdaM6YzKzi8UWoZwmB5vhyDVdzD2EyIvVMMPu8et0baSFqmV1TqIDnJtLtPXkfRPupU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364016; c=relaxed/simple;
	bh=qOsGnJZU+VeCZn5v++Lbe0UfkouHSmZ71Z4OyXA0Rrs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gzE0ZH9lLWfiw1HErpKGzqPefvvFg+F1s8y0vCOTFmecbVABCLU37ckycme9nmHrauapRsU/rDqebpQPBi/baAxRcCbV17vok4oWS45ojtYTDmYgTlWXTWjOfY7CGopAEJjSFr8LfqIw3M2WOb/0IN1yfkBIsqZlB67qZkYIMvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.90])
	by gateway (Coremail) with SMTP id _____8AxSZos99ZmJiUpAA--.42869S3;
	Tue, 03 Sep 2024 19:46:52 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.90])
	by front2 (Coremail) with SMTP id qciowMAxvsUr99ZmONYEAA--.13062S2;
	Tue, 03 Sep 2024 19:46:51 +0800 (CST)
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
Date: Tue,  3 Sep 2024 19:47:12 +0800
Message-Id: <20240903114714.11428-1-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qciowMAxvsUr99ZmONYEAA--.13062S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7JFyDtrWDJw1rCw4DZF17XFc_yoWxtwb_C3
	W7Aay8Jr4vka4DJay2vr18ZrWjyF4UJF95CF1qqw15XF4avr13XFykuasxAa47Jr1DWF13
	ZrWkKryxA3WxtosvyTuYvTs0mTUanT9S1TB71UUUU1UqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbhxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF
	7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUeVpB3UUUUU==

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


