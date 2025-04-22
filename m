Return-Path: <linux-edac+bounces-3653-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF0CA9736A
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 19:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512A917C00C
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 17:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62902296152;
	Tue, 22 Apr 2025 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ao4lXA57"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A9822ACDB
	for <linux-edac@vger.kernel.org>; Tue, 22 Apr 2025 17:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745342216; cv=none; b=GwmSPAjtUm05jujWKOvYI0YLSHVr4wT5/sM3eHABsy23dT+8aKndJn2vy4dxDgssRhy+uQvl7DNDZyhXakTnxPqeJ8otpW2mFGpD1pIgyOHrNjNFhDdcg4tutyZDX2lCHD7ykdW3GbzbWjs12rvrMMIlGxE0F5wlYl1tN/zrx8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745342216; c=relaxed/simple;
	bh=rg6/eFMYcvHwXhMHXLFHb1IxZZcl1Hu/AMquQu4ETXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnJJ0/fvQPC2RfjKu1KOpGgMaieiTk67upMPrNpVlVjQe+2awFlzDXM2CW6dt+cYGSCV7zU/gLHrJ6t6Lc9/lTY8LrCGT0ZfcAYE4AQyxKhm72i3cxM07EOik33AM+SaMwdolvLGxmauC7lbG1h4Qp7ZUP+offEF2nY07FtNBcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Ao4lXA57; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 51BE940E01F6;
	Tue, 22 Apr 2025 17:16:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id t0XxqVDyYhzE; Tue, 22 Apr 2025 17:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1745342202; bh=4DT6N6V/UIpAQIejd5F07qdTUanercmrgINfqb+wxKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ao4lXA57hux9KTL4N51zBPUjtHKRWiDLYm/ioV/2eSklDneVlLJVsuXauf6N0xKLY
	 tORSr0uV8J4W85RR8GPf8qc2+QZOCPwYhGsTlTwVLUDTvVIrRTVm5e4EkReTi7yghZ
	 1BgBFmetJVa1VF9DHx8cCgqOHvimN1esBQ80ugk6Rqjv8tA8CHvxan56hTeaarFgk6
	 sMkJ5xpddxLMASHfdFkIr1LiQY0xtjjBIyBb4MIjzzMXyMTs6CUGssuXsHjQzgK6w9
	 fkUFCZFKhUb4Kt0Zcftl8xAowFc1aUWTQyOMUczGdbOTxEsBwBPDUl1QY1I+uP3W6l
	 iXv4gwPDAAvL9vtVhNr+JjaUK3x3I0E8+PHmPUuQAnkMXcGv1HZ8XyEVtwZZCoIr9F
	 DLDh+y1aPQEDsb1Ntajy+2fx1QFgd6hNNDgM0a0k9uhtMKQLPIv/TKoDKZC7PPM1nt
	 2Z188P/4ijjvm9Mvry6vS/YjodjjBror9w0t6zdtAwBUwBc2XrAM9kRPOmPG6JJ4OI
	 LuCEw87MJW1cYA8E/9wodTyQKE1iY3ef+X3PB8oHLykeX35iaXgryV6ldH0EfGIBm+
	 pn8KBY3dSKn4NNeTFFObeOFp4Lj3r8J5dY0e2/ZTtohPdATCR0MlPWb8fa4CfZlGat
	 yMW5mscA1t4HFnEJbdVRWH+s=
Received: from rn.tnic (unknown [78.130.214.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id D4B2C40E01CF;
	Tue, 22 Apr 2025 17:16:36 +0000 (UTC)
Date: Tue, 22 Apr 2025 19:17:37 +0200
From: Borislav Petkov <bp@alien8.de>
To: Rama devi Veggalam <rama.devi.veggalam@amd.com>
Cc: linux-edac@vger.kernel.org, git-dev@amd.com, michal.simek@amd.com,
	radhey.shyam.pandey@amd.com
Subject: Re: [PATCH 0/6] Add support for Versal Xilsem edac
Message-ID: <20250422171737.GAaAfPMbFtNKN6paJT@renoirsky.local>
References: <20250422162347.3217007-1-rama.devi.veggalam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250422162347.3217007-1-rama.devi.veggalam@amd.com>

A couple of notes only after a cursory look:

On Tue, Apr 22, 2025 at 09:53:41PM +0530, Rama devi Veggalam wrote:
> Add sysfs interface for Xilsem scan operations
> initialize, start, stop scan, error inject, read ECC and
> configuration values. Handle correctable and uncorrectable
> xilsem error events.

We added recently a whole pile of sysfs scrubbing APIs - I'm sure you
can reuse those without reinventing the wheel:

https://lore.kernel.org/all/20250212143654.1893-1-shiju.jose@huawei.com

> Rama devi Veggalam (6):
>   dt-bindings: edac: Add bindings for Xilinx Versal EDAC for XilSem
>   Documentation: ABI: Add ABI doc for xilsem edac sysfs
>   include: linux: firmware: Add XilSem error events
>   firmware: xilinx: Add support for Xilsem scan operations
>   edac: xilinx: Add EDAC support for Xilinx XilSem
>   MAINTAINERS: Add maintainers fragment for XILSEM

Do

git log drivers/edac/

and see how EDAC patches are named and how their commit messages are
written.

>  .../ABI/testing/sysfs-driver-xilsem-edac      |  104 ++
>  .../edac/xlnx,versal-xilsem-edac.yaml         |   42 +
>  MAINTAINERS                                   |    6 +
>  drivers/edac/Kconfig                          |   16 +
>  drivers/edac/Makefile                         |    1 +
>  drivers/edac/xilinx_xilsem_edac.c             |  779 ++++++++++++
>  drivers/firmware/xilinx/zynqmp.c              |   91 ++
>  drivers/soc/xilinx/xlnx_event_manager.c       |    8 +-
>  .../linux/firmware/xlnx-versal-error-events.h |  663 ++++++++++
>  .../firmware/xlnx-versal-net-error-events.h   | 1125 +++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h          |   29 +

Also, use scripts/get_maintainer.pl to figure out who to Cc on your
patches.

Also, take a look at https://www.kernel.org/doc/html/latest/process/submitting-patches.html

>  11 files changed, 2862 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-xilsem-edac
>  create mode 100644 Documentation/devicetree/bindings/edac/xlnx,versal-xilsem-edac.yaml
>  create mode 100644 drivers/edac/xilinx_xilsem_edac.c

We already have versal_edac.c. Why is this a separate module and why
can't this be part of former?

There's also another Versal EDAC piece in flight:

https://lore.kernel.org/all/20250106053358.21664-1-shubhrajyoti.datta@amd.com

How does yours relate?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

