Return-Path: <linux-edac+bounces-5741-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MuKKRXEnGnJKAQAu9opvQ
	(envelope-from <linux-edac+bounces-5741-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 22:18:13 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 490C117D7A9
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 22:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E1C130910B8
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 21:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5100B378815;
	Mon, 23 Feb 2026 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Tr8rc3+v"
X-Original-To: linux-edac@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DE036AB68;
	Mon, 23 Feb 2026 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771881429; cv=none; b=GC5i9uPeOu/TOZFcA7c2+SEFu0Af/sBYJ5EGKr84fpGJfJvdSxyW65KYx+B7lFoIFUYvxr+G1w0bpHdvdkLpoFxvt86zG3QRxOFCmyXRLr3AXtzXRqJdtKNejku8/8+22F4AL/z+gixSt2OijA/wNcNxPJvFg2aXf9tGXlMIQmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771881429; c=relaxed/simple;
	bh=pRBtaGgw/VpTBaNHWxqH3NSuhhB275SjP9lAoqySfrI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ly6HYTpAAhbzczMEkCvpVZ7EFiPCJosJ5DfIjTqpfjt2y7XawqtObucLxlmRj/CdNN8ZxXaUzSFuMl/xbf6cgfKs0QcIC/9gupD5VcIGNAMlcbEy8fBVEKk5p3ZDjgewJCTh7+p17VzE31LRYqE8o2ho3ypAL/MNMLKcrlVhq/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Tr8rc3+v; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1771881425;
	bh=pRBtaGgw/VpTBaNHWxqH3NSuhhB275SjP9lAoqySfrI=;
	h=From:Subject:Date:To:Cc:From;
	b=Tr8rc3+vtBbf7yvzh/sxtUs8S+9NobbQ/c2r/xpNIz0BJoGdz0TVNQwRg3LmjIHn3
	 I7qwNTsV3BVOY6wIYUpqb6Kxv6Zozmf8+CsPW2sdF50VS03WSuMLBZHUbJvvC65zo4
	 zF5M964192P6I2YwRedrFLifcukSRHb9bn3NPqdk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/7] EDAC: Sysfs attribute constification and some cleanups
Date: Mon, 23 Feb 2026 22:16:27 +0100
Message-Id: <20260223-sysfs-const-edac-v1-0-3ff0b87249e7@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBswI6muEi3UppqNhhNRSHdPW
 r7F/xmEEpPAWGVIdLFwDAVNXYHfbdgIeSkGrbRRWrcoj6yCPgY5kRbrsWuNcoOxvTMOSnYkWvn
 +l9P8vh8PQNJkYgAAAA==
X-Change-ID: 20260223-sysfs-const-edac-5360b96a8b6b
To: Dinh Nguyen <dinguyen@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 Tony Luck <tony.luck@intel.com>, Johannes Thumshirn <morbidrsa@gmail.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771881425; l=1043;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=pRBtaGgw/VpTBaNHWxqH3NSuhhB275SjP9lAoqySfrI=;
 b=aAJcevfSHbggY9Po6gYmtLAHJ6NtacDnFoaacoNfdExCc4Nbl+96FyWprJ9l+UDJQdpLAPptr
 t8v/7jMBQRmBjR6F1QdjTFzeIFpxShyhxV54N+fdKPxwa28tH2TESiv
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-5741-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,alien8.de,intel.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	DBL_BLOCKED_OPENRESOLVER(0.00)[weissschuh.net:mid,weissschuh.net:dkim,weissschuh.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 490C117D7A9
X-Rspamd-Action: no action

Move the sysfs attribute to read-only memory and perform some trivial
cleanups.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (7):
      EDAC/altera: Drop unused field eccmgr_sysfs_attr
      EDAC/device: Drop unused macro to_edacdev_attr()
      EDAC/device: Drop unnecessary and dangerous tasks of attributes
      EDAC/device: Constify info sysfs attributes
      EDAC/pci_sysfs: Constify instance sysfs attributes
      EDAC/device: All addition of sysfs attributes
      EDAC/mpc85xx: Constify device sysfs attributes

 drivers/edac/altera_edac.h       |  1 -
 drivers/edac/edac_device.h       |  2 +-
 drivers/edac/edac_device_sysfs.c | 24 ++++++++++--------------
 drivers/edac/edac_pci_sysfs.c    | 10 +++++-----
 drivers/edac/mpc85xx_edac.c      |  2 +-
 5 files changed, 17 insertions(+), 22 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260223-sysfs-const-edac-5360b96a8b6b

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


