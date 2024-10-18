Return-Path: <linux-edac+bounces-2134-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41C89A322F
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 03:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E35283E5D
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 01:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12A37DA93;
	Fri, 18 Oct 2024 01:45:43 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6942BAEF;
	Fri, 18 Oct 2024 01:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729215943; cv=none; b=mppBJ9akUh5g5vDE+BsdeO3AFRSxq+ILejAxIpFhUDKF2N6YCXc4Hl4lK1VeucKn1khQLpWIhgpzmNLEuNRkgJIYn1Y4HIpTlYUXZmWnLIv2kadS4Gy4dvNt8uOSlllOTzMi6GQi1+SMpiMpdKbKgCVFUUrvW0SDEcXgLmo0FL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729215943; c=relaxed/simple;
	bh=ZvLeRG4Ms+AsQQg8nv2hbnbMnmitMejRAfLCvTgiTT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AQbRVe7qoGmuoKgq3qQNgeUtKFp5Vefmsy9cInFtlMX98rRQHmspf9aYymMf3ICCInuaOBKluoC1RAJl+soe243/7691VMDX95AGkE0M+tp3eQ9QBxgIPqeQ63NOsJWhpG/ttjC9M+xWDvcV+LSeiquCy4uqA9qyMfNxasN3xCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.90])
	by gateway (Coremail) with SMTP id _____8Dx8+i8vRFnNjcjAA--.51013S3;
	Fri, 18 Oct 2024 09:45:32 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.90])
	by front2 (Coremail) with SMTP id qciowMCxSsa7vRFngI0yAA--.18897S2;
	Fri, 18 Oct 2024 09:45:32 +0800 (CST)
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
Subject: [PATCH v6 RESEND 0/2] Add EDAC driver for loongson memory controller
Date: Fri, 18 Oct 2024 09:45:40 +0800
Message-Id: <20241018014542.27283-1-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qciowMCxSsa7vRFngI0yAA--.18897S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7JFyDtrWDJw1rur4xuF4kGrX_yoWxtFg_Ca
	17Aay8Jr4vyFyDJay2qr18ZFW5tF4UKasYkF1qgw15Xr4avr13Wr97Xa4UCF17Jw1DWFn3
	ZrZ5KryxA3W8tosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2_HUDUUUU

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


