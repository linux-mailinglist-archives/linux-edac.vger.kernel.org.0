Return-Path: <linux-edac+bounces-1391-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A8A919FF4
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 09:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F009B20BBA
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 07:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ED84317C;
	Thu, 27 Jun 2024 07:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDnl84jt"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7789C1CFB9;
	Thu, 27 Jun 2024 07:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719471958; cv=none; b=UFjAuvRbKjPd/K0TGOuLOz1qDxDo6O1svnFpadAdPNL7dw/us5hPto8+8sZEQI5muLCyA5Fg5MKSPTPkJAi+EXKekuNRUBCVixp/KXgaCKcl+zTOj3wl/465oLgmewc91jCVPjyAPtq2cyrXDkBZxuAcUbOUgO0x4LHaDtcnRZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719471958; c=relaxed/simple;
	bh=unxppICjsOj38X3hg+dykNAKfgScPhTx9LRl/jrcpGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oYAh62n+xqIX+x3NkKjkHcFu5/iGXJmJgXNPMJrmL9X3gM0Kk4x2t5VH2hrkIK7wQRMzARlhRdnZleInmRcdG3V4sTo2xkUnAz5mosVI90z2WdrHOmjPtQmDo72bakaUuaai1aXra/MvkWiiD86moO5ppq35ladtUl9JLX0/fik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDnl84jt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45295C2BBFC;
	Thu, 27 Jun 2024 07:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719471958;
	bh=unxppICjsOj38X3hg+dykNAKfgScPhTx9LRl/jrcpGE=;
	h=From:To:Cc:Subject:Date:From;
	b=uDnl84jttNaIBNsvNoQoZ4ae/ks34b6ZzHnKSnVKdu0yjhrqaLAHtizZ/Oxf5KiO0
	 jtcplnq9VV8hdaADJCO+p3nkgai0P1GaGr8QuGRMs1vOPD6qb0yihGjg9mLKphltc/
	 /1LU2RY02iRb9cnf3s0ZmNZ+TBehZUoTRoFbl8xK8vDgyV1BoqbVJnIbHKEUqUzHF9
	 zDP7cSYgxOuOLt8kaw2FWNSTKstiHbdKJzo3E+Gy7aSEZwpW5AkQjsGDRGb5rNKLjS
	 QE0EJL4APm9MHspaHplUHphZEEGFoIunYBJFXixYxxyVeUUVF16vMY952hrEFZdXVF
	 JcRrDWsDecLOg==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sMjCe-0000000B02K-0O3E;
	Thu, 27 Jun 2024 09:05:56 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	James Morse <james.morse@arm.com>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH 0/2] Add other fields to ARM trace event
Date: Thu, 27 Jun 2024 09:01:07 +0200
Message-ID: <cover.1719471257.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

This series was previously sent at:
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

 drivers/acpi/apei/ghes.c | 14 +++++-------
 drivers/ras/ras.c        | 47 +++++++++++++++++++++++++++++++++++++--
 include/linux/ras.h      | 16 ++++++++++----
 include/ras/ras_event.h  | 48 +++++++++++++++++++++++++++++++++++-----
 4 files changed, 106 insertions(+), 19 deletions(-)

-- 
2.45.2



