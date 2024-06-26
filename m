Return-Path: <linux-edac+bounces-1375-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DA1917C94
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 11:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6F71F22311
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 09:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E194516C854;
	Wed, 26 Jun 2024 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kK/5HHxh"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64AD16A92B;
	Wed, 26 Jun 2024 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719394427; cv=none; b=kut+kkMmdUImcH7vyVyURUuouprQ6dM6P0nnl2nyUDAj4pkc/oQkDJJp9SE/sB71asgfSFKLd5sZQ7OYy+/SXadl1M2TH4HvjG6p/ww07zGwUFLpyaHzghKWT8n2eyU14PxoXbS7xpN3dQv3mZXpmfGYZherYGnfOIpT7WiWaLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719394427; c=relaxed/simple;
	bh=EbfiOlmbYgzxHeaGEJru1qN0I6Ch6Nlbu6LOKQXKdU8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PI8ay5tH0QB8aC3VJqXnpgjWTkP5eDVNafhuXzFFA/eJVdPNXKT9tvrAPNLUlNuvDH3TZdCJa11CaGsfHRS0ooJcZ5O7/Cu4569+oDMTG2Q/U07h1J9Sl0lx+2KX/Yodk9DQlxlHayC+xbCYzDR2iJD6QR2ucv9HwCXdB9Q47K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kK/5HHxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0CDC2BD10;
	Wed, 26 Jun 2024 09:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719394427;
	bh=EbfiOlmbYgzxHeaGEJru1qN0I6Ch6Nlbu6LOKQXKdU8=;
	h=Date:From:To:Cc:Subject:From;
	b=kK/5HHxhxNvIQh9kncbgt2LUPODnmWVPzu4FdoMdRpkEBbsFo/jlfkMEp7SuKR0ir
	 qsa6qcgcwdZniUAaEDtwfGFMpKg5C9uonLhxC4GzrJJhC8RGYKFj8dHCdzD4JZ+BJ3
	 W6kM8lRU6to1NQyls2STMWDorzLl/RC2UBUyh4wKXHXPDYsZk53H5/yfDtFGvIawq3
	 S4q+DNnNZhC8Odci3lYPiBumptf4Tg2I3hrsukMNC+FXcC8LBOX32qDS5djmClCjKU
	 gxC98B+4orXRU10EQM3ws3ED2UjjOwQ4iIJLPTtPA9KOj3dn5v6SQ3YiwS/p1NuQTN
	 lxnxUOL2OSUSA==
Date: Wed, 26 Jun 2024 11:33:41 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>, EDAC Mailing List
 <linux-edac@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab
 <m.chehab@huawei.com>, Shengwei Luo <luoshengwei@huawei.com>, Daniel
 Ferguson <danielf@os.amperecomputing.com>, Jose <shiju.jose@huawei.com>,
 Jason Tian <jason@os.amperecomputing.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [GIT PULL for v6.10-rc6] edac fixes for kernel 6.11
Message-ID: <20240626113322.5e263aa0@coco.lan>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Borislav,

Please pull from:
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-edac tags/edac/v6.10-1

For two patches that fix UEFI 2.6+ implementation of the ARM trace event, 
as the original implementation was incomplete.

The patches on this series was sent at:
	https://lore.kernel.org/all/20240321-b4-arm-ras-error-vendor-info-v5-rc3-v5-0-850f9bfb97a8@os.amperecomputing.com/

I did a couple of changes at the first patch addressing some coding style
issues. At the second patch, I replaced the original description to a proper
one identifying precisely why the patch is needed and what it does.

In summary:
changeset e9279e83ad1f ("trace, ras: add ARM processor error trace event")
was incomplete: it added a trace event that was reporting only some fields
of the CPER record generated for ARM processor from UEFI 2.6 spec.

Those are not enough to actually parse such events on userspace, nor to
take any actions like isolating problematic CPU cores.

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

Regards,
Mauro

---


The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:


Thanks,
Mauro

