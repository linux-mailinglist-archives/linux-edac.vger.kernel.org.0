Return-Path: <linux-edac+bounces-1931-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D2A98997E
	for <lists+linux-edac@lfdr.de>; Mon, 30 Sep 2024 05:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22291B209F5
	for <lists+linux-edac@lfdr.de>; Mon, 30 Sep 2024 03:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2665364BA;
	Mon, 30 Sep 2024 03:31:43 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017732837B;
	Mon, 30 Sep 2024 03:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727667103; cv=none; b=bo3Yj77hWtt4ySQ8pf9GMME6JfTgtdUsep24pkmZYyrRQ781W5ilZWftXz/8lGOicNxQ0h6dyfHfIRDcMnR0i+N2LAz8jhzF2c3H8J5ilD7OWOh6kCcKfmOGMqyCoEv7ztNNBqsWX/w/NP9hdGXtxflFT40LvvtVDb/xUEHFHoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727667103; c=relaxed/simple;
	bh=ZvLeRG4Ms+AsQQg8nv2hbnbMnmitMejRAfLCvTgiTT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qNM4OOL5supr8TcK10zF38kcyU57YtB85qYS8mhSSv87qKqiHl8kGby+GrBuy7Wl2/1wNdU/fVTTbdR0/6Xb2L6/GfwIX1Zd+SQ5nNVoHvFVnqEcImTsAsfnw7HKT7dA+GT0Uc9FfewRm00RMs6EZ6jYAl21aJXc0uMM5G73+aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.90])
	by gateway (Coremail) with SMTP id _____8Bx22qbG_pmol8EAA--.4321S3;
	Mon, 30 Sep 2024 11:31:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.90])
	by front2 (Coremail) with SMTP id qciowMCxbceZG_pmD9gYAA--.23677S2;
	Mon, 30 Sep 2024 11:31:38 +0800 (CST)
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
	Zhao Qunqin <zhaoqunqin@loongson.cn>
Subject: [PATCH v6 0/2] Add EDAC driver for loongson memory controller
Date: Mon, 30 Sep 2024 11:29:41 +0800
Message-Id: <20240930032943.5182-1-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qciowMCxbceZG_pmD9gYAA--.23677S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7JFyDtrWDJw1rur4xuF4kGrX_yoWxtFg_Ca
	17Aay8Jr4vyFyDJay2qr18ZFW5tF4UKasYkF1qgw15Xr4avr13Wr97Xa4UCF17Jw1DWFn3
	ZrZ5KryxA3W8tosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j0mhrUUUUU=

Add a simple EDAC driver which report single bit errors (CE) only on
loongson platform.

Zhao Qunqin (2):
  dt-bindings: EDAC for ls3a5000 memory controller
  EDAC: Add EDAC driver for loongson memory controller

 .../edac/loongson,ls3a5000-mc-edac.yaml       |  44 +++++
 MAINTAINERS                                   |   7 +
 arch/loongarch/Kconfig                        |   1 +
 drivers/edac/Kconfig                          |   8 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/loongson_edac.c                  | 168 ++++++++++++++++++
 6 files changed, 229 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/loongson,ls3a5000-mc-edac.yaml
 create mode 100644 drivers/edac/loongson_edac.c


base-commit: 61124f42dcaa30f58a8b47a2b69ddb80260677c7
-- 
2.43.0


