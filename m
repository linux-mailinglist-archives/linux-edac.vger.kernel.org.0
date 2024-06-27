Return-Path: <linux-edac+bounces-1399-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 671D191A3F7
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 12:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122051F22B81
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 10:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC48913E032;
	Thu, 27 Jun 2024 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaQoMGLP"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B3413DBBB;
	Thu, 27 Jun 2024 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484575; cv=none; b=rApBJGK84kegYvCf3sOm9pv4vu/qD5cp13m1EKyIgcqSMOm2S/u9RfPu+6ZOiuKOa2WJ0ubx3n3mMSAHF0z5mZltowx/FE9htDmLA+ujJUZ6uCdNEPER+pQasGr7IhvxexWF/JadoY7Ffl0zCsg/MyWSoq01DeR80khEK4SMZ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484575; c=relaxed/simple;
	bh=OZb1hgH+weNbGpSscFVZqVyZIuVtleLiBIPJVxoWWVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BIUmuvxo7RshpUFP1y3LoeCh+jhtPLoF6WeeF2u1X9eDn/dgnhJ5cny9AQCXmNVEHVDs0Gw0+JAB2k0XQBpi44NXYxLcTGZml2w7CT+/wSHD3Hkj48bniyAf4J6kVkLoPCUDHhZiYU5Nv78RlX2myBdRydAv0IoLhw+qwgjt0Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaQoMGLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D548C2BBFC;
	Thu, 27 Jun 2024 10:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719484575;
	bh=OZb1hgH+weNbGpSscFVZqVyZIuVtleLiBIPJVxoWWVo=;
	h=From:To:Cc:Subject:Date:From;
	b=CaQoMGLP1IpUotKvfgJNhnqBko/YOKTLd+7YVQDaRm5B/AUGETNjHVbXHwHnhzD+9
	 r9YNS+NxG9xprvaPd7darZ1fYmMRSDwnlIfdQuXvbpps0cMkXOXqrrmGSKu5TsVzJC
	 6q3XAxWqe4RRYcK107NprmKjWxhPL5nwT7m0iAf2G0Nl6w98aWB9FZM0p4CL8XTD5M
	 KLnFSZaNIqclYj+EssXJSvuuXmlRti+s01gbGou6LElUSAz3rSrIq0hcszxMAPiWZK
	 pHJ9zfnNEdq9521T0/LFZdxtUXvQq3yha7oYSrrHtqnjMpJJlifmzpT7iIaCyl+XCo
	 4fYLgZ6ffVj9w==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sMmU9-0000000BC8u-0Mwx;
	Thu, 27 Jun 2024 12:36:13 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	James Morse <james.morse@arm.com>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add other fields to ARM trace event
Date: Thu, 27 Jun 2024 12:36:06 +0200
Message-ID: <cover.1719484498.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

This series was originally sent at:
https://lore.kernel.org/all/20240321-b4-arm-ras-error-vendor-info-v5-rc3-v5-0-850f9bfb97a8@os.amperecomputing.com/

Those patches that fix UEFI 2.6+ implementation of the ARM trace event,
as the original implementation was incomplete.

In summary:
changeset e9279e83ad1f ("trace, ras: add ARM processor error trace event")
was incomplete: it added a trace event that was reporting only some fields
of the CPER record generated for ARM processor from UEFI 2.6 spec.

Those are not enough there to actually parse such events on userspace,
for it to properly report/record the error nor to take appropriate measures
to prevent future problems, like poisoning problematic CPU cores and taking
them offline.

The patch was validated with the help of an ARM EINJ code for QEMU:

	https://github.com/mchehab/rasdaemon/wiki/error-injection

I tested the ghes and cper reports both with and without this change,
using different versions of rasdaemon, with and without support for
the extended trace event. Those are a summary of the test results:

- adding more fields to the trace events didn't break userspace API:
  both versions of rasdaemon handled it;

- the rasdaemon patches to handle the new trace report was missing
  a backward-compatibility logic. I fixed already. With that, rasdaemon
  can handle both old and new trace events.

Btw, rasdaemon has gained support for the extended trace since its
version 0.5.8 (released in 2021). I didn't saw any issues there
complain about troubles on it, so either distros used on ARM servers
are using an old version of rasdaemon, or they're carrying on the trace
event changes as well.

---

- v2: fix a bad conflict resolution affecting non-arm compilation on patch 1.

- Changes over the original changeset:
  - First patch was simplified to avoid too many #ifdefs;
  - reordered local vars using reverse xmas tree;
  - removed uneeded typecasts;
  - some coding style fixes.


Daniel Ferguson (1):
  RAS: ACPI: APEI: add conditional compilation to ARM error report
    functions

Shengwei Luo (1):
  RAS: Report all ARM processor CPER information to userspace

 drivers/acpi/apei/ghes.c | 16 ++++++--------
 drivers/ras/ras.c        | 47 +++++++++++++++++++++++++++++++++++++--
 include/linux/ras.h      | 16 ++++++++++----
 include/ras/ras_event.h  | 48 +++++++++++++++++++++++++++++++++++-----
 4 files changed, 107 insertions(+), 20 deletions(-)

-- 
2.45.2



